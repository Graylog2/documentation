Explore Graylog
^^^^^^^^^^^^^^^

By default the appliance is already getting logs. This are the Logfiles from all components that are running inside. This can be disabled later with the :ref:`graylog-ctl`.

.. image:: /images/gs/first_login_dismissed_guide.png 

If you choose *Streams* on the top you will get a overview of of the pre-defined Streams. Think of them like a pre-sorted view on the incoming messages. Your can find more information on the :ref:`streams page <streams>`. As you can see you define rules for the messages that are visible in this stream.

.. image:: /images/gs/graylog_streams.png

If you choose *Sources* in the Top you will get a nice overview who is sending what amount of Data into your Graylog Setup. In the showcase Setup you only have the graylog-server and nginx visible. If you start sending data from other hosts, the hostname or ip adress will be shown here.

.. image:: /images/gs/sources_page.png

The most importand part, how does the data actually come into Graylog. Check *System > Inputs* and you will see what is by default enabled. You can already use the running virtual machine as a syslog target from any device that is able  and can reach the IP of the VM. 

.. image:: /images/gs/input_page.png

If you like to know what options you have to ingest messages to Graylog, look at the page :ref:`ingest_data`.

In the showcase setup UDP port 514 is already waiting to get some messages.

In the Showcase we have already created a Dashboard for you, just to show what is possible with Graylog. Navigate to *Dasboards* at the top navigation and choose *nginx overview*. After this you will get the following screen. This is generated out of the data that comes in.

.. image:: /images/gs/nginx_dashboard.png

To have some more data, we will add the Syslog Data from the running virtual machine in the next step.

