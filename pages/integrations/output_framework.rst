.. _output_framework:

***************************
Enterprise Output Framework
***************************

The Enterprise Output Framework provides the ability to forward data from your Graylog 
cluster to external systems using a variety of network transport methods and payload 
formats. In addition, you can configure Framework-based Outputs to use 
:doc:`Processing Pipelines <../pipelines/pipelines>` to filter, modify, and enrich the 
outbound messages.

.. note:: This is an Enterprise Integrations feature and is only available since Graylog 
          version 3.3.3, thus an Enterprise license is required. See the 
          :doc:`Integrations Setup <setup>` page for more info.

Enterprise Framework Outputs
----------------------------

The Enterprise Output Framework provides a number of new Outputs for the various network 
transport types. All of these Outputs first write messages to an on-disk journal in the 
Graylog cluster.  Messages stay in the on-disk journal until the Output is able to 
successfully send the data to the external receiver.

Once the messages have been written to the journal, they are optionally run through a 
processing pipeline to modify or enrich logs with additional data, transform the message
contents, or filter out any some logs before sending.

Following the processing pipeline, the output payload is converted to the desired format 
and then sent using the selected transport method.

Messages are only passed to the Output Framework once they are done being processed in the 
Graylog source cluster, at the same time the data is written to Elasticsearch.

**On-Disk Journal**

The Output Framework is equipped with a disk journal. This journal immediately persists 
messages received from the Graylog Output system to disk before attempting to send them to
the external receiver. This allows the Output Framework to keep receiving and reliably 
queuing messages, even if the external receiver is temporarily unavailable due to
network issues. The journal has many configuration options which will be described below.

By default, journal data for Framework Outputs will be stored in the same directory used
for the Input journal.  This directory is controlled by the ``message_journal_dir`` value
in your Graylog configuration file.

**Pipeline Integration**

When creating or editing a Framework-based Output, you will have the option to select 
a processing pipeline which will be executed on each message coming from the source 
:doc:`stream <../streams>`. This pipeline can be used to filter out messages that you do
not wish to forward.  It can also be used to add data to modify the contents of the outgoing
message or to enrich it with additional data.

**Outbound Payload Formatting**

Prior to sending data out over the wire, Graylog must format the outgoing payload. Payload
formatting options include:

- **JSON**: The Output Framework will convert the message's key-value pairs into a JSON object.
- **Pipeline-Generated**: The Output Framework will expect your pipeline to generate the 
  outgoing payload and store it in the ``pipeline_output`` field of the message.  This can 
  be accomplished in the pipeline by using the ``set_field`` :doc:`built-in function<../pipelines/functions>`.

**Output Transports**

- **Enterprise STDOUT**: Formatted messages will be displayed on the system's console. 
  This is included primarily as a debugging tool for pipeline changes.
- **Enterprise TCP Raw/Plaintext**: Formatted messages will be sent as UTF-8 encoded plain 
  text to the configured TCP endpoint (IP address and port).
- **Enterprise TCP Syslog**: Formatted messages will be sent as the ``MSG`` portion of a 
  standard Syslog message per section 6.4 of the `Syslog specification <https://tools.ietf.org/html/rfc5424>`_.  
  The Syslog message will be sent to the configured TCP endpoint (IP address and port).


Output Configuration
--------------------

The Enterprise Output Framework is capable of processing messages at very high throughput 
rates. Many hardware factors will affect throughput (such as CPU clock speed, number of 
CPU cores, available memory, and network bandwidth). Several Output Framework configuration 
options are available to help you tune performance for your throughput requirements and 
environment.

General Configuration
^^^^^^^^^^^^^^^^^^^^^

- ``Title``
   - The name of the Output
- ``Send Buffer Size``
   - The number of messages the Output can hold in its buffer waiting to be written to the Journal
- ``Concurrent message processing pipelines``
   - The number of pipeline instances that will be allowed to run at any given time.  
   - If this is set to 0, pipeline execution will be skipped even if a pipeline is selected from the Pipeline dropdown.
- ``Concurrent output payload formatters``
   - The number of formatter instances that will be allowed to run at any given time.  
   - If this is set to 0, the Output will fail.
- ``Concurrent message senders``
   - The number of sender instances that will be allowed to run at any given time.  
   - If this is set to 0, the Output will fail.
- ``Journal Segment Size``
   - The soft maximum for the size of a journal segment file
- ``Journal Segment Age``
   - The maximum amount of time journal segments will be retained if there is storage to do so
- ``Maximum Journal Size``
   - The maximum size of the journal
- ``Maximum Journal Message Age``
   - The maximum time that a message will be stored in the disk journal
- ``Journal Buffer Size``
   - The size of the memory buffer for messages waiting to be written  to the journal. 
   - This value must be a power of two.
- ``Journal Buffer Encoders``
   - The number of concurrent encoders for messages being written to the journal.
- ``Output Processing Pipeline``
   - The pipeline which will process all messages sent to the Output
- ``Outbound Payload Format``
   - The format that will be used for outgoing message payloads



TCP Configuration
^^^^^^^^^^^^^^^^^

- ``Destination IP Address``
   - The IP address of the system which will receive the messages.
- ``Destination Port``
   - The port on which the destination system will listen for messages.
- ``Frame Delimiting Method``
   - The method which will be used to separate individual messages  in the stream.
   - Frame delimiting methods are defined in Sections 3.4.1 and 3.4.2 of `IETF RFC 6587 <https://tools.ietf.org/html/rfc6587>`_.
      - ``Newline Character`` A newline character will be appended to each message to mark the end of the message. Any newline characters within the message will be escaped prior to sending.
      - ``Null Character`` A null character will be appended to each message to mark the end of  the message. Any null characters within the message will be escaped prior to sending.
      - ``Octet Counting`` The length of the message (in bytes) and a space character for separation will be prepended to the message.  The contents of the message will not be altered.

TCP Syslog Configuration
^^^^^^^^^^^^^^^^^^^^^^^^

- ``Syslog Facility``
   - A numeric value in the range of 0 - 23 (inclusive)
   - Defined in `Section 6.2.1 <https://tools.ietf.org/html/rfc5424#section-6.2.1>`_ of the Syslog specification.
- ``Syslog Severity``
   - A numeric value in the range of 0 - 7 (inclusive)
   - Defined in `Section 6.2.1 <https://tools.ietf.org/html/rfc5424#section-6.2.1>`_ of the Syslog specification.

