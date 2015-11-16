***************
Getting Started
***************

The fastest way to evaluate Graylog is to download the virtual appliance file and run it in VMWare or VirtualBox.
It's a piece of cake -- you got this.

Install & Configure
-------------------

Download Graylog
^^^^^^^^^^^^^^^^^

Go `here <https://www.graylog.org/links/images-ova/>`_ and download the virtual image.

.. image:: /images/gs_1-download.png

Import the VM
^^^^^^^^^^^^^^

These screenshots are for VMWare (VirtualBox is nearly the same).
Select *File -> Import...*, choose the ``graylog.ova`` file you downloaded, and follow the prompts.

.. image:: /images/gs_2-import-vm.png

Run the image
^^^^^^^^^^^^^^

This is what you will see when you run the image.  This is where all the Graylog server processes (more on that later) and the database will run.  We can split them apart later for performance, but there's no need to do that right now for a quick overview.  Don't close this window just yet, we're going to need the IP for the next step.

.. image:: /images/gs_3-gl-server.png

Connect to the Web Console
^^^^^^^^^^^^^^^^^^^^^^^^^^

Go to a web browser on your host machine and type the IP address you saw in the previous screen.  You should get a Graylog Web Console login page.  Enter ``admin/admin`` to login.

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

Go back to the Graylog console open in your browser and click *System -> Inputs*.  Then select Syslog UDP and click *Launch* new input.  Fill out the circles with the values in the screen shown below.

.. image:: /images/gs_8-inputstart.png

Look at the Messages
^^^^^^^^^^^^^^^^^^^^

After that, you should see the Syslog UDP input appear on the screen.

.. image:: /images/gs_9-inputlist.png

Click *Show received messages* button on this screen, and you should have messages at the bottom. It may take a few minutes before you have messages coming in.

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

You should be at a screen like the one below. If you dozed off or went to cook some meatballs, go to System -> Inputs, select the Syslog UDP input you created, and hit Show messages.

Now it’s go-time.

You’ve got data coming in, let’s start adding information to a dashboard to better visualize the data we want to see.

Add a Dashboard
^^^^^^^^^^^^^^^^^^

Let’s start by adding the message count data to a dashboard. Click *Add count to dashboard*, and it will say *No Dashboards, create one?*   Yes!  Click that.

.. image:: /images/gs_11-createdash.png

Give your new dashboard a title and description.

.. image:: /images/gs_12-titledash.png

Add a Dashboard Widget
^^^^^^^^^^^^^^^^^^^^^^

Now it will let you create a widget. In this case, we are creating a widget from our search result of message count in the last 8 hours. I like to put a timeframe in the title, and trends are always a big bowl of sunshine.

.. image:: /images/gs_13-createwidget.png

When you hit create - *wa la!*  Nothing happens.  All you UX types, relax, we know.  For now, click Dashboards and then the name of your dashboard.

.. image:: /images/gs_14-clickdash.png

Smile
^^^^^

And you'll end up with the widget you created!

.. image:: /images/gs_15-widget.png

Extra Credit - One more
^^^^^^^^^^^^^^^^^^^^^^^

Let’s add a widget for root activity, because that sounds like it may actually be useful. We need to start with a search query for root. Click *Search*. Type root in the search and select your timeframe. Once the search results come in, click *Add count to the dashboard*. Give your chart a title and hit *Create*.

.. image:: /images/gs_16-search.png

.. image:: /images/gs_17-crwidget.png

The new widget is now on the screen.  Goob job - you’ve got this!

.. image:: /images/gs_18-dashboard2.png

Go play around. If you want to know how to create more exciting charts and graphs, check out the section below.

Extra Credit - Graphs
^^^^^^^^^^^^^^^^^^^^^

Let’s start by searching for all messages within the last 1 hour. To do this, click Search, select Search in the last 1 hour, and leave the search bar blank. Once the search results populate, expand the messages field and select *Quick Values*. Click *Add to dashboard* to add this entire pie chart and data table to your dashboard.

.. image:: /images/gs_19-graphdash.png

I like to track password changes, privilege assignments, root activity, system events, user logins, etc.  Go knock yourself out and show your co-workers.

Once you have a few widgets in your dashboard, go into unlock / edit mode to quickly edit any widget, rearrange them on your dashboard, or delete. Make sure to click Lock to save!


Get Alerted
-----------

I know, we’re all lazy, and busy. Nobody wants to just stare at a dashboard all day like it’s the World Cup. That’s for management.

Let’s configure some proactive alerts to let us know when something needs our attention.

Create a Stream
^^^^^^^^^^^^^^^

In order to set up an alert, we need to set up a stream. Streams process incoming messages in real time based on conditions that you set. Click *Streams*.

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
If you want to configure an SMTP server, you can refer to the `this documentation <http://docs.graylog.org/en/latest/pages/installation/graylog_ctl.html?highlight=email>`_.

If you want to make this stream active, just go back to Streams and where you see the stream name, click the green *Start stream* button.

.. image:: /images/gs_27-streamactive.png

You are done - go grab a Creamsicle, take a deep breath, and chillax.  Tomorrow you can configure all your own logs and alerts.  To help, go and get some deep knowledge in the official `documentation <http://docs.graylog.org/en/latest/>`_.
