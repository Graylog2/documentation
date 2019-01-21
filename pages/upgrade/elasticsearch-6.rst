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

Upgrade wiht re-index
=====================

 