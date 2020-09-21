**************************
Upgrading to Graylog 3.3.x
**************************

.. _upgrade-from-33-to-40:

.. contents:: Overview
   :depth: 3
   :backlinks: top

[BREAKING] Changes to the Elasticsearch Support
===============================================

Starting with Graylog v4.0, bigger changes to the Elasticsearch versions supported are happening:

  - Support for Elasticsearch versions prior to v6.8.0 are dropped.
  - Support for Elasticsearch v7.x is now included.

This means that you can upgrade to Graylog v4.0 without an Elasticsearch update only if you have been on at least Elasticsearch v6.8.0 before.
Additionally, due to the fact that Elasticsearch supports only indices created by the last two major versions (i.e. ES6.8.0+ reads indices created by ES5 & ES6, ES7 reads indices created by ES6 & ES7), you can change to Graylog v4.0 with an Elasticsearch update without reindexing only if you have been on at least Elasticsearch v6.0.0 before.
If you have been on any older Elasticsearch version you need to reindex every index you want to keep once for every two major versions of Elasticsearch up to at least ES6.

When upgrading Elasticsearch from one major version to another, please read the upgrade guides provided by elastic:

  - `To 6.8.0 <https://www.elastic.co/guide/en/elasticsearch/reference/6.8/setup-upgrade.html>`_
  - `To 7.9.0 <https://www.elastic.co/guide/en/elasticsearch/reference/7.9/setup-upgrade.html>`_

Please do notice that Graylog does not support rolling upgrades between major versions, while Elasticsearch does. If you are upgrading from one major version of Elasticsearch to another, you need to restart Graylog in order to reinitialize the storage module.

