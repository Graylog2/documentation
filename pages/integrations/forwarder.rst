.. _forwarder:

*****************
Graylog Forwarder
*****************

.. note:: This input is available since Graylog version 3.0.1. Installation of an additional ``graylog-plugin-enterprise-integrations`` package and an enterprise license is required. See the :doc:`Integrations Setup <../setup>` page for more info.

The Graylog Forwarder provides the ability to forward messages from one Graylog cluster to another over HTTP/2.
The Graylog Forwarder may be used for a variety of use cases, but the most common is to centralize log messages
from multiple Graylog instances. Messages are forwarded at the very end of the message processing pipeline in the
source Graylog cluster (at the same time as they are written to Elasticsearch).

The Graylog Forwarder has a build in disk journal, which allows messages to persisted and queued to disk when the
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