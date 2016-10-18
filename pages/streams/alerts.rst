.. _alerts:

Alerts
******

Alerts are always based on streams. You can define conditions that trigger alerts. For example whenever the stream *All production exceptions* has more than 50 messages per minute or when the field *milliseconds* had a too high standard deviation in the last five minutes.

Hit *Manage alerts* in the stream overview to see already configured alerts, alerts that were fired in the past or to configure new alert conditions.

Graylog ships with default *alert conditions* and *alert callbacks* and can be extended with :ref:`Plugins <plugins>`.

Alert condition types explained
===============================

Message count condition
^^^^^^^^^^^^^^^^^^^^^^^

This condition triggers whenever the stream received more than X messages in the last Y minutes. Perfect for example to be alerted when there are many exceptions on your platform. Create a stream that catches every error message and be alerted when that stream exceeds normal throughput levels.

Field value condition
^^^^^^^^^^^^^^^^^^^^^

Triggers whenever the result of a statistical computation of a numerical message field in the stream is higher or lower than a given threshold. Perfect to monitor for performance problems: *Be alerted whenever the standard deviation of the response time of your application was higher than X in the last Y minutes.*

Field content value condition
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This condition triggers whenever the stream received at least one message since the last alert run that has a field set to a given value. *Get an alert when a message with the field `type` set to `security` arrives in the stream.*

.. Important:: We do not recommend to run this on analyzed fields like ``message`` or ``full_message`` because it is broken down to terms and you might get unexpected alerts. For example a check for `security` would also alert if a message with the field set to `no security` is received because it was broken down to `no` and `security`. This only happens on the analyzed ``message`` and ``full_message`` in Graylog.

Please also take note that only a single alert is raised for this condition during the alerting interval, although multiple messages containing the given value may have been received since the last alert.

What is the difference between alert callbacks and alert receivers?
===================================================================

There are two groups of entities configuring what happens when an alert is fired: Alarm callbacks and alert receivers.

Alarm callbacks are a list of events that are being processed when an alert is triggered. There could be an arbitrary number of alarm callbacks configured here. If there is no alarm callback configured at all, a default email transport will be used to notify about the alert. If one or more alarm callbacks are configured (which might include the email alarm callback or not) then all of them are executed for every alert.

If the email alarm callback is used because it appears once or multiple times in the alarm callback list, or the alarm callback list is empty so the email transport is used per default, then the list of alert receivers is used to determine which recipients should receive the alert nofications. Every Graylog user (which has an email address configured in their account) or email address in that list gets a copy of the alerts sent out.

Alert callbacks types explained
===============================
In this section we explain what the default alert callbacks included in Graylog do, and how to configure them. Alert callbacks are meant to be extensible through :ref:`plugins`, you can find more types in the `Graylog Marketplace <http://marketplace.graylog.org>`__ or even create your own.

.. important:: In previous versions of Graylog (before 2.2.0), the email alarm callback was used, when alert conditions existed for a stream, but no alarm callback had been created before. This has been changed, so that if there is no alarm callback existing for a stream, alerts will be shown in the interface but no other action is performed. To help users coming from earlier version, there is a migration job which is being run once, creating the email alarm callback explicitly for qualifying streams, so the old behavior is preserved.

Email alert callback
^^^^^^^^^^^^^^^^^^^^

The email alert callback can be used to send an email to the configured alert receivers when the conditions are triggered.

Three configuration options are available for the alert callback to customize the email that will be sent.
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

.. image:: /images/stream_alert_callback_email_form.png

HTTP alert callback
^^^^^^^^^^^^^^^^^^^
The HTTP alert callback lets you configure an endpoint that will be called when the alert is triggered.

Graylog will send a POST request to the callback URL including information about the alert. Here is an example of the payload included in a callback::

  {
      "check_result": {
          "result_description": "Stream had 2 messages in the last 1 minutes with trigger condition more than 1 messages. (Current grace time: 1 minutes)",
          "triggered_condition": {
              "id": "5e7a9c8d-9bb1-47b6-b8db-4a3a83a25e0c",
              "type": "MESSAGE_COUNT",
              "created_at": "2015-09-10T09:44:10.552Z",
              "creator_user_id": "admin",
              "grace": 1,
              "parameters": {
                  "grace": 1,
                  "threshold": 1,
                  "threshold_type": "more",
                  "backlog": 5,
                  "time": 1
              },
              "description": "time: 1, threshold_type: more, threshold: 1, grace: 1",
              "type_string": "MESSAGE_COUNT",
              "backlog": 5
          },
          "triggered_at": "2015-09-10T09:45:54.749Z",
          "triggered": true,
          "matching_messages": [
              {
                  "index": "graylog2_7",
                  "message": "WARN: System is failing",
                  "fields": {
                      "gl2_remote_ip": "127.0.0.1",
                      "gl2_remote_port": 56498,
                      "gl2_source_node": "41283fec-36b4-4352-a859-7b3d79846b3c",
                      "gl2_source_input": "55f15092bee8e2841898eb53"
                  },
                  "id": "b7b08150-57a0-11e5-b2a2-d6b4cd83d1d5",
                  "stream_ids": [
                      "55f1509dbee8e2841898eb64"
                  ],
                  "source": "127.0.0.1",
                  "timestamp": "2015-09-10T09:45:49.284Z"
              },
              {
                  "index": "graylog2_7",
                  "message": "ERROR: This is an example error message",
                  "fields": {
                      "gl2_remote_ip": "127.0.0.1",
                      "gl2_remote_port": 56481,
                      "gl2_source_node": "41283fec-36b4-4352-a859-7b3d79846b3c",
                      "gl2_source_input": "55f15092bee8e2841898eb53"
                  },
                  "id": "afd71342-57a0-11e5-b2a2-d6b4cd83d1d5",
                  "stream_ids": [
                      "55f1509dbee8e2841898eb64"
                  ],
                  "source": "127.0.0.1",
                  "timestamp": "2015-09-10T09:45:36.116Z"
              }
          ]
      },
      "stream": {
          "creator_user_id": "admin",
          "outputs": [],
          "matching_type": "AND",
          "description": "test stream",
          "created_at": "2015-09-10T09:42:53.833Z",
          "disabled": false,
          "rules": [
              {
                  "field": "gl2_source_input",
                  "stream_id": "55f1509dbee8e2841898eb64",
                  "id": "55f150b5bee8e2841898eb7f",
                  "type": 1,
                  "inverted": false,
                  "value": "55f15092bee8e2841898eb53"
              }
          ],
          "alert_conditions": [
              {
                  "creator_user_id": "admin",
                  "created_at": "2015-09-10T09:44:10.552Z",
                  "id": "5e7a9c8d-9bb1-47b6-b8db-4a3a83a25e0c",
                  "type": "message_count",
                  "parameters": {
                      "grace": 1,
                      "threshold": 1,
                      "threshold_type": "more",
                      "backlog": 5,
                      "time": 1
                  }
              }
          ],
          "id": "55f1509dbee8e2841898eb64",
          "title": "test",
          "content_pack": null
      }
  }

Alert callback history
======================
Sometimes sending alert callbacks may fail for some reason. Graylog provides an alert callback history for those ocasions, helping you to debug and fix any problems that may arise.

.. image:: /images/alert_callback_history.png

To check the status of alert callbacks, go to the *Streams* page, and click on the *Manage alerts* button next to the stream containing the alert callbacks. You can find the alert callback history at the bottom of that page, in the *Triggered alerts* section.

On the list of alerts, clicking on *Show callbacks* will open a list of all the callbacks involved in the alert, including their status and configuration at the time the alert was triggered.
