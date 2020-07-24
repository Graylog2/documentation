.. _o365_input:

***********************
Office 365 Integrations
***********************

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 3.3. A valid Graylog Enterprise license is required.


Office 365 Integrations plugin, collects data from Windows Logs, Email, File Sharing and Data Loss Prevention Logs in one input.

This input is very easy to set up. Once you have the top  three information handy, you must be up and running with this plugin in a few minutes.
Please give yourself , 2-3 days to collect the details below and once you have turned on unified logging, the logs will start flowing in.

1) Directory (tenant) ID,
2) Application (client) ID,
3) Client Secret,
4) Enterprise and GCC Government plans is the most common subscription type.
5) Leave the defaults for the rest of the fields .


This input plugin polls data internally using Management Activity Rest API. https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-reference.
Pay attention to this plugin `metrics` to see if the data is flowing in .

Office 365 Integrations Landing Page

.. image:: /images/integrations/o365_landing_page.png
    :width: 600