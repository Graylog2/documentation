*********
Pipelines
*********

.. warning:: This documentation is work in progress

Overview
========

Pipelines are the central concept which tie together the processing steps Graylog applies to your messages.

They contain rules and can be connected to streams, allowing fine grained control which processing is done on which kinds of messages.

Because processing rules are simply conditions followed by a list of actions and do not have control flow by themselves,
pipelines have one additional concept: stages.

Think of stages as groups of conditions and actions which need to run in order. All stages with the same priority run
at the same time across all connected pipelines. They provide the necessary control flow to decide whether or not to run the
rest of a pipeline.

Pipeline structure
==================

Internally pipelines are represented as code. Let's have a look at a simple example and understand what each part does::

    pipeline "My new pipeline"
    stage 1 match all
      rule "has firewall fields";
      rule "from firewall subnet";
    stage 2 match either
      rule "geocode IPs";
      rule "anonymize source IPs";
    end

This code snippet declares a new pipeline with the name ``My new pipeline`` which declares two stages.

Stages are run in the order of their given *priority* and aren't otherwise named. Stage priorities can be any integer, even negative ones.
This allows flexible ordering to run certain rules before or after others, even without modifying existing pipelines, which can
come in handy when dealing with changing data formats.

For example, if there was a second pipeline declared, which contained a stage with the priority 0, that would run before either
of the ones from the example. The order in which stages are declared is irrelevant, they are sorted according to their priority.

Stages then list the *rule references* they want to be executed as well as declaring whether *any or all* rules' conditions need to be satisfied to
continue to evalute the pipeline.

In our example, imagine rule *"has firewall fields"* checks for the presence of two message fields: ``src_ip`` and ``dst_ip`` but does not have
any actions to run. Then for messages that do not have both fields, the condition would be false, and the pipeline would be aborted after stage 1,
because the stage requires that *all* rules need to be satisfied. Stage 2 would not begin to run in this case. ``match either`` acts as an ``OR``
operator, only requiring a single (or more) rules to match. Actions are still being run for all matching rules, even if the pipeline stops
after the stage.

Rules are referenced by their names and can thus be shared among many different pipelines. The intention is to create building blocks which
then make it easier to process the data specific to your organization or use case.

Read more about :doc:`rules` in the next section.
