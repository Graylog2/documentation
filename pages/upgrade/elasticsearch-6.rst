.. _es6_reindex:

*********************
Elasticsearch 6 notes
*********************


Upgrades from Elasticsearch 2.x direct to the latest Elasticsearch 6.x are not supported. Only the upgrade from Elasticsearch 5.x is supported and covered by this document.

At first check if the data in Elasticsearch need to be re-indexed::

    $ http :9200/_settings | \
     jq '[ path(.[] |select(.settings.index.version.created < "5000000"))[] ]'

The above example use the tools `httpie <https://httpie.org/>`__ and `jq <https://stedolan.github.io/jq/>`__ to query the Elasticsearch API and check if any indices are created with Elasticsearch prior to Version 5. If that returns any index names, you need to re-index your data to make them work with Elasticseach 6.

Upgrading to Elasticsearch 6 is always a `full-cluster-restart <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/restart-upgrade.html>`__ and all breaking changes need to checked carefully. Once started their is no going back or downgrade possible.

The `Elasticsearch breaking changes notes <https://www.elastic.co/guide/en/elasticsearch/reference/current/breaking-changes-6.0.html>`__ contain a complete list of changes in Elasticsearch that should be checked against your configuration. The most notable is the cluster name is no longer allowed in `path.data` (see `breaking changes in Elasticsearch 6 <https://www.elastic.co/guide/en/elasticsearch/reference/current/breaking-changes-6.0.html#_cluster_name_no_longer_allowed_in_path_data>`__) and the release of `Elasticseach OSS Packages <https://www.elastic.co/products/x-pack/open>`__. 

Upgrade without re-index
========================

When no re-index is needed the easiest way is to follow the `elastic upgrade guide for Elasticsearch <https://www.elastic.co/guide/en/elasticsearch/reference/6.5/restart-upgrade.html>`__ this gives all needed commands. 

Upgrade with re-index
=====================

First a brief overview what steps need to be performed followed by the list of commands. Once you started the process of reindex your data you need to finish all steps to get a working Graylog and Elasticsearch cluster again. 


1. Upgrade to Graylog latest 2.4 release (2.4.6 at time of writing)
2. Upgrade ES to the latest 5.6.x on all cluster nodes. (5.6.14 as of this writing)
    * See: https://www.elastic.co/guide/en/elasticsearch/reference/5.6/setup-upgrade.html
3. Wait until all shards are initialized after updating ES
    * If the active write index is still a 2.x ES index, a manual index rotation needs to be triggered
4. Upgrade to Graylog 2.5 (2.5.1 at time of writing)
5. Update the index template for every index set to the latest ES 6 one by using the Graylog HTTP API. (otherwise a user has to rotate the active write index just to install the latest index template)
6. Check which indices have been created with ES 2.x and need re-indexing
    * For each index to re-index do the following
    	* Check that index is not the active write index
    	* Create a re-index target index: <index-name>_reindex (e.g. graylog_0_reindex) (with correct settings for shards and replicas)
    	* Check that mapping and settings of the new index are correct
    	* Start re-index task in ES (using requests_per_second URL param and size param in the payload to avoid overloading the ES cluster)
    	* Check progress of re-index task and wait until it is done
    	* Check that the document counts in the old and the new index match
    	* Delete old index
    	* Recreate the old index: <index-name> (e.g. graylog_0) (with correct settings for shards and replicas)
    	* Check that mapping and settings of the new index are correct
    	* Start re-index task in ES to re-index documents back into the old index (using requests_per_second URL param and size param in the payload to avoid overloading the ES cluster)
    	* Check that the document counts in the old and the new index match
    	* Recreate Graylog index ranges for the old index
    	* Delete temporary re-index target index (e.g. graylog_0_reindex)
7. Delete old re-index tasks from ES
8. Upgrade to the latest ES 6.x version. (6.5.1 as of this writing) 
   
Detailed list of commands
-------------------------

.. note:: This is not a copy&paste tutorial and you need to read and adjust the commands to your local needs. We use the tools `httpie <https://httpie.org/>`__ and `jq <https://stedolan.github.io/jq/>`__ in the following commands.

Prerequisites
^^^^^^^^^^^^^

Check ES versions of all nodes
""""""""""""""""""""""""""""""
The ES version needs to be the same on all ES nodes in the cluster before we can start the re-index process!::

    http ":9200/_cat/nodes?v&h=name,ip,version"

Check that all shards are initialized ("green")
"""""""""""""""""""""""""""""""""""""""""""""""

All shards need to be initialized before we can start the re-index process.::

    http ":9200/_cat/indices?h=health,status,index" | grep -v '^green'

Update Graylog index templates in Elasticsearch
"""""""""""""""""""""""""""""""""""""""""""""""

The index templates that Graylog writes to Elasticsearch need to be updated before we can start the re-index process.::

    http post :9000/api/system/indexer/indices/templates/update x-requested-by:httpie

Collect indices that need a re-index to work with ES 6
""""""""""""""""""""""""""""""""""""""""""""""""""""""

All indices which have not been created with ES 5 need to be re-index to work with ES 6. (or deleted if they are not needed anymore...)::

    http :9200/_settings | jq '[ path(.[] | select(.settings.index.version.created < "5000000"))[] ]'

