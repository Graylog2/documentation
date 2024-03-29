**************************
Upgrading to Graylog 4.1.x
**************************

.. _upgrade-from-40-to-41:

.. contents:: Overview
   :depth: 3
   :backlinks: top

.. warning:: Please make sure to create a MongoDB database backup before starting the upgrade to Graylog 4.1!

TLS Changes
===========

Graylog is now using only ciphers that considered secure (at this time of writing) when TLS v1.2 or greater is enabled. (see `#10653 <https://github.com/Graylog2/graylog2-server/pull/10653>`__ and `#10985 <https://github.com/Graylog2/graylog2-server/pull/10985>`__) Only TLSv1.2 and TLSv1.3 are enabled in the default Graylog configuration.

This could lead to problems with legacy TLS implementations connecting to Graylog. (e.g. older Syslog daemon versions connecting to a Graylog Syslog input)

To enable older ciphers again and work around problems with legacy TLS implementations, the ``enabled_tls_protocols`` option can be adjusted to include TLS v1.1.

Example::

    enabled_tls_protocols = TLSv1.1,TLSv1.2

Breaking Changes
================

The semantics of the limit parameter in the legacy search API (``/search/universal/(absolute|keyword|relative)``) have changed
to fix an inconsistency introduced in ``4.0``: prior to ``4.0``, ``0`` meant "no limit", with ``4.0`` this changed to ``-1``
and ``0`` for "empty result". With 4.1 this has been fixed to work again like in the past but the underlying
``Searches#scroll`` method has been tagged as ``@deprecated`` now, too.

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
