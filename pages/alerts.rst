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

Notifications
=============
After defining the Events that are needed to trigger an Alert it is possible to attach a Notifcation.
By attaching a Notification to an Event or group of Events we can determine how and when information
will flow out from Graylog. Notifications can be created by selecting the Notifications button under
the Alerts tab, or by defining them in the Event workflow.

Alert notifications types explained
===================================
In this section we explain what the default alert notifications included in Graylog do, and how to configure them. Alert notifications are meant to be extensible through :ref:`plugins`, you can find more types in the `Graylog Marketplace <http://marketplace.graylog.org>`__ or even create your own.

.. important:: In previous versions of Graylog (before 2.2.0), the email alarm notification was used, when alert conditions existed for a stream, but no alarm notification had been created before. This has been changed, so that if there is no alarm notification existing for a stream, alerts will be shown in the interface but no other action is performed. To help users coming from earlier version, there is a migration job which is being run once, creating the email alarm notification explicitly for qualifying streams, so the old behavior is preserved.

Email alert notification
------------------------

The email alert notification can be used to send an email to the configured alert receivers when the conditions are triggered.

Make sure to check the :ref:`email-related configuration settings<email_config>` in the Graylog configuration file.

Three configuration options are available for the alert notification to customize the email that will be sent.
The *email body* and *email subject* are `JMTE <https://github.com/DJCordhose/jmte>`__ templates. JMTE is a minimal template engine that supports variables, loops and conditions. See the `JMTE documentation <https://cdn.rawgit.com/DJCordhose/jmte/master/doc/index.html>`__ for a language reference.

We expose the following objects to the templates.


``stream``
  The stream this alert belongs to.

  * ``stream.id`` ID of the stream
  * ``stream.title`` title of the stream
  * ``stream.description`` stream description
``stream_url``
  A string that contains the HTTP URL to the stream.
``check_result``
  The check result object for this stream.

  * ``check_result.triggeredCondition`` string representation of the triggered alert condition
  * ``check_result.triggeredAt`` date when this condition was triggered
  * ``check_result.resultDescription`` text that describes the check result
``backlog``
  A list of ``message`` objects. Can be used to iterate over the messages via ``foreach``.

``message`` (only available via iteration over the ``backlog`` object)
  The message object has several fields with details about the message. When using the ``message`` object without accessing any fields, the ``toString()`` method of the underlying Java object is used to display it.

  * ``message.id`` autogenerated message id
  * ``message.message`` the actual message text
  * ``message.source`` the source of the message
  * ``message.timestamp`` the message timestamp
  * ``message.fields`` map of key value pairs for all the fields defined in the message

  The ``message.fields`` fields can be useful to get access to arbitrary fields that are defined in the message. For example ``message.fields.full_message`` would return the ``full_message`` of a GELF message.

.. image:: /images/alerts_email_notification.png

HTTP alert notification
-----------------------

The HTTP alert notification lets you configure an endpoint that will be called when the alert is triggered.

