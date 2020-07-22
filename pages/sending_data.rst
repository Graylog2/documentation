.. _ingest_data:

*******************
Sending in log data
*******************

A Graylog setup is pretty worthless without any data in it. This page explains the basic principles of getting your data
into the system and also explains common fallacies.

What are Graylog message inputs?
================================

Message inputs are the Graylog parts responsible for accepting log messages. They are launched from the web interface
(or the REST API) in the *System -> Inputs* section and are launched and configured without the need to restart any
part of the system.


Log sources
===========

.. toctree::
   :titlesonly:

   sending/syslog
   sending/journald
   sending/windows
   sending/files
   sending/raw
   sending/gelf
   sending/queue
   sending/json
   sending/application
   



.. _content_packs:

Content packs
=============

Content packs are bundles of Graylog input, extractor, stream, dashboard, and output configurations that can provide full support
for a data source. Some content packs are shipped with Graylog by default and some are available from the website. Content packs that
were downloaded from `the Graylog Marketplace <http://marketplace.graylog.org>`__ can be imported using the Graylog web interface.

You can load and even create own content packs from the *System -> Content Packs* section of your Graylog web interface.

Input Throttling
================

Throttling allows certain Graylog Inputs to slow their message intake rates (by temporarily pausing intake processing) if
contention occurs in the Graylog Journal.

Graylog Inputs that support throttling
--------------------------------------

 * AWS Flow Logs
 * AWS Logs
 * CEF AMQP Input
 * CEF Kafka Input
 * GELF AMQP
 * GELF Kafka
 * JSON path from HTTP API
 * Raw/Plaintext AMQP
 * Raw/Plaintext Kafka
 * Syslog AMQP
 * Syslog Kafka

Enabling throttling
-------------------

To enable throttling for one of these inputs, edit it in *System > Inputs* and check the *Allow throttling this input*
checkbox.

Throttling criteria
-------------------

When enabled, the following criteria will be used to determine if throttling will occur:

 #. If there are zero uncommitted entries in the Graylog Journal, throttling will not occur. No further checks will be performed.
 #. Throttling will occur if the Journal has more than 100k uncommitted entries.
 #. Throttling will occur if the Journal is growing in size rapidly (approximately 20k entries per second or greater).
 #. Throttling will occur if the process ring buffer is full.
 #. Nothing is currently being written to the Journal, throttling will not occur. No further checks will be performed.
 #. Throttling will occur if the Journal is more than 90% full.
 #. Throttling will occur if the Journal write rate is more than twice as high as the read rate.
