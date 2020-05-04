.. _okta_input:

*********************
Okta Log Events Input
*********************

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 3.3. A valid Graylog Enterprise license is required.



Okta System Log records events related to your organization and provides an audit trail of your platform activity.
This input will pull the following `Okta Log Event object <https://developer.okta.com/docs/reference/api/system-log/#logevent-object>`_ into your graylog so you can do further data analysis on the activity occurring in your organization.

For this input plugin to function as expected, the following items must be supplied in the input configuration:

1) Domain name
    Your Okta Domain (also known as your Okta URL). You can copy your domain from the Okta Developer Console.
    For information in finding your domain see: https://developer.okta.com/docs/guides/find-your-domain/overview/

2) API key
    The token which will be used to authenticate Graylog's requests to Okta.
    You can create an API token on the Okta Developer Console.
    For information on creating an okta api token see: https://developer.okta.com/docs/guides/create-an-api-token/overview/

3) Pull log events since
    The lower time bound of the Okta log events and determines how much historical data Graylog will pull from Okta when the Input starts.
    If not provided, 1 polling interval of historical data will be pulled.  Must be a timestamp in ISO-8601 format."

4) Polling interval
    Determines how often Graylog will poll for new data stored in Okta. Cannot be smaller than 5 seconds.

5) Keyword filter (optional)
    The keyword filter is optional and is used to filter the log events results.
    If it is provided, then it cannot have more than 10 keywords (space-separated) and keywords cannot be more than 40 characters long.

.. Note:: Since the Okta System Log records are related to your organization, it is recommended that this input only be run on one designated node. If global is selected, then the input will default to only run on the master node.

.. image:: /images/okta_input.png
    :width: 600




