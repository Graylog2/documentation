**************************
Upgrading to Graylog 4.1.x
**************************

.. _upgrade-from-40-to-41:

.. contents:: Overview
   :depth: 3
   :backlinks: top

.. warning:: Please make sure to create a MongoDB database backup before starting the upgrade to Graylog 4.1!

Breaking Changes
================

Changes to the Elasticsearch Support
------------------------------------

Prior to v4.0 and in v4.0 without version probing for the Elasticsearch version, Graylog continues connecting to ES until it is successfull.
When you have version-probing for the used Elasticsearch version enabled, and Graylog starts up but can not connect to ES, the startup stopped 
immediately with v4.0. Starting from 4.1 the default behaviour is, that Graylog retries connecting with a delay until it can connect to Elasticsearch 
making the behaviour consistent again. See the Elasticsearch configuration_ page for details.

.. _configuration: https://docs.graylog.org/en/4.1/pages/configuration/elasticsearch.html

Configuration options: ``elasticsearch_version_probe_attempts`` and ``elasticsearch_version_probe_delay``.

Configuration file changes
--------------------------

The system stats collector has been reimplemented using OSHI instead of SIGAR.
The configuration option `disable_sigar` has been renamed to `disable_native_system_stats_collector`.
