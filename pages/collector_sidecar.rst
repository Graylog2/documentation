.. _graylog-collector-sidecar:

*************************
Graylog Collector Sidecar
*************************

**Graylog Collector Sidecar** is a lightweight configuration management system for different log collectors, also called `Backends`_.
The Graylog node(s) act as a centralized hub containing the configurations of log collectors.
On supported message-producing devices/hosts, Sidecar can run as a service (Windows host) or daemon (Linux host).

.. image:: /images/sidecar_overview.png

These configurations are centrally managed through the Graylog web interface, in a graphical way. For specific needs, raw backend configurations, called `Snippets`_, may optionally be directly stored into Graylog.

Periodically, the Sidecar daemon will fetch all relevant configurations for the target, using the :doc:`REST API <configuration/rest_api>`.
Which configurations are actually fetched depends on 'tags' defined in the host's Sidecar configuration file. For instance, a Web server host may include the ``linux`` and ``nginx`` tags.

On its first run, or when a configuration change has been detected, Sidecar will *generate* (render) relevant backend configuration files. Then it will start, or restart, those reconfigured log collectors.

Graylog Collector Sidecar (written in Go) and backends (written in various languages, such as C and Go) are meant as a small-footprint replacement for the deprecated, Java-based :doc:`deprecated Graylog Collector <collector>`.


Backends
========

Currently the Sidecar is supporting NXLog, Filebeat and Winlogbeat. They all share the same web interface. Switch the tab on a configuration page to create
resources for the used collector. The supported features are almost the same. For all collectors a GELF output with SSL encryption is available. The most used
input options like file tailing or windows event logging do exist. On the server side you can share inputs with multiple collectors. E.g. All Filebeat and Winlogbeat instances
can send logs into a single Graylog-Beats input.

Installation
============

Currently we provide pre-compiled packages on the Github releases page of the project. Once the Sidecar project is settled and matured
we will add the packages to the DEB and YUM online repositories.
To get the Sidecar working `Download a package <https://github.com/Graylog2/collector-sidecar/releases>`_ and install it on the target system.

Please follow the version matrix to pick the right package:

+-----------------+------------------------+
| Sidecar version | Graylog server version |
+=================+========================+
| 0.0.9           | 2.1.x                  |
+-----------------+------------------------+
| 0.1.x           | 2.2.x,2.3.x            |
+-----------------+------------------------+

All following commands should be executed on the **remote machine** where you want to collect log data from.

Beats backend
-------------

Ubuntu
~~~~~~

The Beats binaries (Filebeat and Winlogeventbeat) are included in the Sidecar package. So installation is just one command::

    $ sudo dpkg -i collector-sidecar_0.0.9-1_amd64.deb

Edit `/etc/graylog/collector-sidecar/collector_sidecar.yml`, you should set at least the correct URL to your Graylog server and proper tags.
The tags are used to define which configurations the host should receive.

Create a system service and start it::

    $ sudo graylog-collector-sidecar -service install

    [Ubuntu 14.04 with Upstart]
    $ sudo start collector-sidecar

    [Ubuntu 16.04 with Systemd]
    $ sudo systemctl start collector-sidecar

CentOS
~~~~~~
Install the RPM package on RedHat based systems ::

    $ sudo rpm -i collector-sidecar-0.0.9-1.x86_64.rpm

Activate the Sidecar as a system service::

    $ sudo graylog-collector-sidecar -service install
    $ sudo systemctl start collector-sidecar

Windows
~~~~~~~
Use the Windows installer, it can be run interactively::

    $ collector_sidecar_installer.exe

or in silent mode with::

    $ collector_sidecar_installer.exe /S -SERVERURL=http://10.0.2.2:9000/api -TAGS="windows,iis"

Edit `C:\\Program Files\\graylog\\collector-sidecar\\collector_sidecar.yml` and register the system service::

    $ "C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe" -service install
    $ "C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe" -service start

NXLog backend
-------------

Ubuntu
~~~~~~

