.. _o365_input:

***********************
Office 365 Integrations
***********************

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 3.3. A valid Graylog Enterprise license is required.
               It is meant for the hosted "online" office and do not use this to collect logs from a windows server, in your data center.

Why does this plugin exist ?
============================
Office 365 Integrations plugin, collects data from Windows Logs, Email, File Sharing and Data Loss Prevention Logs in one input.
Developing a client side SDK for Microsoft Management API is hard. Adopting Graylog open source product, will
fill the technological gap you experience due to lack of resources.

How do I get this plugin running ?
==================================
This input is very easy to set up. For beginners,have the top three information handy,and leave the defaults for the rest of the fields.
You must be up and running with this plugin in a few minutes.Please give yourself , 2-3 days to collect the details below and once you have
turned on unified logging, the logs will start flowing in.

1) Directory (tenant) ID
2) Application (client) ID
3) Client Secret
4) Enterprise and GCC Government plans is the most common subscription type.

This input plugin polls data internally using Management Activity Rest API. https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-reference.
Pay attention to this plugin `metrics` to see if the data is flowing in .

Office 365 Integrations Landing Page

.. image:: /images/integrations/o365_landing_page.png
    :width: 600

Frequently asked questions
==========================
How do I know if I have turn on Unified logging and it is working?
------------------------------------------------------------------

Go to https://protection.office.com/unifiedauditlog and perform a search. you will see some results.

What are the essentials for running this plugin ?
-------------------------------------------------

you have subscribed to https://www.office.com/?auth=2

once you login into Azure portal https://portal.azure.com/#home ,you can obtain the essentials for running this plugin.Please refer screenshot below, to get the required fields for running this plugin.

.. image:: /images/integrations/o365_graylog_credentials.png
    :width: 600

Can you give me an example of a microsoft account login ?
---------------------------------------------------------
cat@water.onmicrosoft.com

How do I know if the plugin is running ?


where do I see the metrics for this plugin ?


what happens if the plugin stops ?


Are there any failures that I will encounter while running this plugin ?



