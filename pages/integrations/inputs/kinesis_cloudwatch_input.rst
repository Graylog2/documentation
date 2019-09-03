.. _kinesis_cloudwatch_input:

************************
Kinesis/CloudWatch Input
************************

.. note:: This input is available since Graylog version 3.1.1. Installation of an additional ``graylog-integrations-plugins`` package is required. See the :doc:`Integrations Setup <../setup>` page for more info.

.. attention:: An understanding of how AWS `CloudWatch <https://docs.aws.amazon.com/cloudwatch/>`_ and `Kinesis <https://docs.aws.amazon.com/kinesis/>`_. works is required.

This input allows Graylog to read log messages from CloudWatch via Kinesis. When reading logs from CloudWatch, Kinesis
is required in order to stream messages to Graylog.

    The following message types are supported:

        CloudWatch Logs
           Raw text strings within in Cloudwatch.
        CloudWatch Flow Logs
           Flow Logs within a Cloud Watch log group.
        Kinesis Raw Logs
           Raw text strings written to Kinesis.


Manual Setup Flow
=================

For this setup to function as expected, the Least Privilege Policy shown below must be allowed for the authorized user.
(See `Permission Policies`_ below)

1) AWS Kinesis Authorize
    Type in input name, AWS Access Key, AWS Secret Key and select AWS Region in order to authorize Graylog and click
    the **Authorize & Choose Stream** button to continue. (See image below.)

2) AWS Kinesis Setup
    Select the Kinesis stream to pull logs from and click the **Verify Stream & Format** button to continue.

3) AWS CloudWatch Health Check
    Graylog will read a message from the Kinesis stream and check it's format. We'll automatically parse the message if it's a Flow Log.

4) AWS Kinesis Review
    Final step to review and finalize the details for the input.

.. image:: /images/aws_kinesis_authorize.png
    :scale: 33 %
    :align: center

.. image:: /images/aws_kinesis_setup_default.png
    :scale: 40 %
    :align: center


Automatic Setup Flow
====================

When adding the AWS Kinesis/CloudWatch input to Graylog, you will be guided throughout the setup process. For this
setup to function as expected, the Recommended Policy shown below must be allowed for the authorized user.
(See `Permission Policies`_ below)

1) AWS Kinesis Authorize
    Type in input name, AWS Access Key, AWS Secret Key and select AWS Region in order to authorize Graylog and click
    the **Authorize & Choose Stream** button to continue. (See image above)

2) AWS Kinesis Setup
    In the blue dialog box (seen in the image above), click the **Setup Kinesis Automatically** button. Type in a name
    for the Kinesis stream name, and select a Cloudwatch log Group from the dropdown list and click the **Begin Automated Setup** button.

    You will be prompted with   *Kinesis Auto Setup Agreement* and will need to acknowledge that you are aware of the
    resources that will be created and click the **I Agree! Create these AWS resources now.** button. (See images below)

    Once agreed and acknowledge, the auto-setup will detail and reference the resources that were created and you can
     click the **Continue Setup** button. (see *Executing Auto-Setup* image below)

3) AWS CloudWatch Health Check
    Graylog will read a message from the Kinesis stream and check it's format. Graylog will attempt to automatically parse the message if it is of a known type.

4) AWS Kinesis Review
    Final step to review and finalize the details for the input.

.. image:: /images/aws_kinesis_setup_auto.png
    :scale: 40 %
    :align: center

.. image:: /images/aws_kinesis_auto_setup_agreement.png
    :scale: 40 %
    :align: left


.. image:: /images/aws_kinesis_execute_auto_setup.png
    :scale: 25 %
    :align: right



Permission Policies
===================

Manual Setup Flow Permissions

.. image:: /images/aws_permissions_manual_setup.png
    :scale: 30 %
    :align: left


Automatic Setup Flow Permissions

.. image:: /images/aws_permissions_autosetup.png
    :scale: 30 %
    :align: left




