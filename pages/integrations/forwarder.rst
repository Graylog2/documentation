.. _forwarder:

*****************
Graylog Forwarder
*****************

.. note:: This input is available since Graylog version 3.0.1. Installation of an additional ``graylog-plugin-enterprise-integrations`` package and an enterprise license is required to use it. See the :doc:`Integrations Setup <setup>` page for more info.

The Graylog Forwarder provides the ability to forward messages from one Graylog cluster to another over HTTP/2.
The Graylog Forwarder may be used for a variety of use cases, but the most common is to centralize log messages
from multiple Graylog instances. Messages are forwarded at the very end of the message processing pipeline in the
source Graylog cluster (at the same time as they are written to Elasticsearch).

The Graylog Forwarder features an on-disk journal, which messages are written to before attempting to send over the
network to the destination Graylog cluster. This provides an extra layer of reliability in the case that the remote
Graylog cluster is temporarily unavailable.

Components
----------
Two components are required for the Forwarder to operate: The Forwarder Output and the Forwarder Input.

Forwarder Output
~~~~~~~~~~~~~~~~
The Forwarder Output must exist in the source Graylog cluster. It is responsible for forwarding messages to the
Forwarder Input in the destination cluster. Messages are written to an on-disk journal before they are sent over
the network.

Forwarder Input
~~~~~~~~~~~~~~~
The Forwarder Input must exist in the destination Graylog cluster. It is responsible for receiving messages from the
source Graylog cluster.

Throughput Considerations
-------------------------
The Graylog forwarder is capable of forwarding messages to a remote Graylog cluster at very high throughput rates.
Many hardware factors will affect throughput (such as CPU clock speed, number of CPU cores, available memory, and
network bandwidth). Several Forwarder Output configuration options are also available to help you tune performance
for your throughput requirements and environment.

Concurrent Network Senders
    The number of concurrent network senders. Each sender establishes one HTTP/2 connection. Use multiple senders to
    increase throughput and also take advantage of :ref:`load balancing<forwarder_load_balancing>`. Start with a low
    number, and increase gradually until throughput stops increasing. This number generally should not exceed the
    number of cores on a machine.

Journal Buffer Size
    The size of the pre-journal buffer. This number must be a power of two. This number must be sufficiently large to
    avoid blocking the Graylog output system. Recommended value: 65536

Number of Handlers Journal Buffer
    Encoders The number of concurrent journal encoders. This prepares the messages to be written to the journal
    and is a fast operation. This number generally should not exceed the number of cores on a machine.

Maximum Journal Read Batch Size
    The maximum number of messages read from the journal at once. Increase this value to reduce excessive disk I/O.
    Recommended range: 500-5000.

Sender Encoders
    The number of concurrent send encoders. These prepare the message to be sent over the network.
    This number generally should not exceed the number of cores on a machine.

Send Buffer Size
    The size of the post-journal send buffer. This number must be a power of two.
    Recommended value: two times the Maximum Journal Read Batch Size rounded up to the next power of 2.

TLS
---
TLS encryption is supported. You can enable it by checking the Enable TLS check box on both the Forwarder input and
output. The certificate and key must be specified on in the Forwarder input, and only the certificate is required
on the Forwarder output. Note that the following requirements apply when using TLS with the Forwarder.

* Only X.509 certificates and keys in PEM format are supported.

* TLS Authentication is not currently supported.

Forwarder Message Fields
------------------------
The following fields will be added to all forwarded messages when received in the destination Forwarder input.
You can use these in the destination Graylog cluster to identify where the messages originated from and perform
any desired actions (such as assigning to streams or running pipeline rules).

* ``gl2_source_cluster_id``
    * The id of the source Graylog cluster.

* ``gl2_source_node_id``
    * The id of the source Graylog node.

Forwarder Journal
-----------------
The Forwarder is equipped with a disk journal. This journal immediately persists messages received from the Graylog
Output system to disk before attempting to send them to the remote Graylog cluster. This allows the Forwarder to
keep receiving and reliably queuing messages, even if the remote Graylog cluster is temporarily unavailable due to
network issues. The Journal has many configuration options (such as Maximum Journal Size) available and described on
the Edit Forwarder Output page.

.. _forwarder_load_balancing:

Load Balancing
--------------
The Forwarder uses HTTP/2 (gRPC) for transport. Each Concurrent Network Sender establishes one connection to the remote
Forwarder input. Load balancing will direct each of these sender connections persistently to a back-end host. The load
is balanced by using multiple senders for which connections are distributed amongst the available back-end hosts.
See `Load Balancing gRPC <https://grpc.io/blog/loadbalancing>`__ for more information.