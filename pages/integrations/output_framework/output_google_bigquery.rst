.. _output_google_bigquery:

***************************************
Enterprise Google Cloud BigQuery Output
***************************************

This Output allows you to send data to your Google Cloud BigQuery tables.  Each message 
in the stream will be inserted as a new row in the configured BigQuery table.

.. note:: This is an Enterprise Integrations feature and is only available since Graylog 
          version 3.3.6, thus an Enterprise license is required. See the 
          :doc:`Integrations Setup <../setup>` page for more info.
          
Unlike the :doc:`Raw TCP<output_tcp_raw>` and :doc:`TCP Syslog<output_tcp_syslog>` Outputs, 
which require a payload formatter in order to work, the BigQuery Output does not rely on a 
payload formatter.  Since the ``Outbound Payload Format`` is required when setting up any 
Enterprise Framework Output, we have provided a ``No-op Formatter`` specifically for use 
with the BigQuery Output.

The BigQuery Output uses the key-value pairs in each Graylog message to build a row to 
be inserted into your BigQuery table with the Graylog message keys mapping to your 
BigQuery table's columns. Any Graylog message key which does not have a corresponding 
column in your BigQuery table will be dropped by Google when the insert is performed. 
You can use a processing pipeline or the ``Excluded Fields`` list in the BigQuery Output 
configuration to prevent unwanted fields from being included when each row is sent to
your BigQuery table.

Required Google Cloud Setup
---------------------------

Prerequisites
^^^^^^^^^^^^^

In order to use the Google Cloud BigQuery Output, you will need to create and authorize a 
service account through your Google Cloud console.

It is assumed that you already have a working Google Cloud account and access to the console.

Create Service Account
^^^^^^^^^^^^^^^^^^^^^^

1) Log in to the `Google Cloud console <https://console.cloud.google.com>`_
2) Navigate to ``IAM & Admin`` in the left-hand menu
3) Select ``Service Accounts`` in the left-hand menu
4) Select ``+ CREATE SERVICE ACCOUNT`` in the top of the right-hand pane
5) Create the new service account

   a) Provide a name for the service account (i.e. "Graylog Data")
   b) Enter a description for the service account
   c) Click the ``CREATE`` button
   d) Select appropriate permissions for the new service account.  At a minimum, the service 
      account will need the ability to write to your BigQuery table
   e) Click the ''CONTINUE'' button
   f) If desired, grant other users access to the service account
   g) Click the ''DONE'' button to finish service account creation

Generate and Download Service Account Credentials
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1) Click on the newly created service account in your list of service accounts
2) In the ``Keys`` section, select ``Create new key`` from the ``ADD KEY`` drop-down menu
3) Select ``JSON`` as the key type
4) Click on the ``CREATE`` button
5) Save the generated JSON file
6) Copy the downloaded JSON credentials file to your Graylog host(s).  We strongly 
   recommend that you take appropriate steps to protect the credentials file (e.g.
   assigning ownership of the file to the account which runs your Graylog server and 
   setting file permissions to 400).
   
Output Configuration
--------------------

The Google Cloud BigQuery Output supports all of the standard Enterprise Output Framework 
`configuration options <../output_framework.html#general-configuration>`__.


BigQuery Configuration
^^^^^^^^^^^^^^^^^^^^^^

- ``Project ID``
   - Google Cloud Project ID
- ``Dataset``
   - Output BigQuery Dataset
- ``Table``
   - Output BigQuery Table
- ``Excluded Fields``
   - A comma-separated list of fields that will be used as filter which fields are sent to BigQuery
- ``Credentials File Location``
   - Path to the Service Account credentials file

