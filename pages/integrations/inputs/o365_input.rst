.. _okta_input:

*********************
Office 365 Integrations
*********************

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 3.3. A valid Graylog Enterprise license is required.


Office 365 Integrations collects data from Windows Logs, Email, File Sharing and Data Loss Prevention Logs in one input.

This input is very easy to set up. Once you have the below three information handy , you must be up and running with the Input in a few minutes.
Please give 2-3 days to get all the details below and you have turned on unified logging, to get the logs flowing in.

1) Directory (tenant) ID,
2) Application (client) ID,
3) Client Secret,
4) Enterprise and GCC Government plans is the most common subscription type.
5) Leave the defaults for the rest of the fields .


This input plugin polls data internally using Management Activity Rest API. https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-reference.
Pay attention to the `metrics` to see if the data is flowing in .

Office 365 Integrations Landing Page

.. image:: /images/okta_input.png
    :width: 600