Graylog will send a POST request to the notification URL including information about the alert. Here is an example of the payload included in a notification::

  {
      'event_definition_id': '5d5ae2a165ea93218fcd7382',
      'event_definition_type': 'aggregation-v1',
      'event_definition_title': 'example',
      'event_definition_description': 'Message count alert condition',
      'job_definition_id': '5d5ae769683c3dba791b74bd',
      'job_trigger_id': '5d8cd93365ea937cbc6be163',
      'event': {
          'id': '01DNQ30W0Y20SZAMJZQS7HV4BN',
          'event_definition_type': 'aggregation-v1',
          'event_definition_id': '5d5ae2a165ea93218fcd7382',
          'origin_context': None,
          'timestamp': '2019-09-26T15:27:49.644Z',
          'timestamp_processing': '2019-09-26T15:28:51.230Z',
          'timerange_start': '2019-09-26T15:27:45.679Z',
          'timerange_end': '2019-09-26T15:28:45.678Z',
          'streams': [],
          'source_streams': ['5a5e3147683c3d7cd137d667'],
          'message': 'event: count()=2.0',
          'source': 'graylog.example.com',
          'key_tuple': [],
          'key': '',
          'priority': 2,
          'alert': True,
          'fields': {}
      },
      'backlog': [{
              'index': 'graylog_1097',
              'message': 'ERROR: This is an example error message',
              'timestamp': '2019-09-26T15:27:46.408Z',
              'source': '127.0.0.1',
              'stream_ids': ['579a14fee96e9f287aa9fd79', '5a5e3147683c3d7cd137d667'],
              'fields': {
                  'via_input': 'input_name',
                  'level': 6,
                  'alert': 'example',
                  'gl2_remote_ip': '127.0.0.1',
                  'gl2_remote_port': 514,
                  'gl2_message_id': '01DNQ2YWQFHSJZE9T6JEBSYSVY',
                  'gl2_source_node': '7a05ad73-6141-43fa-a324-2ec2598e3645',
                  'gl2_source_input': '5799f612e96e9f287aa9dcb0',
                  'extreme_timestamp': 'Sep 26 10:27:46',
                  'facility': 'local6'
              },
              'id': '30f9c681-e072-11e9-8e57-0050568a570f'
          }, {
              'index': 'graylog_1097',
              'message': 'ERROR: This is an example error message',
              'timestamp': '2019-09-26T15:27:49.644Z',
              'source': '127.0.0.1',
              'stream_ids': ['579a14fee96e9f287aa9fd79', '5a5e3147683c3d7cd137d667'],
              'fields': {
                  'via_input': 'input_name',
                  'level': 6,
                  'alert': 'example',
                  'gl2_remote_ip': '127.0.0.1',
                  'gl2_remote_port': 514,
                  'gl2_message_id': '01DNQ2YZWK5J8B6BXNGQVJX57D',
                  'gl2_source_node': '113a4960-7cf2-43fc-b827-d81592dd1aea',
                  'gl2_source_input': '5799f612e96e9f287aa9dcb0',
                  'extreme_timestamp': 'Sep 26 10:27:49',
                  'facility': 'local6'
              },
              'id': '32e78cc0-e072-11e9-8358-0050568a6438'
          }
      ]
  }

.. _alerts_script_alert:

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
    Sends JSON alert data through standard in. You can use a JSON parser in your script. ::


     {
       "stream_id": "000000000000000000000001",
       "stream_name": "All messages",
       "stream_description": "Stream containing all messages",
       "stream_url": "http://localhost:8080///streams/000000000000000000000001/messages?rangetype=absolute&from=2019-01-25T20:57:50.793Z&to=2019-01-25T21:02:50.793Z&q=*",
       "alert_description": "Stream received messages matching <has_field:\"true\"> (Current grace time: 0 minutes)",
       "alert_triggered_at": "2019-01-25T21:02:50.793Z",
       "condition_id": "ea9fcdff-2037-44f9-801e-099bf4bb3dbd",
       "condition_description": "field: has_field, value: true, grace: 0, repeat notifications: false",
       "condition_title": "has_field",
       "condition_type": "field_content_value",
       "condition_grace": 0,
       "condition_parameters": {
         "backlog": 10,
         "repeat_notifications": false,
         "field": "has_field",
         "query": "*",
         "grace": 0,
         "value": "true"
       },
       "condition_repeat_notifications": false,
       "message_backlog": [
         {
           "has_field": "true",
           "gl2_remote_ip": "127.0.0.1",
           "gl2_remote_port": 56246,
           "streams": [
             "000000000000000000000001"
           ],
           "gl2_source_node": "e065896b-8a9a-4f45-83f2-e740525ed035",
           "_id": "92839500-20e4-11e9-8175-0637e3f7ecfc",
           "source": "example.org",
           "message": "Hello there",
           "gl2_source_input": "5c2e99687a90e30a3512f766",
           "facility": "test",
           "timestamp": "2019-01-25T21:02:49.423Z"
         },
         {
           "has_field": "true",
           "gl2_remote_ip": "127.0.0.1",
           "gl2_remote_port": 56245,
           "streams": [
             "000000000000000000000001"
           ],
           "gl2_source_node": "e065896b-8a9a-4f45-83f2-e740525ed035",
           "_id": "928087c0-20e4-11e9-8175-0637e3f7ecfc",
           "source": "example.org",
           "message": "Hello there",
           "gl2_source_input": "5c2e99687a90e30a3512f766",
           "facility": "test",
           "timestamp": "2019-01-25T21:02:49.403Z"
         }
       ],
       "message_backlog_size": 5
     }

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

