Get Alerted
-----------

I know, we’re all lazy, and busy. Nobody wants to just stare at a dashboard all day like it’s the World Cup. That’s for management.

Let’s configure some proactive alerts to let us know when something needs our attention.

Create a Stream
^^^^^^^^^^^^^^^

In order to set up an alert, we need to first create a stream. Streams process incoming messages in real time based on conditions that you set. Click *Streams*.

.. image:: /images/gs_20-crstream.png

Let’s create a stream for all incoming security/authentication error messages.  Click Create Stream.

Type in a Title and Description.

.. image:: /images/gs_21-streamtitle.png

Create a Stream Rule
^^^^^^^^^^^^^^^^^^^^
Next, we are going to configure the stream to process our Syslog UDP input messages for any security alerts.

Hit the *Edit rules* button.

.. image:: /images/gs_22-editrules.png

Pick the Syslog UDP Input, and click Add stream rule.

.. image:: /images/gs_23-streamrule.png

Then, type in the values shown below and hit save.

.. image:: /images/gs_28-streamrule-form.png

Then click I’m done!

We have just configured this stream to process in real time all the messages that come in from the security/authorization facility. 

Now let’s create the alert.

Create the Alert
^^^^^^^^^^^^^^^^
You can now either output your new stream to a 3rd party application or database, or trigger an alert to ping you in real time when a message that matches our stream rule comes in. Let’s create an alert that will email us when there are more than 2 messages in the last 2 minutes . Click *Manage Alerts*.

.. image:: /images/gs_24-alert.png

In the Add new alert condition section, let’s configure and add a new alert. Select message count condition, and configure the rest based on my screenshot (input 2’s in every field). Then click Add alert condition.

.. image:: /images/gs_25-alertcondition.png

Send a Test Email
^^^^^^^^^^^^^^^^^
In the Callbacks section,  select email alert callback, and input your email address in the Receivers section. After you’ve added a callback type and receiver, hit the blue ‘Send test alert’ button.

.. image:: /images/gs_26-alertemail.png

Going Further
^^^^^^^^^^^^^
If you want to configure an SMTP server, you can refer to :ref:`graylog-ctl`.

If you want to make this stream active, just go back to Streams and where you see the stream name, click the green *Start stream* button.

.. image:: /images/gs_27-streamactive.png

You are done - go grab a Creamsicle, take a deep breath, and chillax. Tomorrow you can configure all your own logs and alerts. To help, go and get some deep knowledge in the official :doc:`documentation </index>` friendly people that will help and guide you can be found in our `support community <https://www.graylog.org/community-support>`__. 

You can find more information on our :ref:`alerts` page.
