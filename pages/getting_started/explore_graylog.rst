Explore Graylog
^^^^^^^^^^^^^^^

By default the appliance is already indexing log messages from all components running inside the virtual machine. If you don't want to record these messages, you can disable this internal logging using :ref:`graylog-ctl`.

.. image:: /images/gs/first_login_dismissed_guide.png

After opening the *Streams* page in the top menu you will see a list of all predefined streams. Think of them as filtered views of all incoming messages. You can find more information on the :ref:`streams page <streams>`. For each stream, excluding the special "All messages" stream, you can define rules to determine which messages should appear in that stream.

It's worth mentioning that rule changes are not retroactive, meaning they'll only apply to new incoming messages.

.. image:: /images/gs/graylog_streams.png

If you click on *Sources* in the top menu, you will see a nice overview of which clients are sending data into Graylog, and how many messages each has sent in. Since we're just starting out you'll only see "graylog-server" and "nginx" (the "internal logging" mentioned above). Once you start sending data from other systems, however, their hostnames or IP addresses will also be listed on this page.

.. image:: /images/gs/sources_page.png

So now you're probably wondering: how will data actually get into Graylog?  Great question!

One part of the answer is called an "input".  Open the *System / Inputs* page in the top menu and you'll see several preconfigured inputs, such as one for syslog.  This means that you can already use the running appliance as a syslog receiver for any device that support the syslog protocol and can connect to the virtual machine on port 514/udp (which happens to be the standard port for syslog)!

Check out :ref:`ingest_data` if you'd like to learn more about the supported options for ingesting messages into Graylog.

.. image:: /images/gs/input_page.png

To show what's possible with Graylog, we have already created a few dashboards for you in the virtual appliance. Navigate to the *Dashboards* page in the top menu and click on *nginx overview*. After this you will see the following screen with a dashboard generated from the internal log data of the appliance itself.

.. image:: /images/gs/nginx_dashboard.png

Next, let's get the virtual machine's syslog data into Graylog!
