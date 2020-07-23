.. _beats_input:

*****
Beats  
*****

Beats are open source data shippers. They are single-purpose tools. 
Some beats are created and maintained by the company elastic. Those listed in `this beats overview <https://www.elastic.co/guide/en/beats/libbeat/current/beats-reference.html>`__. The community creates an additional `wide range of beats <https://www.elastic.co/guide/en/beats/libbeat/current/community-beats.html>`__. Most of the beats should work out of the box with the Graylog beats input. But it might be needed to adjust the settings. 

For most beats, the logstash output is to send the messages to Graylog. For a beat, it makes no difference what receives the signals as long as it follows the protocol. 
The relatively new options to make use of a queue system are not (yet) implemented in Graylog so that the TCP input is the only option. 

This :ref:`input can make use of TLS<sec_graylog_beats>` and certificates for authentification. 
