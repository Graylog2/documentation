*******************
Using queue systems
*******************

Using Apache Kafka as transport queue
=====================================

Graylog supports `Apache Kafka <http://kafka.apache.org>`__ as a transport for various inputs such as GELF, syslog, and Raw/Plaintext inputs. The Kafka topic can be filtered by a regular expression and depending on the input, various additional settings can be configured.

Learn how to use rsyslog and Apache Kafka in the `Sending syslog via Kafka into Graylog guide <https://marketplace.graylog.org/addons/113fd1cb-f7d2-4176-b427-32831bd554ee>`__.

Using RabbitMQ (AMQP) as transport queue
========================================

Graylog supports `AMQP <https://www.amqp.org>`__ as a transport for various inputs such as GELF, syslog, and Raw/Plaintext inputs. It can connect to any AMQP broker supporting `AMQP 0-9-1 <https://www.rabbitmq.com/amqp-0-9-1-reference.html>`_ such as `RabbitMQ <https://www.rabbitmq.com/>`__.

Learn how to use rsyslog and RabbitMQ in the `Sending syslog via AMQP into Graylog guide <https://marketplace.graylog.org/addons/246dc332-7da7-4016-b2f9-b00f722a8e79>`__.
