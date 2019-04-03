.. _forwarder:

***********
Forwarder
***********

The Forwarder provides the ability to forward messages from one Graylog cluster source to another Graylog cluster destination
over HTTP/2.This allows for centralizing log messages from multiple distributed Graylog clusters into one. This also
allows for centralized alerting, reporting, and oversight of multiple Graylog clusters.

.. note:: This is an enterprise integration feature and is only available since Graylog version 3.0.1 and thus requires an enterprise license. See the :doc:`Integrations Setup <setup>` page for more info.

Overview
---------

Two Graylog clusters are required for this component, a Graylog cluster source (Forwarder Output) and a Graylog cluster
destination (Forwarder Input). The Graylog cluster source will allow message to be forwarded, and the Graylog cluster
destination will receive messages being forwarded.

Forwarder Output
^^^^^^^^^^^^^^^^^
The Forwarder Output (Graylog cluster source) is responsible for forwarding messages to the
Graylog cluster destination. It first writes the messages to an on-disk journal in the Graylog cluster source
(**Forwarder Output**). Messages stay in the on-disk journal until the Graylog cluster destination is available to receive messages.

Messages are only forwarded until after they are done being processed through the pipeline of the Graylog cluster
source, but simultaneously as they are written to Elasticsearch.

Forwarder Journal
^^^^^^^^^^^^^^^^^^^
The Forwarder is equipped with a disk journal. This journal immediately persists messages received from the Graylog
Output system to disk before attempting to send them to the remote Graylog cluster. This allows the Forwarder to
keep receiving and reliably queuing messages, even if the remote Graylog cluster is temporarily unavailable due to
network issues. The Journal has many configuration options (such as Maximum Journal Size) available and described on
the Edit Forwarder Output page.


Forwarder Input
^^^^^^^^^^^^^^^^

The Forwarder Input (Graylog cluster destination) is responsible for receiving messages that have been
forwarded from the Graylog cluster source.

When the Graylog cluster destination (Forwarder Input) receives the forwarded messages, the following relevant fields
are added in order to keep the integrity of the messages in tact.

* ``gl2_source_cluster_id``
    * The id of the source Graylog cluster.

* ``gl2_source_node_id``
    * The id of the source Graylog node.


Forwarder Output Options
------------------------

The Graylog Forwarder is capable of forwarding messages at very high throughput rates.
Many hardware factors will affect throughput (such as CPU clock speed, number of CPU cores, available memory, and
network bandwidth). Several Forwarder Output configuration options are also available to help you tune performance
for your throughput requirements and environment.

* ``Hostname``
    The destination host name or IP address where the Graylog Forwarder input is running.

* ``Port``
    The destination port that the Graylog Forwarder input is listening on.

* ``Journal Segment Size``
    The soft maximum for the size of a segment file in the log.

* ``Journal Segment Age``
    The disk journal segment age.

* ``Maximum Journal Size``
    The maximum size for the disk journal.

* ``Maximum Journal Message Age``
    The maximum time that a message will be stored in the disk journal.

* ``Journal Message Flush Interval``
    The number of messages that can be written to the log before a flush is forced.

* ``Maximum Journal Flush Age``
    The amount of time the log can have dirty data before a flush is forced.

* ``Journal Buffer Size``
    The size of the pre-journal buffer. This number must be a power of two. This number must be sufficiently large to
    avoid blocking the Graylog output system. Recommended value: 65536

* ``Number of Handlers Journal Buffer``
    The number of concurrent journal encoders. This prepares the messages to be written to the journal
    and is a fast operation. This number generally should not exceed the number of cores on a machine.

* ``Send Buffer Size``
    The size of the post-journal send buffer. This number must be a power of two.
    Recommended value: two times the Maximum Journal Read Batch Size rounded up to the next power of 2.

* ``Sender Encoders``
    The number of concurrent send encoders. These prepare the message to be sent over the network.
    This number generally should not exceed the number of cores on a machine.

* ``Concurrent Network Senders``
    The number of concurrent senders forwarding messages simultaneously. Each sender establishes one HTTP/2 connection.
    Use multiple senders to increase throughput and also take advantage of :ref:`load balancing<forwarder_load_balancing>`.
    The number of concurrent senders should not exceed the number of cores on a machine.

* ``GRPC Request Timeout``
    Request timeout for GRPC in milliseconds

* ``Maximum Journal Read Batch Size``
    The maximum number of messages read from the journal at once. Increase this value to reduce excessive disk I/O.
    Recommended range: 500-5000.

* ``Enable Compression``
    The option to compress messages when they are transported

* ``TLS Trusted Certificate Chain File``
    Path to the trusted certificate chain file for verifying the remote endpoint's certificate.
    The file should contain an X.509 certificate collection in PEM format.

* ``Enable TLS``
    Option to enable TLS.

Forwarder Input Options
------------------------

* ``Bind Address``
    Address to listen on. For example 0.0.0.0 or 127.0.0.1.

* ``Port``
    Port number to listen on

* ``Enable TLS``
    Option to enable TLS for connection

* ``TLS Trusted Certificate Chain File``
    Path to the trusted certificate chain file. The file should contain an X.509 certificate collection in PEM format.

* ``TLS Private Key File``
    Path to the TLS private key file. The file should be in PEM format

SSL/TLS
^^^^^^^^^
TLS encryption is supported to ensure secure transport of forwarded messages. You can enable it by checking the Enable
TLS check box on both the Forwarder input and output. The Forwarder Input requires that both the certificate and key
locations must be specified. The Forwarder Output requires only the certification location be specified.

.. note:: Only X.509 certificates and keys in PEM format are supported. TLS Authentication is not currently supported.

.. attention:: Having too many Concurrent Network Sender will increase message throughput, however it is the onus of the user to determine what is the appropriate number of concurrent network senders the Graylog cluster destination (Forwarder Input) can handle at once. Load balancing factors must be considered and determined by the user.
