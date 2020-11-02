.. _alerts:

******
Alerts
******

.. Important::The Alerting system for Graylog 3.1.x has been completely rewritten and the procedure for creating alerts differs greatly from releases 3.0.x and prior. Please refer to the version of Graylog you are running to avoid confusion. You can select the version of Graylog documentation by referring to the bottom of the bar at the left of the screen.

Alerts are created using Event Definitions that consist of Conditions. When a given condition is met it will be stored as an Event and can be used to trigger a notification. If your system has an enterprise license, then Events may be combined to create Correlations.

Graylog ships with default *alert conditions* and *alert notifications*, and both can be extended with :ref:`Plugins <plugins>`.

Alerts & Events
===============
As of Graylog 3.1.0, the Alerts page has changed to reflect a new method of generating Alerts. An Alert is triggered when a defined Event is detected.
An Event is a condition that matches a log to a time period or aggregation. The Event may be used to group similar fields, change field content,
or create new field content for use with Alerting and Correlation (an enterprise feature.)

.. toctree::
   :titlesonly:
   :hidden:

   alerting/alerting-by-example.rst


If no Events have been defined, the Alerts & Events page will display the "Get Started!" button as shown below.

.. image:: /images/alerts_starting_page_no_events.png

Defining an Event
=================
When you click on the "Get Started!" button you will be presented with a set of dialogues that allow you to set
Title, Description, and Priority. You may click back on the selection bar to step backward in the definition
process at any time.

.. image:: /images/alerts_event_details.png

Priority
--------
The Priority of an Event is a classification for user purpose. The priority of an event
will be displayed as a thermometer icon in the over view and will be written into the notification.


Filter
======
By combining a Filter and an Aggregation you can specifically describe the criteria of an Event.
Define a Filter by using Search Query in the same syntax as the Search page. Select a Stream in
which the message can found. Define the window of time that the Filter will search backward to match messages.
The search will be executed at the given interval. If the Filter matches an Event can be created.
However, it may be useful to augment the filtered data with an aggregation

.. image:: /images/alerts_filter_definition.png

If the defined Filter matches messages currently within the Graylog Server, they will be displayed
in the Filter Preview panel on the right.

.. _event_filter_dynamic:

Filter with dynamic lists (Enterprise feature)
----------------------------------------------

Dynamic lists allow you to define a Filter where some of the search arguments are parameterized.
Everytime an event defintion is being checked, these parameters are replaced with the result of a configured Look up table.
For example, you maintain a list of former employees in Active Directory or an HR system and want an alert if anyone on the list tries to log in.
You can define a filter like ``Login from username:$former_employee$``, where the parameter ``$former_employee$`` is backed by a look up table, that returns
a current list of your former employees.

Aggregation
===========
An Aggregation can run a mathematical operation on either a numeric field value or the raw count of
messages generated that match the Filter. Also, Aggregation can now group matches by a selected field
before making the comparison. For instance, if the field username is defined, then it is possible to
alert on five successive failed logins by a particular username.
This use case is shown below.

.. image:: /images/alerts_aggregation_example.png

Fields
======
Creating Custom Fields allows the Event to populate data from the original log into the
Graylog Events index. This prevents the operator from having to run subsequent searches to get
vital information. This can also be used to limit the amount of data sent to
a Notification target. The Event will be recorded to the "All Events" stream
and will contain the Custom Field, as well as the result of the Aggregation that triggered
the Event.

.. image:: /images/alerts_customField_display.png

.. _alert_notification:

Notifications
=============
After defining the Events that are needed to trigger an Alert it is possible to attach a Notifcation.
By attaching a Notification to an Event or group of Events we can determine how and when information
will flow out from Graylog. Notifications can be created by selecting the Notifications button under
the Alerts tab, or by defining them in the Event workflow.

In this section we explain what the default alert notifications included in Graylog do, and how to configure them. Alert notifications are meant to be extensible through :ref:`plugins`, you can find more types in the `Graylog Marketplace <http://marketplace.graylog.org>`__ or even create your own.

.. _alert_notification_data:

Data available to notifications
-------------------------------
Graylog makes the following data available when it runs a notification.

Different notification types will expose the data differently, the details are listed with the description of the specific notifications below.

Event Definition Metadata
    Information about the event definition that created the alert.

    * ``event_definition_id`` (String) - The database ID of the event definition
    * ``event_definition_type`` (String) - The internal name of the event definition type (``aggregation-v1`` or ``correlation-v1``)
    * ``event_definition_title`` (String) - The title set in the UI
    * ``event_definition_description`` (String) - The description set in the UI
    * ``job_definition_id`` (String) - The internal job definition ID associated with a scheduled event definition
    * ``job_trigger_id`` (String) - The internal ID associated with the current execution of the job

