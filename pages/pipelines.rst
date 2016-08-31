.. _pipelinestoc:

********************
Processing Pipelines
********************

Graylog's new processing pipelines plugin allows greater flexibility in routing, blacklisting, modifying and
enriching messages as they flow through Graylog.

.. warning:: This plugin is still under development and will not be as stable and fast as the rest of Graylog at this moment!

Pipelines and rules are no longer configuration for pre-build code (like extractors and stream rules are) but are represented as code,
much like Drools rules are. This gives them their great flexibility and extensibility.

The language itself is very simple and can be extended by functions, which are fully pluggable.

The following pages introduce the concepts of pipelines, rules, stream connections and the built in functions.

.. toctree::
   :titlesonly:

   pipelines/pipelines
   pipelines/rules
   pipelines/stream_connections
   pipelines/functions
   pipelines/usage
