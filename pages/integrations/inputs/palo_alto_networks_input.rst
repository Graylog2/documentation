.. _palo_alto_network_input:

************************
Palo Alto Networks Input
************************

.. note:: This input is available since Graylog version 2.5.0. Installation of an additional ``graylog-integrations-plugins`` package is required. See the :doc:`Integrations Setup <../setup>` page for more info.

This input allows Graylog to receive ``SYSTEM``, ``THREAT`` and ``TRAFFIC`` logs directly from a Palo Alto device
and the Palo Alto Panorama system. Logs are sent with a typical Syslog header followed by a comma-separated list of fields. The
fields order might change between versions of `PAN OS <https://www.paloaltonetworks.com/documentation/81/pan-os>`_.

Example ``SYSTEM`` message::

    <14>1 2018-09-19T11:50:35-05:00 Panorama-1 - - - - 1,2018/09/19 11:50:35,000710000506,SYSTEM,general,0,2018/09/19 11:50:35,,general,,0,0,general,informational,"Deviating device: Prod--2, Serial: 007255000045717, Object: N/A, Metric: mp-cpu, Value: 34",1163103,0x0,0,0,0,0,,Panorama-1

To get started, add a new Palo Alto Networks Input (TCP) in the ``System`` > ``Inputs`` area in Graylog. Specify the
Graylog Node, Bind address, Port, and adjust the field mappings as needed.

This input ships with a field configuration that is compatible with `PAN OS 8.1 <https://www.paloaltonetworks.com/documentation/81/pan-os>`_.
Other versions can easily be supported by customizing the ``SYSTEM``, ``THREAT`` and ``TRAFFIC`` mappings on the Add/Edit
input page in Graylog.

The configuration for each message type is a CSV block that must include the ``position``, ``field``, and ``type`` headers.

For example::

    position,field,type
    1,receive_time,STRING
    2,serial_number,STRING
    3,type,STRING
    4,content_threat_type,STRING
    5,future_use1,STRING
    ...

Accepted values for each column:


============  ===============
Field         Accepted Values
============  ===============
``position``  A positive integer value.
``field``     A contiguous string value to use for the field name. Must not include the reserved field names: ``_id``, ``message``, ``full_message``, ``source``, ``timestamp``,  ``level``, ``streams``
``type``      One of the following supported types: ``BOOLEAN``, ``LONG``, ``STRING``
============  ===============

The validity of each CSV configuration is checked when the Palo Alto input is started. If the CSV is malformed (or
contains invalid properties), the input will fail to start. An error describing the specific issue will be logged in
the ``graylog-server`` log file and also displayed at the top of the ``http://<grayloghost>/system/overview`` page for
the affected node.

For example:

.. image:: /images/integrations/input_failed_to_start.png

The mappings for each type look like this on the add/edit input page:

.. image:: /images/integrations/system_message_mappings.png

The mappings built into the plugin by default are based on the following PAN OS 8.1 specifications. If you are running
PAN OS 8.1, then there is no need to edit the mappings. However, if you are running a different version of PAN OS,
please reference the official Palo Alto Networks log fields documentation that that version and customize the mappings
on the Add/Edit Input page accordingly.

We have included a links to a few recent versions here for reference.

Version 8.1

* `8.1 - Traffic Log Fields <https://www.paloaltonetworks.com/documentation/81/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/traffic-log-fields>`_
* `8.1 - Threat Log Fields <https://www.paloaltonetworks.com/documentation/81/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/threat-log-fields>`_
* `8.1 - System Log Fields <https://www.paloaltonetworks.com/documentation/81/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/system-log-fields>`_

Version 8.0

* `8.0 - Traffic Log Fields <https://www.paloaltonetworks.com/documentation/80/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/traffic-log-fields>`_
* `8.0 - Threat Log Fields <https://www.paloaltonetworks.com/documentation/80/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/threat-log-fields>`_
* `8.0 - System Log Fields <https://www.paloaltonetworks.com/documentation/80/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/system-log-fields>`_

Version 7.1

* `7.1 - Traffic Log Fields <https://www.paloaltonetworks.com/documentation/71/pan-os/pan-os/monitoring/syslog-field-descriptions#41809>`_
* `7.1 - Threat Log Fields <https://www.paloaltonetworks.com/documentation/71/pan-os/pan-os/monitoring/syslog-field-descriptions#67983>`_
* `7.1 - System Log Fields <https://www.paloaltonetworks.com/documentation/71/pan-os/pan-os/monitoring/syslog-field-descriptions#74679>`_

Also see `Documentation for older PAN OS versions <https://www.paloaltonetworks.com/documentation/eol>`_.