Install the NXLog package from the official download `page <https://nxlog.org/products/nxlog-community-edition/download>`_. Because the Sidecar takes control of stopping and starting NXlog it's
necessary to stop all running instances of NXlog and deconfigure the default system service. Afterwards we can install and setup the Sidecar::

    $ sudo /etc/init.d/nxlog stop
    $ sudo update-rc.d -f nxlog remove
    $ sudo gpasswd -a nxlog adm
    $ sudo chown -R nxlog.nxlog /var/spool/collector-sidecar/nxlog

    $ sudo dpkg -i collector-sidecar_0.0.9-1_amd64.deb

Edit `/etc/graylog/collector-sidecar/collector_sidecar.yml` accordingly and register the Sidecar as a service::

    $ sudo graylog-collector-sidecar -service install

    [Ubuntu 14.04 with Upstart]
    $ sudo start collector-sidecar

    [Ubuntu 16.04 with Systemd]
    $ sudo systemctl start collector-sidecar


CentOS
~~~~~~

The same on a RedHat based system::

    $ sudo service nxlog stop
    $ sudo chkconfig --del nxlog
    $ sudo gpasswd -a nxlog root
    $ sudo chown -R nxlog.nxlog /var/spool/collector-sidecar/nxlog

    $ sudo rpm -i collector-sidecar-0.0.9-1.x86_64.rpm

Activate the Sidecar as a system service::

    $ sudo graylog-collector-sidecar -service install
    $ sudo systemctl start collector-sidecar

Windows
~~~~~~~

Install the NXLog package from the official download `page <https://nxlog.org/products/nxlog-community-edition/download>`_ and deactivate the
system service. We just need the binaries installed on the system::

    $ C:\Program Files (x86)\nxlog\nxlog -u

    $ collector_sidecar_installer.exe

Edit `C:\\Program Files\\graylog\\collector-sidecar\\collector_sidecar.yml`, you should set at least the correct URL to your Graylog server and proper tags. Register the system service::

    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service install
    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service start

To perform an uninstall on Windows::

    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service stop
    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service uninstall

`Notice` that the NXLog file input is currently not able to do a SavePos for file tailing, this will be fixed in a future version.

Configuration
=============

On the command line you can provide a path to the configuration file with the ``-c`` switch. If no path is specified it looks on Linux systems for::

    /etc/graylog/collector-sidecar/collector_sidecar.yml

and on Windows machines under::

    C:\Program Files\graylog\collector-sidecar\collector_sidecar.yml

The configuration file is separated into global options and backend specific options. Global options are:

+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Parameter         | Description                                                                                                                           |
+===================+=======================================================================================================================================+
| server_url        | URL to the Graylog API, e.g. ``http://127.0.0.1:9000/api/``                                                                           |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| update_interval   | The interval in seconds the sidecar will fetch new configurations from the Graylog server                                             |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| tls_skip_verify   | Ignore errors when the REST API was started with a self-signed certificate                                                            |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| send_status       | Send the status of each backend back to Graylog and display it on the status page for the host                                        |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| list_log_files    | Send a directory listing to Graylog and display it on the host status page, e.g. ``/var/log``. This can also be a list of directories |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| node_id           | Name of the Sidecar instance, will also show up in the web interface. Hostname will be used if not set.                               |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| collector_id      | Unique ID (UUID) of the instance. This can be a string or a path to an ID file                                                        |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| log_path          | A path to a directory where the Sidecar can store the output of each running collector backend                                        |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| log_rotation_time | Rotate the stdout and stderr logs of each collector after X seconds                                                                   |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| log_max_age       | Delete rotated log files older than Y seconds                                                                                         |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| tags              | List of configuration tags. All configurations on the server side that match the tag list will be fetched and merged by this instance |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| backends          | A list of collector backends the user wants to run on the target host                                                                 |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+

Currently NXLog and Beats are supported as collector backend, to make it work the Sidecar needs to know where the binary is installed and where it can
write a configuration file for it.

