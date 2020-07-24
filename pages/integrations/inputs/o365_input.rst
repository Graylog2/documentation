.. _o365_input:

***********************
Office 365 Integrations
***********************

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 3.3. A valid Graylog Enterprise license is required.
               It is meant for the hosted "online" office and do not use this to collect logs from a windows server, in your data center.

Prerequisites
=============
You have an application in Azure AD, a subscription to Office 365 and a subscription to Azure.

Why does this plugin exist ?
============================
Office 365 Integrations plugin, collects data from Windows Logs, Email, File Sharing and Data Loss Prevention Logs in one input.
This plugin retrieves data for each tenant, using continuous polling and stores the data(user activity) in elastic to detect threats.

How do I get this plugin running ?
==================================
you should be able to login into the following websites with your exempli@gratia.onmicrosoft.com account.

 - `office 365 <https://www.office.com/?auth=2>`_
 - `azure Portal <https://portal.azure.com/#home>`_
 - `turn on <https://protection.office.com/unifiedauditlog>`_ unified logging on friday and perform a search on monday,to see results.

once you login into Azure portal,you can obtain the essentials for running this plugin.Please collect items 1-3 from the azure portal.
Leave the defaults for the rest of the fields while navigating the **graylog-o365-input-plugin** wizard.You must be up and running with this input plugin(**Office 365 Log Events**)
in a few minutes.


1) Directory (tenant) ID
2) Application (client) ID
3) Client Secret
4) Enterprise and GCC Government plans is the most common subscription type.

This `input <http://localhost:8080/system/inputs>`_ plugin polls data internally using, https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-reference.
Watch the plugin `metrics <http://localhost:8080/system/metrics/node/node-id?filter=filterid>`_ to validate, if the `data <http://localhost:8080/search?q=gl2_source_input%3A5f1b38dc2fb55336f12afc1a&rangetype=relative&relative=0>`_ is flowing in .

Office 365 Integrations Landing Page

.. image:: /images/integrations/o365_landing_page.png
    :width: 600










