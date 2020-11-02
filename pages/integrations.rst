.. _integrations_plugins:

************
Integrations
************

.. toctree::
   :hidden:

   integrations/setup


Integrations are tools that help Graylog work with external systems. Integrations will typically be content packs, inputs, or lookup tables and can either be open source or Enterprise.

Reference the :doc:`Integrations Setup <integrations/setup>` document for installation instructions.

Below are the available features:


Open Source
^^^^^^^^^^^

* :ref:`AWS Kinesis/CloudWatch Input<aws_kinesis_cloudwatch_input>`
* :ref:`Palo Alto Network Input<palo_alto_network_input>`
* :ref:`IPFIX Input<ipfix_input>`

.. toctree::
   :hidden:

   integrations/inputs/aws_kinesis_cloudwatch_input
   integrations/inputs/palo_alto_networks_input
   integrations/inputs/ipfix_input

.. _integrations_enterprise:

Enterprise
^^^^^^^^^^
Enterprise Integrations plugin feature require an `Graylog Enterprise license <https://www.graylog.org/enterprise>`_ .
For a comprehensive list of available features included, see our  :ref:`Enterprise List page<enterprise_features>`

* :doc:`Forwarder <integrations/forwarder>`
* :ref:`Script Alert Notification<alert_notification_script>`

.. toctree::
   :hidden:

   integrations/forwarder
