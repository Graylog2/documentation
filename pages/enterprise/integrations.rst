************
Integrations
************

Graylog Enterprise includes the following integrations. An additional installation package is required (TBD).

- `Palo Alto Networks Input (TCP)`_


Palo Alto Networks Input (TCP)
------------------------------

This input allows Graylog to receive ``SYSTEM``, ``THREAT`` and ``TRAFFIC`` logs from both a Palo Alto device
and the Palo Alto Panorama system.


Both Palo Alto systems will send logs with a typical Syslog header followed by a comma-separated list of fields. The
fields order might change between version of [PAN OS](https://www.paloaltonetworks.com/documentation/81/pan-os).

This input ships with a field configuration that is compatible with [PAN OS 8.1](https://www.paloaltonetworks.com/documentation/81/pan-os).
Other versions can easily be supported by customizing the ``SYSTEM``, ``THREAT`` and ``TRAFFIC``