+--------------------+-------------------------------------------------------------------+
| Parameter          | Description                                                       |
+====================+===================================================================+
| name               | Which backend to use (must be 'nxlog', 'filebeat' or 'winlogbeat) |
+--------------------+-------------------------------------------------------------------+
| enabled            | Whether this backend should be started by the Sidecar or not      |
+--------------------+-------------------------------------------------------------------+
| binary_path        | Path to the actual collector binary                               |
+--------------------+-------------------------------------------------------------------+
| configuration_path | Path to the configuration file for this collector                 |
+--------------------+-------------------------------------------------------------------+

An example configuration for NXlog looks like this::

    server_url: http://10.0.2.2:9000/api/
    update_interval: 30
    tls_skip_verify: true
    send_status: true
    list_log_files:
      - /var/log
    node_id: graylog-collector-sidecar
    collector_id: file:/etc/graylog/collector-sidecar/collector-id
    log_path: /var/log/graylog/collector-sidecar
    log_rotation_time: 86400
    log_max_age: 604800
    tags:
      - linux
      - apache
      - redis
    backends:
        - name: nxlog
          enabled: true
          binary_path: /usr/bin/nxlog
          configuration_path: /etc/graylog/collector-sidecar/generated/nxlog.conf

For the Beats platform you can enable each Beat individually, e.g on a Windows host with Filebeat and Winlogbeat enabled use a configuration like this::

    server_url: http://10.0.2.2:9000/api/
    update_interval: 30
    tls_skip_verify: true
    send_status: true
    list_log_files:
      - /var/log
    node_id: graylog-collector-sidecar
    collector_id: file:/etc/graylog/collector-sidecar/collector-id
    log_path: /var/log/graylog/collector-sidecar
    log_rotation_time: 86400
    log_max_age: 604800
    tags:
      - linux
      - apache
      - redis
    backends:
        - name: winlogbeat
          enabled: true
          binary_path: C:\Program Files\graylog\collector-sidecar\winlogbeat.exe
          configuration_path: C:\Program Files\graylog\collector-sidecar\generated\winlogbeat.yml
        - name: filebeat
          enabled: true
          binary_path: C:\Program Files\graylog\collector-sidecar\filebeat.exe
          configuration_path: C:\Program Files\graylog\collector-sidecar\generated\filebeat.yml

On the server side the collector plugin is caching the requested configuration in memory. By default up-to 100 entries are stored for 1 hour.
If you wish to change that, add to your server configuration::

    collector_sidecar_cache_time = 2h
    collector_sidecar_cache_max_size = 500

First start
-----------

Once you installed the Sidecar package you are ready to start the service for the first time. Decide which backend you want to use. Enable or disable the single
backends by setting ``enabled: true`` or respectively to ``false``. Now start the Sidecar, depending on your operating system you can do this with:

+---------------+---------------------------------------------------------------------------------------------+
| Debian/Ubuntu | ``sudo start collector-sidecar``                                                            |
+---------------+---------------------------------------------------------------------------------------------+
| RedHat/CentOS | ``sudo systemctl start collector-sidecar``                                                  |
+---------------+---------------------------------------------------------------------------------------------+
| Windows       | ``C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service start`` |
+---------------+---------------------------------------------------------------------------------------------+

Afterwards you will most likely see an error like this in the log file::

    INFO[0006] [RequestConfiguration] No configuration found for configured tags!

This simply means that there is no configuration with the same tag that the Sidecar was started with. So we have to create a new configuration. Define outputs and inputs and tag it in order to collect log files.
Take the :ref:`sidecar_step-by-step` to create your first configuration.

When the Sidecar can find a configuration that matches its own ``tags``, it will write for each collector backend a configuration file into the ``/generated`` directory. E.g. if you enabled the
Filebeat collector you will find a ``filebeat.yml`` file in that directory. All changes have to be made in the Graylog web interface. Everytime the Sidecar detects an update to its configuration it will
rewrite the corresponding collector configuration file. So it doesn't make sense to manually edit those files.

Everytime a collector configuration file is changed the collector process is restarted. The Sidecar takes care of the collector processes and reports the status back to the web interface

Sidecar Status
--------------

Each Sidecar instance is able to send status informations back to Graylog. By enabling the option ``send_status`` metrics like the configured tags or the IP address of the host Sidecar is running on
are send. Also metrics that are relevant for a stable operation e.g. disk volumes over 75% utilization are included. Additionally with the ``list_log_files`` option a directory listing is displayed in
the Graylog web interface. In that way an administrator can see which files are available for collecting. The list is periodically updated and files with write access are highlighted for easy identification.
After enabling ``send_status`` or ``send_status`` + ``list_log_files`` go to the collector overview and click on one of them, a status page with the configured information will be displayed.

.. _sidecar_step-by-step:

Step-by-step guide
~~~~~~~~~~~~~~~~~~

We have prepared an example on how to configure the Sidecar using the Graylog Webinterface. The assumption is that we want to collect Apache
logfiles and ship them with a Filebeat collector to a Beats input that is listening on Port 5044 on your Graylog Server.


- The first step is to create a Beats input where collectors can send data to. Click on ``System / Inputs`` and start a global Beats input on the listening address 0.0.0.0 and port 5044.

.. image:: /images/sidecar_sbs0.png

- Navigate to the collector configurations. In your Graylog Webinterface click on ``System / Collectors / Manage configurations``.

.. image:: /images/sidecar_sbs1.png

- Next we create a new configuration

.. image:: /images/sidecar_sbs2.png

- Give the configuration a name

.. image:: /images/sidecar_sbs3.png

- Click on the new configuration and create e.g. a Filebeat output. For a first test just change the IP to your Graylog server.

.. image:: /images/sidecar_sbs4.png

- Create a Filebeat file input to collect the Apache access logs.

.. image:: /images/sidecar_sbs5.png

- Tag the configuration with the ``apache`` tag. Just write the tag name in the field press enter followed by the ``Update tags`` button.

.. image:: /images/sidecar_sbs6.png

- When you now start the Sidecar with the ``apache`` tag the output should look like this

.. image:: /images/sidecar_sbs7.png

- Congratulations your collector setup is working now!

Secure Sidecar Communication
============================

The Communication between Sidecar and Graylog will be secured if your API :ref:`use SSL <https_setup>`.

To secure the communication between the Collector and Graylog you just need to mark ``Enable TLS`` in your Beats Input. Without giving additional Information, Graylog will now create a self-signed certificate for this Input.
Now in the Sidecar Beats Output Configuration you just mark ``Enable TLS Support`` and ``Insecure TLS connection``. After this is saved, the communication between Beats and Graylog will use TLS.

If you prefer NXLog you need to mark ``Allow untrusted certificate`` in the NXLog Outputs configuration and ``Enable TLS`` for your GELF Input.

Certificate based client authentication
-----------------------------------------

If you want to allow Graylog only to accept data from certificated clients you will need to build your own `certificate authority <https://en.wikipedia.org/wiki/Certificate_authority>`__  and provide this to the Input and the Client Output configuration.

Run Sidecar as non-root user
============================

The default is that the Sidecar is started with the root user to allow access to all log files. But this is not mandatory. If you like to start it with a daemon user, proceede like the following:

  - Create a daemon user e.g. ``collector``

The Sidecar itself is accessing the following files and directories:

  - ``collector_sidecar.yml`` - /etc/graylog/collector-sidecar/collector_sidecar.yml
  - backend ``configuration_path`` - /etc/graylog/collector-sidecar/generated/
  - ``collector_id`` - /etc/graylog/collector-sidecar/collector-id
  - ``cache_path`` - /var/cache/graylog/collector-sidecar/
  - ``log_path`` - /var/log/graylog/collector-sidecar/

So to make these directories readable for the ``collector`` user, use:

  - ``chown -R collector /etc/graylog``
  - ``chown -R collector /var/cache/graylog``
  - ``chown -R collector /etc/graylog``

You can change all pathes to different places in the filesystem. If you prefer to store all Sidecar data in the home directory of the ``collector`` user, just change the pathes accordingly.

Now ``systemd`` needs to know that the Sidecar should be started with a non-root user. Open ``/etc/systemd/system/collector-sidecar.service`` with an editor and navigate to the ``[Service]`` section, add::

  User=collector
  Group=collector

To make use of these settings reload systemd::

  $ sudo systemctl daemon-reload
  $ sudo systemctl restart collector-sidecar

Check the log files in ``/var/log/graylog/collector-sidecar`` for any errors. Understand that not only the Sidecar but also all backends, like ``filebeat``, will be started as ``collector`` user after these changes.
So all log files that the backound should observe also need to be readable by the ``collector`` user.


Sidecar Glossary
================

To understand the different parts of the Graylog Sidecar they are explained in the following section.

Configuration
-------------

A collector configuration is an abstract representation of a collector configuration file. It contains one or many Outputs, Inputs and Snippets.
Based on the selected backend the Sidecar will then render a working configuration file for the particular collector.
To match a configuration for a Sidecar instance both sides need to be started with the same tag. If the tags of a Sidecar instance match multiple configurations
all Out-,Inputs and Snippets are merged together to a single configuration.

Tags
----

Tags are used to match Sidecar instances with configurations on the Graylog server side. E.g. a user can create a configuration for Apache access log files.
The configuration gets the tag ``apache``. On all web servers running the Apache daemon the Sidecar can also be started with the ``apache`` tag to fetch this configuration
and to collect web access log files. There can be multiple tags on both sides the Sidecar and the Graylog server side. But to keep the overview the administrator should
use at least on one side discrete tags that the assignment is always 1:1 or 1:n.

Outputs
-------

Outputs are used to send data from a collector back to the Graylog server. E.g. NXLog is able to send directly messages in the GELF format. So the natural fit is to create a
GELF output in a NXLog configuration. Instructing NXlog to send GELF messages is of course just half the way, we also need a receiver for that. So an administrator
needs to create a proper receiver under  ``System / Inputs``.

Inputs
------

Inputs are the way how collectors ingest data. An input can be a log file that the collector should continuous read or a connection to the Windows event system that emits log events.
An input is connected to an output, otherwise there would be no way of sending the data to the next hop. So first create an output and then associate one or many inputs with it.

Snippets
--------

Snippets are simply plain text configuration fragments. Sometimes it's not possible to represent the needed configuration through the provided system. E.g. a user would
like to load a special collector module. She could put the directive into a snippet which will be added to the final collector configuration without any modification.
It's also conceivable to put a full configuration file into a snippet and skip all of the input and output mechanism.
Before the snippet is actually rendered into the configuration file the Sidecar is sending it through a template engine. It's using Go's own text template `engine <https://golang.org/pkg/text/template/>`_
for that. A usage of that can be seen in the ``nxlog-default`` snippet. It detects which operating the Sidecar is running on and depending on the result, paths for some collector settings
change.

Actions
-------

Resources like inputs, output or snippets have all the same actions: create, edit, clone
Usually there are only little differences between certain configurations so you can create a resource once, clone it and modify only the fields you need. In this way
it's possible to manage a fairly large amount of configurations.

.. image:: /images/sidecar_configuration.png

Debug
=====

The Sidecar is writing log files to the directory configured in ``log_path``. One file for each backend, there you can check for general issues like
file permissions or log transmission problems. The Sidecar itself is writing to ``collector_sidecar.log`` problems like failed connection to the Graylog API can
be found there.

You can also start the Sidecar in foreground and monitor the output of the process::

    $ graylog-collector-sidecar -debug -c /etc/graylog/collector-sidecar/collector_sidecar.yml

Known Problems
==============

Currently we know of two problems with NXLog:

  - Since version 2.9.17 timestamps are transmitted `without millisecond precision <https://nxlog.co/question/1855/gelf-timestamp-field-missing-millisecond-precision>`_
  - On Windows machines NXlog is not able to store its collector state so features like file tailing don't work correctly in combination with Sidecar. Use Sidecar version 0.1.0-alpha.1 or newer.
