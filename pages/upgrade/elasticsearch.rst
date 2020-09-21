.. _es_reindex:

******************************
Elasticsearch Reindexing Notes
******************************

.. contents:: Overview
   :depth: 3
   :backlinks: top

This page contains a list of commands which can be used to assist you in reindexing indices on new versions of Elasticsearch.

.. _es_reindexing_procedure:

Reindexing procedure
--------------------

These steps describe how to reindex an index on Elasticsearch. The detailed reference commands which can be used (after adjusting them to your specific details) are linked after each step.

  1. Check that the index is not the active write index (:ref:`Cmd <check_if_index_is_write_index>`)
  2. Create a re-index target index: <index-name>_reindex (e.g. graylog_0_reindex) (with correct settings for shards and replicas) (:ref:`Cmd <create_new_index>`)
  3. Check that mapping and settings of the new index are correct (:ref:`Cmd <check_mapping>`)
  4. Start re-index task in ES (using requests_per_second URL param and size param in the payload to avoid overloading the ES cluster) (:ref:`Cmd <start_reindex>`)
  5. Check progress of re-index task and wait until it is done (:ref:`Cmd <check_reindex_progress>`)
  6. Check that the document counts in the old and the new index match (:ref:`Cmd <compare_document_counts>`)
  7. Delete old index (:ref:`Cmd <delete_old_index>`)
  8. Recreate the old index: <index-name> (e.g. graylog_0) (with correct settings for shards and replicas) (:ref:`Cmd <recreate_old_index>`)
  9. Check that mapping and settings of the new index are correct (:ref:`Cmd <check_new_mapping>`)
  10. Start re-index task in ES to re-index documents back into the old index (using requests_per_second URL param and size param in the payload to avoid overloading the ES cluster) (:ref:`Cmd <start_reindex_for_old_index>`)
  11. Check that the document counts in the old and the new index match (:ref:`Cmd <compare_new_document_counts>`)
  12. Recreate Graylog index ranges for the old index (:ref:`Cmd <create_index_range_for_recreated_index>`)
  13. Delete temporary re-index target index (e.g. graylog_0_reindex (:ref:`Cmd <delete_temporary_reindex_target>`)


Detailed list of commands
-------------------------

.. note:: This is not a copy&paste tutorial and you need to read and adjust the commands to your local needs. We use the tools `httpie <https://httpie.org/>`__ and `jq <https://stedolan.github.io/jq/>`__ in the following commands.

Prerequisites
^^^^^^^^^^^^^

.. _check_es_versions:

Check ES versions of all nodes
""""""""""""""""""""""""""""""
The ES version needs to be the same on all ES nodes in the cluster before we can start the re-index process!::

    http ":9200/_cat/nodes?v&h=name,ip,version"

.. _check_all_shards_initialized:

Check that all shards are initialized ("green")
"""""""""""""""""""""""""""""""""""""""""""""""

All shards need to be initialized before we can start the re-index process.::

    http ":9200/_cat/indices?h=health,status,index" | grep -v '^green'

Update Graylog index templates in Elasticsearch
"""""""""""""""""""""""""""""""""""""""""""""""

The index templates that Graylog writes to Elasticsearch need to be updated before we can start the re-index process.::

    http post :9000/api/system/indexer/indices/templates/update x-requested-by:httpie

.. _collect_outdated_indices:

Collect indices that need a re-index to work with ES 6
""""""""""""""""""""""""""""""""""""""""""""""""""""""

All indices which have not been created with ES 5 need to be re-index to work with ES 6. (or deleted if they are not needed anymore...)::

    http :9200/_settings | jq '[ path(.[] | select(.settings.index.version.created < "5000000"))[] ]'

Re-Index commands for every index
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following commands need to be executed for every index that needs to be re-indexed. Replace the graylog_0 index name in the examples below with the index name you are currently working on.

.. _check_if_index_is_write_index:

Check if index is an active write index
"""""""""""""""""""""""""""""""""""""""

We should never re-index the active write target because that index is actively written to. If the active write index is still a 2.x ES index, a manual index rotation needs to be triggered.::

    http :9200/*_deflector/_alias | jq 'keys'

.. _create_new_index:

Create new index
""""""""""""""""

The new index needs to be created before it can be used as a re-index target. The request needs to include the correct settings for the number of shards and replicas. These settings can be different for each index set! (actual settings can be found in the Graylog "System / Indices" page for each index set)::

    http put :9200/graylog_0_reindex settings:='{"number_of_shards":4,"number_of_replicas":0}'

.. _check_mapping:

Check mapping and index settings
""""""""""""""""""""""""""""""""

Use these commands to check if the settings and index mapping for the new index are correct.::

    http :9200/graylog_0_reindex/_mapping
    http :9200/graylog_0_reindex/_settings

.. _start_reindex:

Start re-index process
""""""""""""""""""""""
This command starts the actual re-index process. It will return a task ID that can be used to check the progress of the re-index task in Elasticsearch.

The size value in the payload is the batch size that will be used for the re-index process. It defaults to 1000 and can be adjusted to tune the re-indexing process.::

    http post :9200/_reindex wait_for_completion==false source:='{"index":"graylog_0","size": 1000}' dest:='{"index":"graylog_0_reindex"}'

The re-index API supports the requests_per_second URL parameter to throttle the re-index process. This can be useful to make sure that the re-index process doesn't take too much resources. See this document for an explanation on how the parameter works: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docs-reindex.html#_url_parameters_3::

    http post :9200/_reindex wait_for_completion==false requests_per_second==500 source:='{"index":"graylog_0","size": 1000}' dest:='{"index":"graylog_0_reindex"}'

.. _check_reindex_progress:

Wait for the re-index to complete and check re-index progress
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

The re-index progress can be checked with the following command using the task ID that has been returned by the re-index request.::

    http :9200/_tasks/<task-id>

.. _compare_document_counts:

Compare documents in the old and new index
""""""""""""""""""""""""""""""""""""""""""

Before we continue, we should check that all documents have been re-indexed into the new index by comparing the document counts.::

    http :9200/graylog_0/_count
    http :9200/graylog_0_reindex/_count

.. _delete_old_index:

Delete old index
""""""""""""""""

Now delete the old index so we can recreate it for re-indexing.::

    http delete :9200/graylog_0

.. _recreate_old_index:

Recreate old index
""""""""""""""""""

Recreate the old index again so we can use it as a re-index target. The request needs to include the correct settings for the number of shards and replicas. These settings can be different for each index set! (actual settings can be found in the Graylog "System / Indices" page for each index set)::

    http put :9200/graylog_0 settings:='{"number_of_shards":4,"number_of_replicas":0}'

.. _check_new_mapping:

Check mapping and index settings
""""""""""""""""""""""""""""""""

Use these commands to check if the settings and index mapping for the recreated index are correct.::

    http :9200/graylog_0/_mapping
    http :9200/graylog_0/_settings

.. _start_reindex_for_old_index:

Start re-index process for old index
""""""""""""""""""""""""""""""""""""

This command starts the re-index process to move back the documents into the old index. It will return a task ID that can be used to check the progress of the re-index task in Elasticsearch.

The size value in the payload is the batch size that will be used for the re-index process. It defaults to 1000 and can be adjusted to tune the re-indexing process.::

    http post :9200/_reindex wait_for_completion==false source:='{"index":"graylog_0_reindex","size": 1000}' dest:='{"index":"graylog_0"}'

The re-index API supports the requests_per_second URL parameter to throttle the re-index process. This can be useful to make sure that the re-index process doesn't take too much resources. See this document for an explanation on how the parameter works: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docs-reindex.html#_url_parameters_3::

    http post :9200/_reindex wait_for_completion==false requests_per_second==500 source:='{"index":"graylog_0_reindex","size": 1000}' dest:='{"index":"graylog_0"}'

.. _compare_new_document_counts:

Compare documents in the old and new index
""""""""""""""""""""""""""""""""""""""""""

Before we continue, we should check that all documents have been re-indexed into the re-created old index by comparing the document counts with the temporary index.::

    http :9200/graylog_0/_count
    http :9200/graylog_0_reindex/_count

.. _create_index_range_for_recreated_index:

Create index range for the recreated index
""""""""""""""""""""""""""""""""""""""""""
Graylog needs to know about the recreated index by creating an index range for it.::

    http post :9000/api/system/indices/ranges/graylog_0/rebuild x-requested-by:httpie

.. _delete_temporary_reindex_target:

Delete temporary re-index target index
""""""""""""""""""""""""""""""""""""""

The temporary re-index target index can now be deleted because we don't use it anymore.::

    http delete :9200/graylog_0_reindex


.. _es_reindex_cleanup:

Cleanup
^^^^^^^

The re-index process leaves some tasks in Elasticsearch that need to be cleaned up manually.

Find completed re-index tasks for deletion
""""""""""""""""""""""""""""""""""""""""""

Execute the following command to get all the tasks we should remove.::

    http :9200/.tasks/_search | jq '[.hits.hits[] | select(._source.task.action == "indices:data/write/reindex" and ._source.completed == true) | {"task_id": ._id, "description": ._source.task.description}]'

Remove completed re-index tasks
"""""""""""""""""""""""""""""""

Execute the following command for every completed task ID.
Re-Index Commands::

    http delete :9200/.tasks/task/<task-id>

