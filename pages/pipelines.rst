.. _pipelinestoc:

********************
Processing Pipelines
********************

Graylog's new processing pipelines plugin allows greater flexibility in routing, blacklisting, modifying, and
enriching messages as they flow through Graylog.

Pipelines and rules are not configuration for pre-built code, as extractors and stream rules are, but are instead represented as code,
much like Drools rules. This gives them great flexibility and extensibility, and enables live changes to Graylog's message processing behavior.

The language used for pipeline rules is very simple and can be extended by functions, which are fully pluggable.

The following pages introduce the concepts of pipelines, rules, stream connections, and the built-in functions.

.. toctree::
   :titlesonly:

   pipelines/pipelines
   pipelines/rules
   pipelines/stream_connections
   pipelines/functions
   pipelines/usage
