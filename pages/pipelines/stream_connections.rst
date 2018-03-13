******************
Stream connections
******************

Overview
========

Pipelines by themselves do not process any messages. For a pipeline to actually do any work it must first be connected to one or more streams,
which enables fine-grained control of the messages processed by that pipeline.

Note that the built-in function ``route_to_stream`` causes a message to be routed to a particular stream. After the routing occurs, the pipeline
engine will look up and start evaluating any pipelines connected to that stream.

Although pipelines can trigger other pipelines via message routing, incoming messages must be processed by an initial set of pipelines
connected to one or more streams.

The All messages stream
=======================

.. _default_stream:

All messages received by Graylog are initially routed into the **All messages** stream. You can use this stream as the entry point to
pipeline processing, allowing incoming messages to be routed to more streams and being processed subsequently.

However, if you prefer to use the original stream matching functionality (i.e. stream rules), you can configure the *Pipeline Processor* to run after the
*Message Filter Chain* (in the *Message Processors Configuration* section of the *System -> Configurations* page) and connect pipelines to existing streams.
This gives you fine-grained control over the extraction, conversion, and enrichment process.

The importance of message processor ordering
============================================
It's important to note that the order of message processors may have a significant impact on how your messages get processed.

For example: *Message Filter Chain* is responsible for setting static fields and running extractors defined on inputs, as well as evaluation of stream rules.
If you create a pipeline that expects the presence of a static field, but the *Pipeline Processor* runs before *Message Filter Chain*,
that field will not be available for use in your pipeline.

When designing your streams and pipelines be aware of the message processor order, especially if you have dependencies on earlier message processing.
