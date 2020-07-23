***********************
Ingest Windows eventlog
***********************


Some agents allow to send Windows event log via Syslog, others have a proprietary protocol implemented. Graylog can work with those that use Syslog as transport or that speak GELF. One collector that should be named is the `NXLog community edition <https://nxlog.co/products/nxlog-community-edition>`__ that can read the windows event log and forward that to Graylog via GELF. 

But the most recommended way is to make use of a `winlogbeat <https://www.elastic.co/guide/en/beats/winlogbeat/current/_winlogbeat_overview.html>`__. That is currently the best-known way to ingest windows event logs into Graylog. 

The collector can be configured manually, with any software configuration utility present in the environment, or the :ref:`Graylog Sidecar <graylog-sidecar>` can be used to configure and control the collectors. Even manual installation and configuration might fit the setting. 

To be able to ingest the messages to Graylog, one input is needed. That input needs to match the collector. For NXLog, it is much likely the GELF input, and for winlogbeat, it needs to be the :ref:`beats input <beats_input>`. 

One example winlogbeat configuration that reduce the noise. But still give enough insides::

			fields_under_root: true
			fields.collector_node_id: ${sidecar.nodeName}
			fields.gl2_source_collector: ${sidecar,nodeId}
			
			output.logstash:
			  hosts: ["graylog:5044"]

			winlogbeat.event_logs:
			  - name: Application
			    level: critical, error, warning
			    ignore_older: 48h
			  - name: Security
			    processors:
			        - drop_event.when.not.or:
			            - equals.event_id: 129
			            - equals.event_id: 141
			            - equals.event_id: 1102
			            - equals.event_id: 4648
			            - equals.event_id: 4657
			            - equals.event_id: 4688
			            - equals.event_id: 4697
			            - equals.event_id: 4698
			            - equals.event_id: 4720
			            - equals.event_id: 4738 
			            - equals.event_id: 4767
			            - equals.event_id: 4728
			            - equals.event_id: 4732
			            - equals.event_id: 4634
			            - equals.event_id: 4735
			            - equals.event_id: 4740
			            - equals.event_id: 4756
			    level: critical, error, warning, information
			    ignore_older: 48h
			  - name: System
			    processors:
			        - drop_event.when.not.or:
			            - equals.event_id: 129
			            - equals.event_id: 1022
			            - equals.event_id: 1033
			            - equals.event_id: 1034
			            - equals.event_id: 4624
			            - equals.event_id: 4625
			            - equals.event_id: 4633
			            - equals.event_id: 4719
			            - equals.event_id: 4738
			            - equals.event_id: 7000
			            - equals.event_id: 7022
			            - equals.event_id: 7024
			            - equals.event_id: 7031
			            - equals.event_id: 7034-7036
			            - equals.event_id: 7040
			            - equals.event_id: 7045
			    level: critical, error, warning
			    ignore_older: 48h
