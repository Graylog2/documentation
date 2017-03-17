.. _alerts:

Alerts
******

Alerts are always based on streams. You can define conditions that trigger alerts. For example whenever the stream *All production exceptions* has more than 50 messages per minute or when the field *milliseconds* had a too high standard deviation in the last five minutes.

Navigate to the *alerts* section from the top navigation bar to see already configured alerts, alerts that were fired in the past or to configure new alert conditions and notifications.

Graylog ships with default *alert conditions* and *alert notifications*, and both can be extended with :ref:`Plugins <plugins>`.


Alert states
------------
Graylog alerts are periodical searches that can trigger some notifications when a defined condition is satisfied. Since Graylog 2.2.0, alerts can have two states:

Unresolved
  Alerts have an unresolved state while the defined condition is satisfied. New alerts are triggered in this state, and they also execute the notifications attached to the stream. These alerts usually require an action on your side.
Resolved
  Graylog automatically resolves alerts once their alert condition is no longer satisfied. This is the final state of an alert, as Graylog will create a new alert if the alert condition is satisfied again in the future. After an alert is resolved, Graylog will apply the *grace period* you defined in the alert condition, waiting a certain time before creating a new alert for this alert condition.


Alerts overview
---------------
The alerts overview page lets you find out which alerts currently require your attention in an easy way, while also allowing you to check alerts that were triggered in the past and are now resolved.

.. image:: /images/alerts_alerts_overview.png

You can click on an alert name at any time to see more details about it.

Alert details
=============
From the alert details page you can quickly check the reason why an alert was triggered, the status and configuration of notifications sent by Graylog, and the search results in the time frame when the alert was unresolved.

.. image:: /images/alerts_alert_details.png

Alert timeline
^^^^^^^^^^^^^^
From within the alert details page, you can see a timeline of what occurred since Graylog detected an alert condition was satisfied. This includes the time when Graylog evaluated the condition that triggered the alert, the time when notifications were executed and the results of executing them, and the time when the alert was resolved (if that is the case).

Triggered notifications
^^^^^^^^^^^^^^^^^^^^^^^
Sometimes sending alert notifications may fail for some reason. Graylog includes details of the configured notifications at the time an alert was triggered and the result of executing those notifications, helping you to debug and fix any problems that may arise.

Search results
^^^^^^^^^^^^^^
You can quickly look at messages received while the alert was unresolved from within the alert details page. It is also possible to open that search in the search page, allowing you to further analyse the problem at hand.


Conditions
----------
The first step of managing alerts with Graylog is defining alert conditions.

Alert conditions specify searches that Graylog will execute periodically, and also indicate under which circumstances Graylog should consider those search results as exceptional, triggering an alert in that case.

Click on *Manage conditions* in the *Alerts* section to see your current conditions details, modify them, or add new ones. Clicking on an alert condition's title will open a detail page where you can also see the notifications that will be executed when the condition is satisfied.

.. image:: /images/alerts_alert_condition.png

Alert condition types explained
===============================
In this section we explain what the default alert conditions included in Graylog do, and how to configure them. Since Graylog 2.2.0, alert conditions can be extended via :ref:`plugins`, you can find more types in the `Graylog Marketplace <http://marketplace.graylog.org>`__ or even create your own.

Message count condition
^^^^^^^^^^^^^^^^^^^^^^^

This condition triggers whenever the stream received more than X messages in the last Y minutes. Perfect for example to be alerted when there are many exceptions on your platform. Create a stream that catches every error message and be alerted when that stream exceeds normal throughput levels.

Field aggregation condition
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Triggers whenever the result of a statistical computation of a numerical message field in the stream is higher or lower than a given threshold. Perfect to monitor performance problems: *Be alerted whenever the standard deviation of the response time of your application was higher than X in the last Y minutes.*

Field content condition
^^^^^^^^^^^^^^^^^^^^^^^

This condition triggers whenever the stream received at least one message since the last alert run that has a field set to a given value. *Get an alert when a message with the field `type` set to `security` arrives in the stream.*

.. Important:: We do not recommend to run this on analyzed fields like ``message`` or ``full_message`` because it is broken down to terms and you might get unexpected alerts. For example a check for `security` would also alert if a message with the field set to `no security` is received because it was broken down to `no` and `security`. This only happens on the analyzed ``message`` and ``full_message`` in Graylog.

Please also take note that only a single alert is raised for this condition during the alerting interval, although multiple messages containing the given value may have been received since the last alert.


Notifications
-------------

.. Warning:: Starting in Graylog 2.2.0, alert notifications are only triggered **once**, just when a new alert is created. As long as the alert is unresolved or in grace period, **Graylog will not send further notifications**. This will help you reducing the noise and annoyance of getting notified way too often when a problem persists for a while. Should your setup require repeated notifications you can enable this during the creation of the alert condition since Graylog 2.2.2.

Notifications (previously known as Alarm Callbacks) enable you to take actions on external systems when an alert is triggered. In this way, you can rely on Graylog to know when something is not right in your logs.

Click on *Manage notifications* in the *Alerts* section to see your current notification details, modify them, test them, or add new ones. Remember that notifications are associated to streams, so **all conditions evaluated in a stream will share the same notifications**.

.. image:: /images/alerts_alert_notification.png

Alert notifications types explained
===================================
In this section we explain what the default alert notifications included in Graylog do, and how to configure them. Alert notifications are meant to be extensible through :ref:`plugins`, you can find more types in the `Graylog Marketplace <http://marketplace.graylog.org>`__ or even create your own.

.. important:: In previous versions of Graylog (before 2.2.0), the email alarm notification was used, when alert conditions existed for a stream, but no alarm notification had been created before. This has been changed, so that if there is no alarm notification existing for a stream, alerts will be shown in the interface but no other action is performed. To help users coming from earlier version, there is a migration job which is being run once, creating the email alarm notification explicitly for qualifying streams, so the old behavior is preserved.

Email alert notification
^^^^^^^^^^^^^^^^^^^^^^^^

The email alert notification can be used to send an email to the configured alert receivers when the conditions are triggered.

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
^^^^^^^^^^^^^^^^^^^^^^^
The HTTP alert notification lets you configure an endpoint that will be called when the alert is triggered.

Graylog will send a POST request to the notification URL including information about the alert. Here is an example of the payload included in a notification::

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

