.. _okta_input:

*********************
Okta Log Events Input
*********************

.. attention:: This is an Enterprise Integrations feature and is only available since Graylog version 3.3 and thus requires an Enterprise license.


This input allows Graylog to pull Okta Log Events from your okta domain.

For this input plugin to function as expected, the following items need to be supplied in the input module.

1) Domain name
    The domain name associated with the IP address of the inbound event request (where the Okta Log Events are located).

2) API Key
    The API token that allows for polling Okta Log Events.

3) Pull Log Event Since
    The lower time bound of the Okta log events. Determines how much historical data Graylog will pull from Okta when the Input starts.
    If not provided, 1 polling interval of historical data will be pulled.  Must be a timestamp in ISO-8601 format."

4) Keyword filter
    The keywords used to filters the log events results by one to ten exact keywords.

.. image:: /images/okta_input.png
    :width: 600