Re-Index commands for every index
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following commands need to be executed for every index that needs to be re-indexed. Replace the graylog_0 index name in the examples below with the index name you are currently working on.

Check if index is an active write index
"""""""""""""""""""""""""""""""""""""""

We should never re-index the active write target because that index is actively written to. If the active write index is still a 2.x ES index, a manual index rotation needs to be triggered.::

    http :9200/*_deflector/_alias | jq 'keys'

Create new index
""""""""""""""""

The new index needs to be created before it can be used as a re-index target. The request needs to include the correct settings for the number of shards and replicas. These settings can be different for each index set! (actual settings can be found in the Graylog "System / Indices" page for each index set)::

    http put :9200/graylog_0_reindex settings:='{"number_of_shards":4,"number_of_replicas":0}'

Check mapping and index settings
""""""""""""""""""""""""""""""""

Use these commands to check if the settings and index mapping for the new index are correct.::

    http :9200/graylog_0_reindex/_mapping
    http :9200/graylog_0_reindex/_settings

Start re-index process
""""""""""""""""""""""
This command starts the actual re-index process. It will return a task ID that can be used to check the progress of the re-index task in Elasticsearch.

The size value in the payload is the batch size that will be used for the re-index process. It defaults to 1000 and can be adjusted to tune the re-indexing process.::

    http post :9200/_reindex wait_for_completion==false source:='{"index":"graylog_0","size": 1000}' dest:='{"index":"graylog_0_reindex"}'

The re-index API supports the requests_per_second URL parameter to throttle the re-index process. This can be useful to make sure that the re-index process doesn't take too much resources. See this document for an explanation on how the parameter works: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docs-reindex.html#_url_parameters_3::

    http post :9200/_reindex wait_for_completion==false requests_per_second==500 source:='{"index":"graylog_0","size": 1000}' dest:='{"index":"graylog_0_reindex"}'

Wait for the re-index to complete and check re-index progress
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

The re-index progress can be checked with the following command using the task ID that has been returned by the re-index request.::

    http :9200/_tasks/<task-id>

Compare documents in the old and new index
""""""""""""""""""""""""""""""""""""""""""

Before we continue, we should check that all documents have been re-indexed into the new index by comparing the document counts.::

    http :9200/graylog_0/_count
    http :9200/graylog_0_reindex/_count

Delete old index
""""""""""""""""

Now delete the old index so we can recreate it for re-indexing.::

    http delete :9200/graylog_0

Recreate old index
""""""""""""""""""

Recreate the old index again so we can use it as a re-index target. The request needs to include the correct settings for the number of shards and replicas. These settings can be different for each index set! (actual settings can be found in the Graylog "System / Indices" page for each index set)::

    http put :9200/graylog_0 settings:='{"number_of_shards":4,"number_of_replicas":0}'

Check mapping and index settings
""""""""""""""""""""""""""""""""

Use these commands to check if the settings and index mapping for the recreated index are correct.::

    http :9200/graylog_0/_mapping
    http :9200/graylog_0/_settings

Start re-index process for old index
""""""""""""""""""""""""""""""""""""

This command starts the re-index process to move back the documents into the old index. It will return a task ID that can be used to check the progress of the re-index task in Elasticsearch.

The size value in the payload is the batch size that will be used for the re-index process. It defaults to 1000 and can be adjusted to tune the re-indexing process.::

    http post :9200/_reindex wait_for_completion==false source:='{"index":"graylog_0_reindex","size": 1000}' dest:='{"index":"graylog_0"}'

The re-index API supports the requests_per_second URL parameter to throttle the re-index process. This can be useful to make sure that the re-index process doesn't take too much resources. See this document for an explanation on how the parameter works: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docs-reindex.html#_url_parameters_3::

    http post :9200/_reindex wait_for_completion==false requests_per_second==500 source:='{"index":"graylog_0_reindex","size": 1000}' dest:='{"index":"graylog_0"}'

Compare documents in the old and new index
""""""""""""""""""""""""""""""""""""""""""

Before we continue, we should check that all documents have been re-indexed into the re-created old index by comparing the document counts with the temporary index.::

    http :9200/graylog_0/_count
    http :9200/graylog_0_reindex/_count

Create index range for the recreated index
""""""""""""""""""""""""""""""""""""""""""
Graylog needs to know about the recreated index by creating an index range for it.::

    http post :9000/api/system/indices/ranges/graylog_0/rebuild x-requested-by:httpie

Delete temporary re-index target index
""""""""""""""""""""""""""""""""""""""

The temporary re-index target index can now be deleted because we don't use it anymore.::

    http delete :9200/graylog_0_reindex


Cleanup
^^^^^^^

The re-index process leaves some tasks in Elasticsearch that need to be cleaned up automatically.

Find completed re-index tasks for deletion
""""""""""""""""""""""""""""""""""""""""""

Execute the following command to get all the tasks we should remove.::

    http :9200/.tasks/_search | jq '[.hits.hits[] | select(._source.task.action == "indices:data/write/reindex" and ._source.completed == true) | {"task_id": ._id, "description": ._source.task.description}]'

Remove completed re-index tasks
"""""""""""""""""""""""""""""""

Execute the following command for every completed task ID.
Re-Index Commands::

    http delete :9200/.tasks/task/<task-id>