Event Data
    * ``event`` The event as it is stored in Graylog
        - ``id`` (String) - The message ID of the stored event.
        - ``event_definition_id`` (String) - Same as ``event_definition_id`` in the metadata section.
        - ``event_definition_type`` (String) - Same as ``event_definition_type`` in the metadata section.
        - ``origin_context`` (String) - URN of the message or event creating this event (either ``event`` or ``message``). Can be empty.
        - ``timestamp`` (DateTime) - The timestamp this event is describing, can be set to the underlying event or message (see ``origin_context``).
        - ``timestamp_processing`` (DateTime) - The timestamp this event has been created by Graylog.
        - ``timerange_start`` (DateTime) - The start of the window of data Graylog used to create this event. Can be empty.
        - ``timerange_end`` (DateTime) - The end of the window of data Graylog used to create this event. Can be empty.
        - ``streams`` - (Strings) - The list of stream IDs the event is stored in.
        - ``source_streams`` (Strings) - The list of stream IDs the event pulled data from.
        - ``alert`` (bool) - Whether this event is considered to be an alert. Always ``true`` for event definitions that have notifications.
        - ``message`` (String) - A human-friendly message describing this event.
        - ``source`` (String) - The host name of the Graylog server that created this event.
        - ``key_tuple`` (Strings) - The list of values making up the event's key.
        - ``key`` (String) - The event's key as a single string.
        - ``priority`` (long) - The event's priority value.
        - ``fields`` (Map<String, String>) - The custom fields attached to the event.

Backlog
    * ``backlog`` (List of Message summaries) - The list of messages or events which lead to this alert being generated
        - ``id`` (String) - The message ID.
        - ``index`` (String) - The name of the index the message is stored in. Use together with ``id`` to uniquely identify a message in Graylog.
        - ``source`` (String) - The ``source`` field of the message.
        - ``message`` (String) - The ``message`` field of the message.
        - ``timestamp`` (DateTime) - The ``timestamp`` field of the message.
        - ``stream_ids`` (Strings) - The stream IDs of the message.
        - ``fields`` (Map<String, Object>) - The remaining fields of the message, can be iterated over.


.. _alert_notification_email:

Email alert notification
------------------------

The email alert notification can be used to send an email to the configured alert receivers when the conditions are triggered.

Make sure to check the :ref:`email-related configuration settings<email_config>` in the Graylog configuration file.

Three configuration options are available for the alert notification to customize the email that will be sent.
The *email body* and *email subject* are `JMTE <https://github.com/DJCordhose/jmte>`__ templates. JMTE is a minimal template engine that supports variables, loops and conditions. See the `JMTE documentation <https://cdn.rawgit.com/DJCordhose/jmte/master/doc/index.html>`__ for a language reference.

All of the data described above is available in the JMTE templates.

The default body template shows some advanced examples of accessing the information listed above::

    --- [Event Definition] ---------------------------
    Title:       ${event_definition_title}
    Description: ${event_definition_description}
    Type:        ${event_definition_type}
    --- [Event] --------------------------------------
    Timestamp:            ${event.timestamp}
    Message:              ${event.message}
    Source:               ${event.source}
    Key:                  ${event.key}
    Priority:             ${event.priority}
    Alert:                ${event.alert}
    Timestamp Processing: ${event.timestamp}
    Timerange Start:      ${event.timerange_start}
    Timerange End:        ${event.timerange_end}
    Fields:
    ${foreach event.fields field}  ${field.key}: ${field.value}
    ${end}
    ${if backlog}
    --- [Backlog] ------------------------------------
    Last messages accounting for this alert:
    ${foreach backlog message}
    ${message}
    ${end}
    ${end}

.. image:: /images/alerts_email_notification.png


.. _alert_notification_http:

HTTP alert notification
-----------------------

The HTTP alert notification lets you configure an endpoint that will be called when the alert is triggered.

Graylog will send a POST request to the notification URL including information about the alert. The body of the request is the JSON encoded data described above.

