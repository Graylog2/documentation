.. _ingest_data:

*******************
Sending in log data
*******************

A Graylog setup is pretty worthless without any data in it. This page explains the basic principles of getting your data into the system and also explains common fallacies.

What are Graylog message inputs?
================================

Message inputs are the Graylog parts responsible for accepting log messages. Some default messages types are available by default in Graylog. But it might be needed to install additional plugins to enable Graylog to receive particular messages.  

After choosing the input type in the Graylog web interface at ``System / Inputs``,  the input is launched without a restart of Graylog. Most environments will use the defaults for the inputs, but most inputs have a granular configuration available. Some can use TLS or authentication via certificates, and others can make use of a queuing system. 

Most environments will have one input of each type and ingest all messages of that type to the one input. But it might be needed to have multiple inputs of the same kind to allow some extractors to work only on specific messages. But the processing pipeline would allow us to work on ingested messages from different sources on the same input in different ways. But as every environment is different, Graylog is flexible and will enable you to adjust everything to your need and not let you change your setting to fit Graylog.

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

These listed inputs are not all native available in Graylog. Most are dedicated to an individual product or framework. The default inputs like Syslog, CEF, GELF, or the RAW/Plaintext are not listed individually.  

.. toctree::
   :titlesonly:

   sending/input/beats
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
