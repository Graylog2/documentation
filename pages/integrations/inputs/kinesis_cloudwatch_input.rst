.. _kinesis_cloudwatch_input:

************************
Kinesis/CloudWatch Input
************************

.. note:: This input is available since Graylog version 3.1.1. Installation of an additional ``graylog-integrations-plugins`` package is required. See the :doc:`Integrations Setup <../setup>` page for more info.

This input allows Graylog to read log messages from Kinesis and CloudWatch. When reading logs from CloudWatch, Kinesis
is required in order to stream messages to Graylog.

The following message types are supported:

 - AWS CloudWatch Logs

 - AWS CloudWatch Flow Logs: AWS direct Flow Logs can be configured and delivered to a Cloud Watch log group of your choice.
   See these docs.

 - Kinesis Raw logs: Graylog can read and process raw text strings written to Kinesis.


Automatic Setup Flow:
When adding the AWS Kinesis/CloudWatch input to Graylog, you will guided through the setup process.

1) Enter input name and authorization details.

2) Choose a Kinesis stream to pull logs from (or choose Automatic Setup).

3) Health Check: Graylog will read a message from the Kinesis stream and check it's format. We'll automatically parse the
   message if it's a Flow Log.

4) Confirm your the input details and save.