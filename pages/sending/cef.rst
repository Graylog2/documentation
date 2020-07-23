**********
Ingest CEF
**********

Most network and security systems support either Syslog or CEF (which stands for Common Event Format) over Syslog as means for sending data. The advantage of CEF over Syslog is that it ensures the data is normalized, making it more immediately useful.

The description of CEF is the following:
    CEF is an extensible, text-based format designed to support multiple device types by offering the most relevant information. CEF defines a syntax for log records comprising a standard header and a variable extension, formatted as key-value pairs. 

Graylog gives the option to have CEF messages over UDP, TCP, or Kafka and AMQP as a queuing system. If the sender does not include the timezone information, it is possible to configure the timezone the messages will arrive. That will not overwrite the timezone included in the timestamp; it will be the assumed time zone for messages that do not include the timezone information.
