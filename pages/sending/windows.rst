***********************
Ingest Windows eventlog
***********************


Some allow to send Windows event log via Syslog, others have a proprietary protocol implemented. Graylog can work with those that use Syslog as transport or that speak GELF. One collector that should be named is the `NXLog community edition <https://nxlog.co/products/nxlog-community-edition>`__ that can read the windows event log and forward that to Graylog via GELF. 

But the most recommended way is to make use of a `winlogbeat <https://www.elastic.co/guide/en/beats/winlogbeat/current/_winlogbeat_overview.html>`__. That is currently the best-known way to ingest windows event logs into Graylog. 

The collector can be configured manually, with any software configuration utility present in the environment, or the :ref:`Graylog Sidecar <graylog-sidecar>` can be used to configure and control the collectors.