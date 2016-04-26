******************
Stream connections
******************

.. warning:: This documentation is work in progress

Overview
========

Pipelines by themselves do not process any messages. Instead they can be connected to streams, allowing fine grained control
over which message types are being processed by which pipelines.

Using the built-in function ``route_to_stream`` a rule action can cause a message to be routed to the given stream. The pipeline
engine will then look up the pipelines connected to that stream and start evaluating the additional pipelines.

To begin processing pipelines the incoming messages must therefore be directed to the initial set of pipelines.

The default stream
==================

All messages received by Graylog are initially on what is called the *default stream*. This merely means they aren't routed to
any specific stream yet. The default stream by itself is no explicit stream, it doesn't show up anywhere, but the pipeline
processor still allows you to connect pipelines to it.

These initial pipelines are the entry to pipeline processing, allowing messages to be routed to more streams and being processed subsequently.

However, if you prefer to use the original stream matching functionality, you can configure the pipeline processor to run after the
*message filter chain* and connect pipelines to existing streams. This gives you fine grained control over the extraction, conversion
and enrichment process.

