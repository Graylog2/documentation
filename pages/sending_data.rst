.. _ingest_data:

*******************
Sending in log data
*******************

A Graylog setup is pretty worthless without any data in it. This page explains the basic principles of getting your data into the system and also explains common fallacies.

What are Graylog message inputs?
================================

Message inputs are the Graylog parts responsible for accepting log messages. They are launched from the web interface (or the REST API) in the *System -> Inputs* section and are launched and configured without the need to restart any part of the system.

The section about the different log sources describes how you ingest those types of logs; besides, some logs have individual inputs. Some of them are listed below in the individual inputs section. In addition to that, `the Graylog Marketplace <http://marketplace.graylog.org>`__ contains some inputs created by the community.  

Log sources
===========

We can't cover all possible options and device configurations in this section. The following describes the fundamentals of those inputs and the current best practice to ingest those kinds of messages into Graylog. Some can be done native others need some collector. The section will include one or two example collectors, but the free and open world has multiple more to offer, we can't cover all solutions. 

.. toctree::
   :titlesonly:

   sending/syslog
   sending/journald
   sending/windows
   sending/cef
   sending/raw
   sending/gelf
   sending/files
   sending/json
   sending/application

Individual Inputs
=================

.. toctree::
   :titlesonly:

   integrations/inputs/aws_kinesis_cloudwatch_input
   integrations/inputs/ipfix_input
   integrations/inputs/okta_input
   integrations/inputs/palo_alto_networks_input


Using Apache Kafka as transport queue
=====================================

Graylog supports `Apache Kafka <http://kafka.apache.org>`__ as a transport for various inputs such as GELF, syslog, and Raw/Plaintext inputs. The Kafka topic can be filtered by a regular expression and depending on the input, various additional settings can be configured.

Learn how to use rsyslog and Apache Kafka in the `Sending syslog via Kafka into Graylog guide <https://marketplace.graylog.org/addons/113fd1cb-f7d2-4176-b427-32831bd554ee>`__.

Using RabbitMQ (AMQP) as transport queue
========================================

Graylog supports `AMQP <https://www.amqp.org>`__ as a transport for various inputs such as GELF, syslog, and Raw/Plaintext inputs. It can connect to any AMQP broker supporting `AMQP 0-9-1 <https://www.rabbitmq.com/amqp-0-9-1-reference.html>`_ such as `RabbitMQ <https://www.rabbitmq.com/>`__.

Learn how to use rsyslog and RabbitMQ in the `Sending syslog via AMQP into Graylog guide <https://marketplace.graylog.org/addons/246dc332-7da7-4016-b2f9-b00f722a8e79>`__.



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
 #. Nothing is currently being written to the Journal; throttling will not occur. No further checks will be performed.
 #. Throttling will occur if the Journal is more than 90% full.
 #. Throttling will occur if the Journal write rate is more than twice as high as the read rate.
