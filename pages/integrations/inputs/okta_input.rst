.. _okta_input:

*********************
Okta Log Events Input
*********************

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 3.3. A valid Graylog Enterprise license is required.


This input allows Graylog to pull event logs from your Okta domain.

For this input plugin to function as expected, the following items must be supplied in the input configuration:

1) Domain name
    Your Okta Domain (also known as your Okta URL). You can copy your domain from the Okta Developer Console.
    For additional information see: https://developer.okta.com/docs/guides/find-your-domain/overview/

2) API key
    The token which will be used to authenticate Graylog's requests to Okta.
    You can create an API token on the Okta Developer Console.
    For additional information see: https://developer.okta.com/docs/guides/create-an-api-token/-/overview/

3) Pull log events since
    The lower time bound of the Okta log events and determines how much historical data Graylog will pull from Okta when the Input starts.
    If not provided, 1 polling interval of historical data will be pulled.  Must be a timestamp in ISO-8601 format."

4) Keyword filter (optional)
    The keywords field is optional and is used to filter the log events results by one to ten exact space separated keywords.

5) Polling interval
    Determines how often Graylog will poll for new data stored in Okta. Cannot be smaller than 5 seconds.

.. image:: /images/okta_input.png
    :width: 600




