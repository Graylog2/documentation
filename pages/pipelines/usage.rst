*****
Usage
*****

Overview
========

Once you understand the concepts explained in :doc:`pipelines`, :doc:`rules`, and
:doc:`stream_connections`, you're ready to start creating your own processing pipelines. This
page gives you the information you need to get started with the user interface.

Configuration
=============

Configure the message processor
-------------------------------

Before start using the processing pipelines you need to ensure the *Pipeline Processor* message processor is enabled
and correctly configured. You can do so by going to the *System -> Configurations* page, and
checking the configuration in the *Message Processors Configuration* section.

.. image:: /images/pipelines_message_processor.png

On the Configurations page, you need to **enable the Pipeline Processor** message processor and, if you want your pipelines
to have access to static fields set on inputs and/or fields set by extractors, **set the Pipeline Processor after the Message Filter Chain**.

Manage rules
============

You can create, edit, and delete your pipeline rules in the `Manage rules` page, under
`System -> Pipelines`.

.. image:: /images/pipelines_manage_rules.png

Clicking on `Create Rule` or `Edit` in one of the rules will open a page where you can write
your own rule. The page lists available functions and their details to make the task a bit more manageable.

.. image:: /images/pipelines_edit_rule.png

Managing pipelines
==================

Once there are some rules in Graylog, you can create pipelines that use them to modify and enrich
your messages.

To manage your pipelines, access `Manage pipelines` page under `System -> Pipelines`.
This page is where you can create, edit, and delete pipelines.

.. image:: /images/pipelines_manage_pipelines.png

In order to create or edit pipelines, and as explained in :doc:`pipelines`, you need to add your
rules to a stage, which has a certain priority. The Web interface will let you add rules to the default
stage (priority 0), and to create new stages with potentially different priorities.

.. image:: /images/pipelines_show_pipeline.png

A pipeline can have more than one stage, and when you create or edit a stage you need to select how
to proceed to the next stage in the pipeline:

All rules on this stage match the message
  This option will only consider further stages in the pipeline when all conditions in rules
  evaluated in this stage are ``true``. This is equivalent to ``match all`` in the :doc:`pipelines`
  section.
At least one of the rules on this stage matches the message
  Selecting this option will continue to further stages in the pipeline when one or more of the
  conditions in rules evaluated in this stage are ``true``.  This is equivalent to ``match either`` in
  the :doc:`pipelines` section.

Connect pipelines to streams
============================

You can decide which streams are connected to a pipeline from the pipeline details page. Under
`System -> Pipelines`, click on the title of the pipeline you want to connect to a stream, and
then click on the `Edit connections` button.

.. image:: /images/pipelines_manage_connections.png

You can assign many pipelines to the same stream, in which case all connected pipelines will process messages routed into that stream
based upon the overall order of stage priorities.

.. image:: /images/pipelines_edit_connections.png

Remember, as mentioned in the :doc:`stream_connections` documentation, the `All messages` stream is where all messages are 
initially routed, and is therefore a good place to apply pipelines applicable to all of your messages. Such pipelines might be responsible for stream routing, blacklisting, field manipulation, etc.

Simulate your changes
=====================

After performing some changes in a processing pipeline, you most likely want to see how they are
applied to incoming messages. This is what the pipeline simulator is for.

Click the `Simulate processing` button under `System -> Pipelines` or in the pipeline details page
to access the pipeline simulator.

.. image:: /images/pipelines_simulation_1.png

In order to test the message processing you need to provide a raw message that will be routed into
the stream you want to simulate. The raw message should use the same format Graylog will
receive.  For example: you can type a :ref:`GELF <gelf>` message, in the same format your GELF library would send, in the `Raw message` field.
Don't forget to select the correct codec for the message you provide.

After specifying the message and codec, click `Load message` to start the simulation and display the results.

.. image:: /images/pipelines_simulation_2.png

The simulation provides the following results:

Changes summary
  Provides a summary of modified fields in the original message, as well as a list of added and dropped
  messages.
Results preview
  Shows all fields in the processed message.
Simulation trace
  Displays a trace of the processing, indicating which rules were evaluated and which were executed.
  It also includes a timeline, in microseconds, to allow you to see which rules and pipelines are
  taking up the most time during message processing.

