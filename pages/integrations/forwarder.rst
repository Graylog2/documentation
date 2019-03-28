.. _forwarder:

*****************
Graylog Forwarder
*****************

.. note:: This input is available since Graylog version 3.0.1. Installation of an additional ``graylog-plugin-enterprise-integrations`` package and an enterprise license is required. See the :doc:`Integrations Setup <setup>` page for more info.

The Graylog Forwarder provides the ability to forward messages from one Graylog cluster to another over HTTP/2.
The Graylog Forwarder may be used for a variety of use cases, but the most common is to centralize log messages
from multiple Graylog instances. Messages are forwarded at the very end of the message processing pipeline in the
source Graylog cluster (at the same time as they are written to Elasticsearch).

The Graylog Forwarder has a built-in disk journal, which allows messages to persisted and queued to disk when the
remote Forwarder input is unavailable.

Components
----------
Two components are required for the Forwarder to operate: The Forwarder Output and the Forwarder Input.

Forwarder Output
~~~~~~~~~~~~~~~~
The Forwarder Output must exist in the source Graylog cluster. It is responsible for forwarding messages to the
Forwarder Input in the destination cluster.

Forwarder Input
~~~~~~~~~~~~~~~
The Forwarder Input must exist in the destination Graylog cluster. It is responsible for receiving messages from the
source Graylog cluster.

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
keep receiving and reliably queuing messages, even if the remote Graylog cluster is temoporarily unavailable due to
network issues.

Load Balancing
--------------
The Forwarded uses HTTP/2 (gRPC) for transport. Each Concurrent Network Sender establishes one connection to the remote
Forwarder input. Load balancing will direct each of these sender connections persistently to a back-end host. The load
is spread by using multiple senders for which connections are distributed amongst the available back-end hosts.
See `Load Balancing gRPC <https://grpc.io/blog/loadbalancing>`__ for more information.