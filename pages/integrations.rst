.. _integrations_plugins:

********************
Graylog Integrations
********************

.. toctree::
   :hidden:

   integrations/setup


Integrations are tools that help Graylog work with external systems. Integrations will typically be content packs, inputs, or lookup tables and can be either Open Source or Enterprise.

Reference the :doc:`Integrations Setup <integrations/setup>` document for installation instructions.

Below are the available features:


Open Source
^^^^^^^^^^^

* :ref:`AWS Kinesis/CloudWatch Input<aws_kinesis_cloudwatch_input>`
* :ref:`Palo Alto Network Input<palo_alto_network_input>`
* :ref:`IPFIX Input<ipfix_input>`
* :ref:`GreyNoise Data Adapter<greynoise_dataadapter>`


.. toctree::
   :hidden:

   integrations/inputs/aws_kinesis_cloudwatch_input
   integrations/inputs/palo_alto_networks_input
   integrations/inputs/ipfix_input
   integrations/greynoise_dataadapter

.. _integrations_enterprise:

Enterprise
^^^^^^^^^^
Enterprise Integrations features require a `Graylog Enterprise license <https://www.graylog.org/enterprise>`_ .
For a comprehensive list of available features included, see our  :ref:`Enterprise List page<enterprise_features>`

* :doc:`Cluster-to-Cluster Forwarder <integrations/cluster_to_cluster_forwarder>`
* :doc:`Enterprise Output Framework <integrations/output_framework>`
* :ref:`Script Alert Notification<alert_notification_script>`
* :ref:`Okta Log Events Input<okta_input>`
* :ref:`Office 365 Log Events Input<o365_input>`
* :ref:`GreyNoise Enterprise Data Adapter<greynoise__ent_dataadapter>`
* :ref:`ThreatFox IOC Tracker Data Adapter<lookups_threatfox>`
* :ref:`URLhaus Malware URL Data Adapter<lookups_urlhaus>`

.. toctree::
   :hidden:

   integrations/cluster_to_cluster_forwarder
   integrations/inputs/okta_input
   integrations/output_framework
   integrations/inputs/o365_input
   integrations/greynoise_dataadapter
   integrations/lookups/threatfox
   integrations/lookups/urlhaus
