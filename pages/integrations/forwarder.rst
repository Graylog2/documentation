.. _forwarder:

*********
Forwarder
*********

The Forwarder provides the ability to forward messages from a one Graylog cluster to another over HTTP/2.
This centralizes log messages from multiple distributed Graylog source clusters into one destination cluster,
which allows centralized alerting, reporting, and oversight.

Two Graylog clusters are required to use the Forwarder: A Graylog source cluster (Forwarder Output) and a Graylog
destination cluster (Forwarder Input). The Graylog source cluster will forward messages, and the Graylog
destination cluster will receive messages being forwarded.

.. note:: This is an Enterprise Integrations feature and is only available since Graylog version 3.0.1 and thus requires an Enterprise license. See the :doc:`Integrations Setup <setup>` page for more info.

Forwarder Output
----------------

The Forwarder Output (Graylog source cluster) is responsible for forwarding messages to the
Graylog destination cluster. It first writes the messages to an on-disk journal in the Graylog source cluster
(Forwarder Output). Messages stay in the on-disk journal until the Graylog destination cluster is available
to receive messages.

Messages are only forwarded until after they are done being processed through the pipeline of the Graylog source
cluster, but simultaneously as they are written to Elasticsearch.

**Forwarder Journal**

The Forwarder is equipped with a disk journal. This journal immediately persists messages received from the Graylog
Output system to disk before attempting to send them to the remote Graylog destination cluster. This allows the Forwarder to
keep receiving and reliably queuing messages, even if the remote Graylog destination cluster is temporarily unavailable due to
network issues. The Journal has many configuration options (such as Maximum Journal Size) available and described on
below.

Forwarder Output Options
^^^^^^^^^^^^^^^^^^^^^^^^

The Graylog Forwarder is capable of forwarding messages at very high throughput rates.
Many hardware factors will affect throughput (such as CPU clock speed, number of CPU cores, available memory, and
network bandwidth). Several Forwarder Output configuration options are also available to help you tune performance
for your throughput requirements and environment.


.. image:: /images/forwarder_output.png


Forwarder Input
---------------

The Forwarder Input (Graylog destination cluster) is responsible for receiving messages that have been
forwarded from the Graylog cluster source.

When the Graylog destination cluster (Forwarder Input) receives the forwarded messages, the following relevant fields
are added to help track which Graylog cluster and node the messages originated from.

* ``gl2_source_cluster_id``
    * The id of the source Graylog cluster.

* ``gl2_source_node_id``
    * The id of the source Graylog node.

Forwarder Input Options
^^^^^^^^^^^^^^^^^^^^^^^


.. image:: /images/forwarder_input.png

SSL/TLS
^^^^^^^
TLS encryption is supported to ensure secure transport of forwarded messages. You can enable it by checking the Enable
TLS check box on both the Forwarder input and output. The Forwarder Input requires that both the certificate and key
locations must be specified. The Forwarder Output requires only the certification location be specified.

.. note:: Only X.509 certificates and keys in PEM format are supported. TLS Authentication is not currently supported.

.. _forwarder_load_balancing:

Load Balancing
^^^^^^^^^^^^^^
The Forwarder uses HTTP/2 (gRPC) for transport. When only one Concurrent Network Sender is used,
then load balancing is not supported. However, if more than one Concurrent Network Senders are used, then
load balancing is supported, which allows each of these sender connections to be distributed to the destination host.
For more information see `Load Balancing gRPC <https://grpc.io/blog/loadbalancing>`__.

