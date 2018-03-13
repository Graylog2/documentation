*********
Pipelines
*********

Overview
========

Pipelines are the central concept tying together the processing steps applied to your messages.

Pipelines contain rules and can be connected to one or more streams, enabling fine-grained control of the processing applied to messages.

Processing rules are simply conditions followed by a list of actions, and do not have control flow by themselves.  Therefore, pipelines have one additional concept: stages.

Think of stages as groups of conditions and actions which need to run in order. All stages with the same priority run
at the same time across all connected pipelines. Stages provide the necessary control flow to decide whether or not to run the
remaining stages in a pipeline.

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

This code snippet declares a new pipeline named ``My new pipeline``, which has two stages.

Stages are ran in the order of their given *priority*, and aren't otherwise named. Stage priorities can be any integer, positive or negative, you prefer.
In our example the first stage has a priority of 1 and the second stage a priority of 2, however -99 and 42 could be used instead.
Ordering based upon stage priority gives you the ability to run certain rules before or after others, which might exist in other connected pipelines, without modifying those other connected pipelines.
This is particularly handy when dealing with changing data formats.

For example, if there was a second pipeline declared with a stage assigned priority 0, that stage's rules would run before either
of the ones from the example (priorities 1 and 2, respectively). Note that the order in which stages are declared is irrelevant, since they are sorted according to their priority.

Stages then list the *rule references* they want to be executed, as well as whether *any* or *all* of the rules' conditions need to be satisfied to
continue running the pipeline.

In our example, imagine rule *"has firewall fields"* checks for the presence of message fields ``src_ip`` and ``dst_ip``, but does not have
any actions to run. For a message without both fields the rule's condition would evaluate to ``false`` and the pipeline would abort after stage 1,
as the stage requires *all* rules be satisfied (``match all``). With the pipeline aborted, stage 2 would not run. 

``match either`` acts as an ``OR`` operator, only requiring a single rule's condition evaluate to ``true`` in order to continue pipeline processing.
Note that actions are still ran for all matching rules in the stage, even if it is the final stage in the pipeline.

Rules are referenced by their names, and can therefore be shared among many different pipelines. The intention is to enable creation of reusable building blocks,
making it easier to process the data specific to your organization or use case.

Read more about :doc:`rules` in the next section.
