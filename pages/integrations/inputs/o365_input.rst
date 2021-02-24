.. _o365_input:

**************************
Microsoft Office 365 Input
**************************

Microsoft Office 365 is a widely used cloud-based suite of productivity tools.  This plugin
allows you to pull your organization's Office 365 logs into Graylog for processing, 
monitoring, and alarming.

.. note:: This is a Graylog Enterprise Integrations feature and is only available since 
  Graylog version 3.3.3. A valid Graylog Enterprise license is required.

Required Office 365 Setup
-------------------------

Prerequisites
^^^^^^^^^^^^^

In order to use the Office 365 plugin, you will need to create and authorize a Client 
Application through your organization's Microsoft Azure portal.

It is assumed that you already have a working Office 365 subscription and access to the
Microsoft Azure portal for your organization.  It is also assumed you have the correct account type which allows access to the audit logs.  Generally this is an E5/A5 account.

The following steps are mandatory.

Azure Configuration
^^^^^^^^^^^^^^^^^^^

1) Log in to `Microsoft Azure <https://portal.azure.com/#home>`_
2) Navigate to ``Azure Active Directory`` in the left-hand menu
3) Select ``App Registrations`` under the **Manage** heading in the left-hand menu
4) Select ``New Registration`` in the top of the right-hand pane
5) Register a new application

   a) Provide a name for the application (i.e. "Graylog Log Access")
   b) Select the appropriate account type.  This should be either ``Single Tenant`` or 
      ``Multitenant`` depending on whether your organization has a single Active Directory instance or multiple
   c) Do not add a ``Redirect URI``
   d) Click the ``Register`` button
6) Once the application has been created, take note of the following fields, which will be needed to set up the O365 plugin:

   a) ``Application (client) ID``
   b) ``Directory (tenant) ID``
7) For the newly-created Application, navigate to ``Certificates & Secrets``
8) Click on ``New Client Secret``
9) Add a description for the new secret, select an expiration time, and then click ``Add``
10) Make a note of the generated value, you will need this to set up the O365 Plugin

Client Application Permissions in O365
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1) For the newly-created Application, navigate to ``API permissions``
2) Click on ``Add a permission``
3) Select ``Office 365 Management APIs``
4) Select ``Application Permissions``
5) Select all available permissions on the list and click ``Add permissions``
6) Click on ``Grant admin consent for...`` and confirm by clicking ``Yes`` in the popup dialog

Enable Unified Audit Logging
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Navigate to the `Audit Log Search page <https://protection.office.com/unifiedauditlog>`_
in Microsoft Office 365 and enable ``Unified Audit Logging``. If this is the first time enabling Unified Audit Log, it can take up to 24 hours before logs start coming into Graylog.

Plugin Configuration
--------------------

.. note:: You will need the ``Client ID``, ``Tenant ID``, and ``Client Secret`` from the 
   previous sections in order to proceed.

O365 Connection Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``Input Name``
   - Provide a unique name for your new O365 Input
- ``Directory (tenant) ID``
   - This is the ID of the Active Directory instance for which Graylog will collect log data
- ``Application (client) ID``
   - This is the ID of the Client Application created above
- ``Client Secret``
   - This is the client secret generated above
- ``Subscription Type``
	- This indicates what type of Office 365 subscription you have
	- ``Enterprise and GCC government plans`` is the most common value
	
O365 Content Subscription
^^^^^^^^^^^^^^^^^^^^^^^^^

- ``Log Types To Collect``
   - This determines which of the five available log types the Input will pull from Office 365 (Options are: AZURE_ACTIVE_DIRECTORY, SHAREPOINT, EXCHANGE, GENERAL, DLP_ALL)
- ``Polling Interval``
   - This determines how often (in minutes) the Input will check for new log data
   - This value cannot be less than 1 (checking every minute)
- ``Drop DLP logs containing sensitive data``
   - For each DLP event, O365 emits a summary log with no sensitive data and a detailed log with sensitive data.  When set, this option will cause the detailed logs to be dropped to prevent sensitive data from being stored in Graylog.  This option is only available since Graylog version 4.0.6.
- ``Enable Throttling``
   - If selected, this will enable Graylog to stop reading new data for this Input if the system gets behind on message processing and needs to catch up
- ``Store Full Message``
   - If selected, this will cause Graylog to store the raw log data in the ``full_message`` field for each log message
   - Selecting this option can result in a significant increase in the amount of data stored








