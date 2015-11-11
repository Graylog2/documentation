***************
Getting Started
***************

Take it easy.  The fastest way to evaluate Graylog is to download the virtual appliance file and run it in VMWare or VirtualBox.
It is a piece of cake -- you got this.

Install & Configure
-------------------

Download Graylog
^^^^^^^^^^^^^^^^^

Go `here <https://www.graylog.org/links/images-ova/>`_ and download the virtual image.

.. image:: /images/gs_1-download.png

Import the VM
^^^^^^^^^^^^^^

These screenshots are for VMWare. VirtualBox is nearly the same, so don't sweat it if that's what you are using.
Basically, select *File -> Import...* and choose the ``graylog.ova`` file you downloaded and follow the prompts.

.. image:: /images/gs_2-import-vm.png

Run the image
^^^^^^^^^^^^^^

This is just what you are going to see when you run the image.  Here is where all of the Graylog server processes (more on that later) and the database will run.  We can split them apart later for performance, but just to get a quick overview there is no need.  Don't close this window just yet, we're going to need the IP that's right above your login prompt.

.. image:: /images/gs_3-gl-server.png

Connect to the Web Console
^^^^^^^^^^^^^^^^^^^^^^^^^^

Go to a web browser on your host machine, and type the IP address you saw in the previous screen.  You should get a Graylog Web Console login page.  Enter ``admin/admin`` to login.

.. image:: /images/gs_4-gl-webconsole.png

Logging in will get you to blank screen.  Not very fun?  No problem, let's get some stuff in there!

.. image:: /images/gs_5-webblank.png


Get Messages In
---------------

Log into the VM
^^^^^^^^^^^^^^^

We are going to use rsyslog from the Graylog server image because we already have it.  So, go to the image and login with ``ubuntu/ubuntu``.

.. image:: /images/gs_6-glslogin.png

Modify rsyslog.conf
^^^^^^^^^^^^^^^^^^^

Go to the /etc directory, and use vi, vim (`CheatSheet <http://www.fprintf.net/vimCheatSheet.html>`_), or the editor of your choice to modify the ``/etc/rsyslog.conf`` file.  There are excellent resources on the web for `rsyslog configuration <http://www.rsyslog.com/doc/v8-stable/tutorials/reliable_forwarding.html>`_.

Add at the bottom of the file so messages will forward::

  *.* @127.0.0.1:5140

In case you wanted to know, @ means UDP, 127.0.0.1 is localhost, and 5140 is the port.

.. image:: /images/gs_7-rsyslogadd.png

Restart rsyslog
^^^^^^^^^^^^^^^

Type::

  $sudo service rsyslog status
  $sudo service rsyslog restart

If you have modified the config file and it is somehow invalid, the service command will not bring rsyslog back up - so don't worry, you can always delete the line!

Configure Graylog Input
^^^^^^^^^^^^^^^^^^^^^^^

Now you are now sending data to Graylog, so you need to configure an input.  This will tell Graylog to accept the log messages.

Go to the Graylog console you have in your browser and click *System -> Inputs*.  Then Pick Syslog UDP, and click *Launch* new input.  Fill out the circles with the values in the screen shown below.

.. image:: /images/gs_8-inputstart.png

Look at the Messages
^^^^^^^^^^^^^^^^^^^^

After that, you should see the Syslog UDP input appear on the screen.

.. image:: /images/gs_9-inputlist.png

Click *Show received messages* button on this screen, and you should have messages at the bottom.

.. image:: /images/gs_10-messages.png

BOOM!  Now you have messages coming in, and this is where the fun starts.

*Skip the next section if you are all good.*

If You Don't Have Messages
^^^^^^^^^^^^^^^^^^^^^^^^^^
1.  Check to see that you made the proper entries in the rsyslog configuration file.

2.  Check the syslog UDP configuration and make sure that is right - remember we changed the default port to 5140.

3.  Check to see if rsyslog messages are being forwarded to the port.  You can use the `tcpdump <http://manpages.ubuntu.com/manpages/hardy/man8/tcpdump.8.html>`_ command to do this:
::
  $sudo tcpdump -i lo host 127.0.0.1 and udp port 5140

4.  Check to see if the server is listening on the host:
::
  $sudo netstat -peanut | grep ":5140"


Create Your Dashboard
---------------------

Now it’s go-time.

You’ve got data coming in, let’s see it up on a screen. Let’s use the histogram we see and create and add that to the dashboard.  I know this data doesn't mean anything in real life -- it's just an example -- don’t start to tune out.  Let’s just use this to get something on the dashboard.

