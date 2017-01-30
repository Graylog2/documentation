******************
Stream connections
******************

Overview
========

Pipelines by themselves do not process any messages. Instead they can be connected to streams, allowing fine grained control
over which message types are being processed by which pipelines.

Using the built-in function ``route_to_stream`` a rule action can cause a message to be routed to the given stream. The pipeline
engine will then look up the pipelines connected to that stream and start evaluating the additional pipelines.

To begin processing pipelines the incoming messages must therefore be directed to the initial set of pipelines.

The All messages stream
=======================

.. _default_stream:

All messages received by Graylog are initially routed into the **All messages** stream. You can use this stream as the entry to
pipeline processing, allowing incoming messages to be routed to more streams and being processed subsequently.

However, if you prefer to use the original stream matching functionality, you can configure the pipeline processor to run after the
*message filter chain* and connect pipelines to existing streams. This gives you fine grained control over the extraction, conversion
and enrichment process.

