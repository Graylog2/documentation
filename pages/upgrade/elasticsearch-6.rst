.. _es6_reindex:

*****************************
Elasticsearch 6 Upgrade Notes
*****************************


Upgrades from Elasticsearch 2.x direct to the latest Elasticsearch 6.x are not supported. Only the upgrade from Elasticsearch 5.x is supported and covered by this document.

At first check if the data in Elasticsearch need to be re-indexed::

    $ http :9200/_settings | \
     jq '[ path(.[] |select(.settings.index.version.created < "5000000"))[] ]'

The above example uses the tools `httpie <https://httpie.org/>`__ and `jq <https://stedolan.github.io/jq/>`__ to query the Elasticsearch API and check if any indices are created with Elasticsearch prior to Version 5. If that returns any index names, you need to re-index your data to make them work with Elasticseach 6.

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
3. Wait until all shards are initialized after updating ES (:ref:`Cmd <check_all_shards_initialized>`)
    * If the active write index is still a 2.x ES index, a manual index rotation needs to be triggered
4. Upgrade to Graylog 2.5 (2.5.1 at time of writing)
5. Update the index template for every index set to the latest ES 6 one by using the Graylog HTTP API. (otherwise a user has to rotate the active write index just to install the latest index template)
6. Check which indices have been created with ES 2.x and need re-indexing (:ref:`Cmd <collect_outdated_indices>`)
    * For each index to re-index perform the :ref:`Reindexing Procedure <es_reindexing_procedure>`.
7. Delete old re-index tasks from ES (:ref:`Cmd <es_reindex_cleanup>`)
8. Upgrade to the latest ES 6.x version. (6.8.1 as of this writing)
   
