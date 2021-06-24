.. _es7_reindex:

*****************************
Elasticsearch 7 Upgrade Notes
*****************************

When you are upgrading your Elasticsearch version to v7.x, you need to consider if all of your existing indices will still be readable, as Elasticsearch only supports indices created by the last two major versions and drops support for older formats. If all of your currently existing indices have been created on your current major version and you are upgrading from at least Elasticsearch v6.0.0, then you are fine. If you do know that you have older indices or you are unsure, it is best to check before doing the upgrade.

Let us say you want to upgrade to Elasticsearch 7. The oldest index version it supports is from ES6.0.0. The internal version representation for this is `6000000` (`major version * 1000000`).

Now let us check if we have any indices created by a version older than that::

    $ http localhost:9200/_settings | \
     jq '[ path(.[] |select(.settings.index.version.created < "6000000"))[] ]'


The above example uses the tools `httpie <https://httpie.org/>`__ and `jq <https://stedolan.github.io/jq/>`__ to query the Elasticsearch API at `localhost`, port `9200`. Please adjust the command to your Elasticsearch server's URL and the required version.

If this command returns any index names, those are indices which will not be readable after the upgrade and need a reindex before they work with the next major version.

Upgrade without re-index
========================

When no re-index is needed the easiest way is to follow the `elastic upgrade guide for Elasticsearch <https://www.elastic.co/guide/en/elasticsearch/reference/7.x/restart-upgrade.html>`__ this gives all needed commands. Please use the guide corresponding to your version.

Upgrade with re-index
=====================

If you have identified any incompatible indices in the previous step, those need to be reindexed. First a brief overview what steps need to be performed followed by the list of commands. Once you started the process of reindex your data you need to finish all steps to get a working Graylog and Elasticsearch cluster again.

1. Upgrade to the latest patch release of your current Graylog.
2. If you have not been on Elasticsearch 6 before, please follow the :ref:`es6_reindex`.
3. Upgrade to Graylog 4.x. All of your pre-existing custom index mapping templates should still exist.
4. (Optional) Reindex indices on ES7 that were created on ES6, so the upgrade to ES8 will be painless. Use the :ref:`Reindexing Procedure <es_reindexing_procedure>` steps.

