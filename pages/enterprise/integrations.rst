************
Integrations
************

Graylog Enterprise includes the following integrations. An additional Integrations installation package is required (TBD).

* `Palo Alto Networks Input (TCP)`_


Palo Alto Networks Input (TCP)
------------------------------

This input allows Graylog to receive ``SYSTEM``, ``THREAT`` and ``TRAFFIC`` logs directly from a Palo Alto device
and the Palo Alto Panorama system. Logs are sent with a typical Syslog header followed by a comma-separated list of fields. The
fields order might change between version of [PAN OS](https://www.paloaltonetworks.com/documentation/81/pan-os).

Example ``SYSTEM`` message::

    <14>1 2018-09-19T11:50:35-05:00 Panorama-1 - - - - 1,2018/09/19 11:50:35,000710000506,SYSTEM,general,0,2018/09/19 11:50:35,,general,,0,0,general,informational,"Deviating device: Prod--2, Serial: 007255000045717, Object: N/A, Metric: mp-cpu, Value: 34",1163103,0x0,0,0,0,0,,Panorama-1

To get started, add a new Palo Alto Networks Input (TCP) in the ``System`` > ``Inputs`` area in Graylog. Specify the
Graylog Node, Bind address, Port, and adjust the field mappings as needed.

This input ships with a field configuration that is compatible with [PAN OS 8.1](https://www.paloaltonetworks.com/documentation/81/pan-os).
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

The mappings built into the plugin by default are based on the following PAN OS 8.1 specifications. If you are running
PAN OS 8.1, then there is no need to edit the mappings. However, if you are running a different version of PAN OS,
please reference the official Palo Alto Networks log fields documentation that that version and customize the mappings
on the Add/Edit Input page accordingly.

We have included a links to a few recent versions here for reference.

Version 8.1

* `Traffic Log Fields <https://www.paloaltonetworks.com/documentation/81/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/traffic-log-fields>`_
* `Threat Log Fields <https://www.paloaltonetworks.com/documentation/81/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/threat-log-fields>`_
* `System Log Fields <https://www.paloaltonetworks.com/documentation/81/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/system-log-fields>`_

Version 8.0

* `Traffic Log Fields <https://www.paloaltonetworks.com/documentation/80/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/traffic-log-fields>`_
* `Threat Log Fields <https://www.paloaltonetworks.com/documentation/80/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/threat-log-fields>`_
* `System Log Fields <https://www.paloaltonetworks.com/documentation/80/pan-os/pan-os/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/system-log-fields>`_

Version 7.1

* `Traffic Log Fields <https://www.paloaltonetworks.com/documentation/71/pan-os/pan-os/monitoring/syslog-field-descriptions#41809>`_
* `Threat Log Fields <https://www.paloaltonetworks.com/documentation/71/pan-os/pan-os/monitoring/syslog-field-descriptions#67983>`_
* `System Log Fields <https://www.paloaltonetworks.com/documentation/71/pan-os/pan-os/monitoring/syslog-field-descriptions#74679>`_

Also see `Documentation for older PAN OS versions <https://www.paloaltonetworks.com/documentation/eol>`_.