You should be at a screen like the one below.  If you dozed off or went to cook some meatballs, go to *System -> Inputs*, and select the *Syslog UDP* input you created and hit *Show messages*. Now you are all caught up!

Add a Dashboard
^^^^^^^^^^^^^^^^^^

Click *Add count to dashboard*, and it will say *No Dashboards, create one?*   Yes!  Click that.

.. image:: /images/gs_11-createdash.png

Give your dashboard a title, and a description.

.. image:: /images/gs_12-titledash.png

Add a Dashboard Widget
^^^^^^^^^^^^^^^^^^^^^^

Now it will let you create a widget.  I like to put a timeframe in the title, and trends are always a big bowl of sunshine.

.. image:: /images/gs_13-createwidget.png

When you hit create - *wa la!*  Nothing happens.  All you UX types, relax, we know.  For now, click Dashboards and then the name of your dashboard.

.. image:: /images/gs_14-clickdash.png

Smile
^^^^^

And you'll end up with the widget you created!

.. image:: /images/gs_15-widget.png

Extra Credit - One more
^^^^^^^^^^^^^^^^^^^^^^^

Let’s do one for root activity, because it sounds like it may actually be useful.  Click *Search*.  Yeah yeah, we know Search does not sound like “create widget”.  But, that Search button allows us to do a lot in Graylog.  You’ll see.  #rollwithit

.. image:: /images/gs_16-search.png

Fill out root in the search, and add the count to the dashboard.  Then give your chart a title and hit *Create*.

.. image:: /images/gs_17-crwidget.png

The new widget is now on the screen.  Goob job - you’ve got this!

.. image:: /images/gs_18-dashboard2.png

Go play around, if you want to know how to create more exciting charts and graphs, check the section below.

Extra Credit - Graphs
^^^^^^^^^^^^^^^^^^^^^

The search screen is the start of this, check out this example in which I’ve clicked *Search*, then opened message, and then clicked *Quick Values*.  I know, not real world useful with this data, but see how it easy it is?  This can also be added to your dashboard.

.. image:: /images/gs_19-graphdash.png

I like to track password changes, privilege assignments, root activity, system events, user logins, etc.  Go knock yourself out and show your co-workers.


Get Alerted
-----------

I know, we’re all lazy, and busy.  Nobody wants to just stare at a dashboard all day like it’s the World Cup.  That’s for management.

Let’s configure some proactive alerts.

Create a Stream
^^^^^^^^^^^^^^^

Click *Alerts*, no…wait, I mean… click *Streams*.  Because that’s what makes sense, right?  Don’t worry, I'll explain it. #rollwithit

.. image:: /images/gs_20-crstream.png

Type in a Title and Description.

.. image:: /images/gs_21-streamtitle.png

Create a Stream Rule
^^^^^^^^^^^^^^^^^^^^
So the Stream is processing all inbound messages data that matches the rule *in real time*.  We are going to configure it to do this with our Syslog UDP input for any security alert.

Hit the *Edit rules* button.

.. image:: /images/gs_22-editrules.png

Pick the Syslog UDP Input, and click Add stream rule.

Then, type in the values shown below and hit save.  Now we have configured this stream to process in real time all the messages that come in from the security/authorization facility.  Let’s create the alert.

.. image:: /images/gs_23-streamrule.png


Create the Alert
^^^^^^^^^^^^^^^^
You now have a trigger and either output it to a 3rd party application or database, or create an alert to ping you when a message that matches our rule comes in.  Let’s hit *Manage Alerts*.

.. image:: /images/gs_24-alert.png

Add a new alert condition.  Let’s do it based on message count, and read through the screenshot (you can just put 2’s in everything like I did).  This says if more than 2 messages in the last 2 minutes come, it will trigger an email.  Not for real life here, but I hope this gives you a picture on how it works.

.. image:: /images/gs_25-alertcondition.png

Send a Test Email
^^^^^^^^^^^^^^^^^
Then add email as a call back type, as well as an email address on the receivers.  After you’ve added a callback type and receiver, hit the blue ‘Send test alert’ button.

.. image:: /images/gs_26-alertemail.png

Going Further
^^^^^^^^^^^^^
If you want to configure an SMTP server, you can refer to the `this documentation <http://docs.graylog.org/en/latest/pages/installation/graylog_ctl.html?highlight=email>`_.

If you want to make this stream active, just go back to Streams and where you see the stream name, click the green *Start stream* button.

.. image:: /images/gs_27-streamactive.png

You are done - go grab a Creamsicle, take a deep breath, and chillax.  Tomorrow you can configure all your own logs and alerts.  To help, go and get some deep knowledge in the official `documentation <http://docs.graylog.org/en/latest/>`_.
