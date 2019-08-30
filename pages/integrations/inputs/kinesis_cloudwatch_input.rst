.. _kinesis_cloudwatch_input:

************************
Kinesis/CloudWatch Input
************************

.. note:: This input is available since Graylog version 3.1.1. Installation of an additional ``graylog-integrations-plugins`` package is required. See the :doc:`Integrations Setup <../setup>` page for more info.

.. attention:: An understanding of how AWS `CloudWatch <https://docs.aws.amazon.com/cloudwatch/>`_ and `Kinesis <https://docs.aws.amazon.com/kinesis/>`_. works is required.

This input allows Graylog to read log messages from CloudWatch via Kinesis. When reading logs from CloudWatch, Kinesis
is required in order to stream messages to Graylog.

The following message types are supported:

    - CloudWatch Logs
       Raw text strings within in Cloudwatch.
    - CloudWatch Flow Logs
       Flow Logs within a Cloud Watch log group.
    - Kinesis Raw Logs
       Raw text strings written to Kinesis.


Manual Setup Flow
^^^^^^^^^^^^^^^^^

For this setup to function as expected, the Least Privilege Policy shown below must be allowed for the authorized user. (See image below.)

1) AWS Kinesis Authorize
    Type in input name, AWS Access Key, AWS Secret Key and select AWS Region in order to authorize Graylog. See image below.

2) AWS Kinesis Setup
    Select the Kinesis stream to pull logs from (or Click Setup Kinesis Automatically and follow the instructions below).

3) AWS CloudWatch Health Check
    Graylog will read a message from the Kinesis stream and check it's format. We'll automatically parse the
       message if it's a Flow Log.

4) AWS Kinesis Review
    Final step to review and finalize the details for the input.

.. image:: /images/aws_kinesis_authorize.png
    :scale: 33 %
    :align: center

.. image:: /images/aws_kinesis_setup_default.png
    :scale: 40 %
    :align: center





Automatic Setup Flow
^^^^^^^^^^^^^^^^^^^^
When adding the AWS Kinesis/CloudWatch input to Graylog, you will be guided throughout the setup process.

 1) AWS Kinesis Authorize
    Type in input name, AWS Access Key, AWS Secret Key and select AWS Region in order to authorize Graylog.

2) AWS Kinesis Setup
    Click the Setup Kinesis Automatically button.

3) AWS CloudWatch Health Check
   Graylog will read a message from the Kinesis stream and check it's format. Graylog will attempt to automatically
   parse the message if it is of a known type.

4) AWS Kinesis Review
    Final step to review and finalize the details for the input.


.. image:: /images/aws_permissions_manual_setup.png
    :scale: 30 %
    :alt: Least Privilege Policy
    :align: left

.. image:: /images/aws_permissions_autosetup.png
    :scale: 30 %
    :alt: Recommended Policy
    :align: center
