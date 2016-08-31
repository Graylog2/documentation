*****
Usage
*****

.. warning:: This documentation is work in progress

Overview
========

Once you have understood the concepts explained in :doc:`pipelines`, :doc:`rules`, and
:doc:`stream_connections`, you are ready to start creating your own processing pipelines. This
page gives you the information you need to get started with the user interface.

Manage rules
============

You can create, edit, and delete your pipeline rules in the `Manage rules` page, under
`System -> Pipelines`.

.. image:: /images/pipelines_manage_rules.png

Clicking on `Create Rule` or `Edit` in one of the rules will open a page where you can write
your own rule, alongside with some documentation to make the task a bit more manageable.

.. image:: /images/pipelines_edit_rule.png

Managing pipelines
==================

Once there are some rules in Graylog, you can create pipelines that use them to modify and enrich
your messages.

To manage your pipelines, please access the `Manage pipelines` page, under `System -> Pipelines`.
From that page you can create new pipelines, edit existing pipelines, and delete pipelines you
don't need any more.


.. image:: /images/pipelines_manage_pipelines.png

In order to create or edit pipelines, and as explained in :doc:`pipelines`, you need to add your
rules into a stage with a certain priority. The Web Interface will let you add rules to the default
stage (0), and to create new stages with different priorities.

.. image:: /images/pipelines_show_pipeline.png

A pipeline can have more than one stage, and when you create or edit a stage you need to select how
to proceed to the next stage in the pipeline:

All rules on this stage match the message
  This option will only consider further stages in the pipeline when all conditions in rules
  evaluated in this stage are ``true``. This equals to ``match all`` in the :doc:`pipelines`
  section.
At least one of the rules on this stage matches the message
  Selecting this option will continue to further stages in the pipeline when one or more of the
  conditions in rules evaluated in this stage are ``true``.  This equals to ``match either`` in
  the :doc:`pipelines` section.

Connect pipelines to streams
============================

When you have created pipelines and connected rules to them, it's time to use those pipelines in
your system.

Manage the pipelines that are connected to streams by going to `System -> Pipelines`.

.. image:: /images/pipelines_manage_connections.png

Remember from the :doc:`stream_connections` documentation, that the `Default` stream is the one
where all messages not routed into another stream go.

You can assign many pipelines to the same stream, so they are all evaluated for all messages
routed into such stream.

.. image:: /images/pipelines_edit_connections.png

