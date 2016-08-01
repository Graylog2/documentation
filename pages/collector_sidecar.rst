.. _graylog-collector-sidecar:

*************************
Graylog Collector Sidecar
*************************

Graylog Collector Sidecar is a lightweight supervisor application for various log collectors. It allows the user to centralize the configuration of remote log collectors.
Configurations can be maintained through the Graylog web interface in a graphical way. For advanced configurations it's also possible to store the raw content in Graylog.
The Sidecar is then fetching the configuration meant for the target host, renders a configuration file and starts the selected log collector on it. It detects changes
automatically, performs an update and restarts the necessary process.


.. image:: /images/sidecar_overview.png

Installation
============

`Download a package <https://github.com/Graylog2/collector-sidecar/releases>`_ and install it on the target system.

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
    $ sudo start collector-sidecar

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

    $ collector_sidecar_installer.exe /S

Edit `C:\Program Files\graylog\collector-sidecar\collector_sidecar.yml` and register the system service::

    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service install
    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service start

NXLog backend
-------------

Ubuntu
~~~~~~

Install the NXLog package from the offical download `page <https://nxlog.org/products/nxlog-community-edition/download>`_. Because the Sidecar takes control of stopping and starting NXlog it's
necessary to stop all running instances of NXlog and deconfigure the default system service. Afterwards we can install and setup the Sidecar::

    $ sudo /etc/init.d/nxlog stop
    $ sudo update-rc.d -f nxlog remove
    $ sudo gpasswd -a nxlog adm

    $ sudo dpkg -i collector-sidecar_0.0.9-1_amd64.deb

Edit `/etc/graylog/collector-sidecar/collector_sidecar.yml` accordingly and register the Sidecar as a service::

    $ sudo graylog-collector-sidecar -service install
    $ sudo start collector-sidecar

CentOS
~~~~~~

The same on a RedHat based system::

    $ sudo service nxlog stop
    $ sudo chkconfig --del nxlog
    $ sudo gpasswd -a nxlog root

    $ sudo rpm -i collector-sidecar-0.0.9-1.x86_64.rpm

Activate the Sidecar as a system service::

    $ sudo graylog-collector-sidecar -service install
    $ sudo systemctl start collector-sidecar

Windows
~~~~~~~

Install the NXLog package from the offical download `page <https://nxlog.org/products/nxlog-community-edition/download>`_ and deactive the
system service. We just need the binaries installed on the system::

    $ C:\Program Files (x86)\nxlog\nxlog -u

    $ collector_sidecar_installer.exe

Edit `C:\Program Files\graylog\collector-sidecar\collector_sidecar.yml`, you should set at least the correct URL to your Graylog server and proper tags. Register the system service::

    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service install
    $ C:\Program Files\graylog\collector-sidecar\graylog-collector-sidecar.exe -service start

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
| server_url        | URL to the Graylog API, e.g. ``http://127.0.0.1:12900``                                                                               |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| update_interval   | The interval in seconds the sidecar will fetch new configurations from the Graylog server                                             |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| tls_skip_verify   | Ignore errors when the REST API was started with a self-signed certificate                                                            |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| send_status       | Send the status of each backend back to Graylog and display it on the status page for the host                                        |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| list_log_files    | Send a directory listing to Graylog and display it on the host status page. This can also be a list of directories                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------+
| node_id           | Name of the Sidecar instance, will also show up in the web interface                                                                  |
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
| name               | The type name of the collector (either 'nxlog' or 'beats')        |
+--------------------+-------------------------------------------------------------------+
| enabled            | Whether this backend should be started by the Sidecar or not      |
+--------------------+-------------------------------------------------------------------+
| binary_path        | Path to the actual collector binary                               |
+--------------------+-------------------------------------------------------------------+
| configuration_path | Path to the configuration file for this collector                 |
+--------------------+-------------------------------------------------------------------+

As an example, a complete configuration could look like this::

    server_url: http://10.0.2.2:12900
    node_id: graylog-collector-sidecar
    collector_id: file:/etc/graylog/collector-sidecar/collector-id
    tags: linux
    update_interval: 10
    log_path: /var/log/graylog/collector-sidecar
    backends:
        - name: nxlog
          enabled: true
          binary_path: /usr/bin/nxlog
          configuration_path: /etc/graylog/collector-sidecar/generated/nxlog.conf

Configure Sidecar 
-----------------

After the installation you will most likely see an error from the Sidecar saying::

    INFO[0006] [RequestConfiguration] No configuration found for configured tags!

This means simply that there is no configuration with the same tag that the Sidecar was started with. So we have to create a new configuration, define out- and inputs and tag it in order to collect log files.

Step-by-step guide
~~~~~~~~~~~~~~~~~~

We have prepared an example how to configure Sidecar in your Browser using the Graylog Webinterface. The assumption is that we will configure the collection of Apache logfiles and ship them with a Filebeat to the already present Beats input that is listening on Port 5044 on your Graylog Server.


- The first step is to navigate to the collector configurations. In your Graylog Webinterface click on ``System → Collectors → Manage configurations``. 

.. image:: /images/sidecar_sbs1.png

- Next we create a new configuration

.. image:: /images/sidecar_sbs2.png

- Give the configuration a name

.. image:: /images/sidecar_sbs3.png

- Click on the new configuration and create e.g. a Filebeat-GELF output. For a first test just change the IP to your Graylog server.

.. image:: /images/sidecar_sbs4.png

- Create a Filebeat file input to collect the Apache access logs.

.. image:: /images/sidecar_sbs5.png

- Tag the configuration with the ``apache`` tag. Just write the tag name in the field press enter followed by the ``Update tags`` button.

.. image:: /images/sidecar_sbs6.png

- When you now start the Sidecar with the ``apache`` tag the output should look like this

.. image:: /images/sidecar_sbs7.png

- Congratulations your collector setup is working now!

Sidecar Glossar
===============

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
needs to create a proper receiver under  ``System → Inputs``.

Inputs
------

Inputs are the way how collectors ingest data. An input can be a log file that the collector should continuous read or a connection to the Windows event system that emits log events.
An input is connected to an output, otherewise there would be no way of sending the data to the next hop. So first create an output and then associate one or many inputs with it.

Snippets
--------

Snippets are simply plain text configuration fragments. Sometimes it's not possible to represent the needed configuration through the provided system. E.g. a user would
like to load a special collector module. She could put the directive into a snippet which will be added to the final collector configuration without any modification.
It's also conceivable to put a full configuration file into a snippet and skip all of the input and output mechanism.
Before the snippet is actually rendered into the configuration file the Sidecar is sending it through a template engine. It's using Go's own text template `engine <https://golang.org/pkg/text/template/>`_
for that. A usage of that can be seen in the ``nxlog-default`` snippet. It detects which operating the Sidecar is running on and depending on the result, paths for some collector settings
change.

.. image:: /images/sidecar_configuration.png

Debug
=====

The Sidecar is writing to the local syslog so take a look into `/var/log/syslog` for informations why something is wrong. The output of the
running collectors is written to the ``log_path`` directory.

You can also start the Sidecar in foreground and monitor the output of the process::

    $ graylog-collector-sidecar -c /etc/graylog/collector-sidecar/collector_sidecar.yml
