Explore Graylog
^^^^^^^^^^^^^^^

By default the appliance is already indexing log messages from all components running inside the virtual machine. If you don't want to record these messages, you can disable this internal logging using :ref:`graylog-ctl`.

.. image:: /images/gs/first_login_dismissed_guide.png 

When opening the *Streams* page in the top menu, you will see a list of all predefined streams. Think of them as a filtered view of all incoming messages. You can find more information on the :ref:`streams page <streams>`. As you can see, you can define rules for the messages which should be visible in this stream.

.. image:: /images/gs/graylog_streams.png

If you click on *Sources* in the top menu, you will see a nice overview of which clients are sending data into Graylog and how much. In the showcase setup, you will see "graylog-server" and "nginx" in the beginning. Once you start sending data from other systems, their hostnames or IP addresses will be listed on the *Sources* page.

.. image:: /images/gs/sources_page.png

The most important question is: How will the data actually come into Graylog.

Open the *System > Inputs* page from the top menu and you will see some inputs which are running by default, such as a syslog input.

This means that you can already use the running appliance as a syslog receiver for any device supporting the syslog protocol which is able to connect to the virtual machine on port 514/udp (which happens to be the standard port for syslog).

.. image:: /images/gs/input_page.png

If you would like to know the supported options for ingesting messages into Graylog, you can find additional information at :ref:`ingest_data`.

To show what's possible with Graylog, we have already created a few dashboards for you in the virtual appliance. Navigate to the *Dasboards* page in the top menu and click on *nginx overview*. After this you will see the following screen with a dashboard generated from the internal log data of the virtual appliance itself.

.. image:: /images/gs/nginx_dashboard.png

To have some more data, we will add the syslog data from the running virtual machine in the next step.