Here is an example of the payload included in a notification::

    {
      "event_definition_id": "this-is-a-test-notification",
      "event_definition_type": "test-dummy-v1",
      "event_definition_title": "Event Definition Test Title",
      "event_definition_description": "Event Definition Test Description",
      "job_definition_id": "<unknown>",
      "job_trigger_id": "<unknown>",
      "event": {
        "id": "NotificationTestId",
        "event_definition_type": "notification-test-v1",
        "event_definition_id": "EventDefinitionTestId",
        "origin_context": "urn:graylog:message:es:testIndex_42:b5e53442-12bb-4374-90ed-0deadbeefbaz",
        "timestamp": "2020-05-20T11:35:11.117Z",
        "timestamp_processing": "2020-05-20T11:35:11.117Z",
        "timerange_start": null,
        "timerange_end": null,
        "streams": [
          "000000000000000000000002"
        ],
        "source_streams": [],
        "message": "Notification test message triggered from user <admin>",
        "source": "000000000000000000000001",
        "key_tuple": [
          "testkey"
        ],
        "key": "testkey",
        "priority": 2,
        "alert": true,
        "fields": {
          "field1": "value1",
          "field2": "value2"
        }
      },
      "backlog": []
    }

.. image:: /images/alerts_http_notification.png


.. _alert_notification_script:

Legacy Script alert notification
--------------------------------

The Script Alert Notification lets you configure a script that will be executed when the alert is triggered.

.. important:: Script Alert Notification is an Enterprise Integrations plugin feature and thus requires an :ref:`Enterprise license <enterprise_features>`.


.. image:: /images/alerts_script_notification.png

These are the supported configuration options.

Script Path
    The path to where the script is located. Must me within the :ref:`permitted script path<config_script_alert>` (which is customizable).

Script Timeout
    The maximum time (in milliseconds) the script will be allowed to execute before being forcefully terminated.

Script Arguments
    String of parameters in which the delimiters are either a space-delimited or a new-line. The following argument variables may be used:

    Stream
     The stream this alert belongs to.

      * ``stream_id`` ID of the stream
      * ``stream_name`` title of the stream
      * ``stream_description`` stream description
      * ``stream_url`` a string that contains the URL to the view the relevant messages for the alert. Make sure to set the :ref:`HTTP URL<config_script_alert>` configuration parameter, as there is no default.

    Alert
     The check result object for this stream.

      * ``alert_description`` text that describes the check result
      * ``alert_triggered_at`` date when this condition was triggered
    Condition
     The available conditions to request are

      * ``condition_id`` ID of the condition
      * ``condition_description`` description of the condition
      * ``condition_title`` title of the condition
      * ``condition_type`` type of condition
      * ``condition_grace`` grace period for the condition
      * ``condition_repeat_notification`` repeat notification of the script
Send Alert Data Through STDIN
    Sends JSON alert data through standard in. You can use a JSON parser in your script. :


Script Alert Notification success is determined by its exit value; success equals zero.
Any non-zero exit value will cause it to fail.
Returning any error text through STDERR will also cause the alarm callback to fail.

Here is a sample Python script that shows all of the supported Script Alert Notification
functionality (argument parsing, STDIN JSON parsing, STDOUT, exit values, and returning an exit value).::

        #!/usr/bin/env python3
        import json
        import sys
        import time


        # Function that prints text to standard error
        def print_stderr(*args, **kwargs):
            print(*args, file=sys.stderr, **kwargs)

        # Main function
        if __name__ == "__main__":

            # Print out all input arguments.
            sys.stdout.write("All Arguments Passed In: " + ' '.join(sys.argv[1:]) + "\n")
            sys.stdout.write("Stream Name: " + sys.argv[2] + "\n")
            sys.stdout.write("Stream Description: " + sys.argv[3] + "\n")
            sys.stdout.write("Alert Triggered At: " + sys.argv[6] + "\n")

            # Turn stdin.readlines() array into a string
            std_in_string = ''.join(sys.stdin.readlines())

            # Load JSON
            alert_object = json.loads(std_in_string)

            # Extract some values from the JSON.
            sys.stdout.write("Values from JSON: \n")
            sys.stdout.write("Stream ID: " + alert_object["stream_id"] + "\n")
            sys.stdout.write("Stream Name: " + alert_object["stream_name"] + "\n")
            sys.stdout.write("Alert Triggered At: " + alert_object["alert_triggered_at"] + "\n")

            # Extract Message Backlog field from JSON.
            sys.stdout.write("\n\nFields:\n")
            for message in alert_object["message_backlog"]:
                for field in message.keys():
                    print("Field: " + field)
                    print("Value: " + str(message[field]))

            # Write to stderr if desired
            # print_stderr("Test return through standard error")

            # Return an exit value. Zero is success, non-zero indicates failure.
            exit(0)



Event Summary
=============
When all of the components have been defined the Event Summary will be displayed to the user.
At this time, the user may select a previous point in the Workflow to change a parameter.
The user may also cancel out of the workflow, select done. The Event may be viewed under
Alerts>Event Definitions.

