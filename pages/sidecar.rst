.. _graylog-sidecar:

***************
Graylog Sidecar
***************

.. note::
 Graylog 3.0 comes with a new Sidecar implementation.
 We still support the old **Collector Sidecars**, which can be found in the ``System / Collectors (legacy)`` menu entry.
 In case you need to configure legacy **Collector Sidecar** please refer to the `Graylog Collector Sidecar documentation </en/2.5/pages/collector_sidecar.html>`_.
 We encourage users to migrate to the new **Sidecar**, which is covered by this document.

**Graylog Sidecar** is a lightweight configuration management system for different log collectors, also called `Backends`.
The Graylog node(s) act as a centralized hub containing the configurations of log collectors.
On supported message-producing devices/hosts, Sidecar can run as a service (Windows host) or daemon (Linux host).

.. image:: /images/sidecar_overview.png

The log collector configurations are centrally managed through the Graylog web interface.
Periodically, the Sidecar daemon will fetch all relevant configurations for the target, using the :doc:`REST API <configuration/rest_api>`.
On its first run, or when a configuration change has been detected, Sidecar will *generate* (render) relevant backend configuration files. Then it will start, or restart, those reconfigured log collectors.

.. _sidecar_installation:

Installation
============
You can get .deb and .rpm packages for Graylog Sidecar in our package repository. For Windows, you can download the installer from `here <https://github.com/Graylog2/collector-sidecar/releases>`_.

Please follow the version matrix to pick the right package:

+-----------------+----------------------------------+
| Sidecar version | Graylog server version           |
+=================+==================================+
| 1.0.x           | 3.0.x,3.1.x,3.2.x                |
+-----------------+----------------------------------+
| 0.1.x           | 2.2.x,2.3.x,2.4.x,2.5.x,3.0.x    |
+-----------------+----------------------------------+
| 0.0.9           | 2.1.x                            |
+-----------------+----------------------------------+

All following commands should be executed on the **remote machine** where you want to collect log data from.

Install the Sidecar
-------------------

Ubuntu
~~~~~~

Install the Graylog Sidecar repository configuration and Graylog Sidecar itself with the following commands::

    $ wget https://packages.graylog2.org/repo/packages/graylog-sidecar-repository_1-2_all.deb
    $ sudo dpkg -i graylog-sidecar-repository_1-2_all.deb
    $ sudo apt-get update && sudo apt-get install graylog-sidecar

Edit the configuration (see :ref:`Configuration <sidecar-configuration>`) and
activate the Sidecar as a system service::

    $ vi /etc/graylog/sidecar/sidecar.yml

    $ sudo graylog-sidecar -service install

    [Ubuntu 14.04 with Upstart]
    $ sudo start graylog-sidecar

    [Ubuntu 16.04 and later with Systemd]
    $ sudo systemctl start graylog-sidecar

CentOS
~~~~~~
Install the Graylog Sidecar repository configuration and Graylog Sidecar itself with the following commands::

    $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-sidecar-repository-1-2.noarch.rpm
    $ sudo yum update && sudo yum install graylog-sidecar


Edit the configuration (see :ref:`Configuration <sidecar-configuration>`) and
activate the Sidecar as a system service::

    $ vi /etc/graylog/sidecar/sidecar.yml

    $ sudo graylog-sidecar -service install
    $ sudo systemctl start graylog-sidecar

Windows
~~~~~~~
Use the Windows installer, it can be run interactively::

    $ graylog_sidecar_installer_1.0.0-1.exe

Or in silent mode with::

    $ graylog_sidecar_installer_1.0.0-1.exe /S -SERVERURL=http://10.0.2.2:9000/api -APITOKEN=yourapitoken

Optionally edit the configuration (see :ref:`Configuration <sidecar-configuration>`) and register the system service::

    notepad.exe C:\Program Files\Graylog\sidecar\sidecar.yml

    & "C:\Program Files\graylog\sidecar\graylog-sidecar.exe" -service install
    & "C:\Program Files\graylog\sidecar\graylog-sidecar.exe" -service start

Install collectors
------------------

Next up, you can decide which collectors you want to use with your Sidecar and install
them as well. We only cover the installation of the most common ones here, but you are free to use
other collectors as well.
Graylog contains default collector configurations for Filebeat, Winlogbeat and NXLog.
But since you're able to define your own collector backends, there is nothing stopping you from
running e.g. sysmon, auditd or packetbeat.


Beats on Linux
~~~~~~~~~~~~~~
Install Filebeat or another Beats package by following the instructions on the official `Filebeat <https://www.elastic.co/downloads/beats/filebeat>`_ download page.

Beats on Windows
~~~~~~~~~~~~~~~~
The Windows Sidecar package already includes Filebeat and Winlogbeat.
For other Beats packages follow the instructions on the official `Beats <https://www.elastic.co/downloads/beats>`_ download page.

NXLog on Ubuntu
~~~~~~~~~~~~~~~

Install the NXLog package from the official `NXLog <https://nxlog.org/products/nxlog-community-edition/download>`_ download page.
Because the Sidecar takes control of stopping and starting NXlog it is
necessary to stop all running instances of NXlog and unconfigure the default system service::

    $ sudo /etc/init.d/nxlog stop
    $ sudo update-rc.d -f nxlog remove
    $ sudo gpasswd -a nxlog adm
    $ sudo chown -R nxlog.nxlog /var/spool/nxlog


NXLog on CentOS
~~~~~~~~~~~~~~~

The same on a RedHat based system::

    $ sudo service nxlog stop
    $ sudo chkconfig --del nxlog
    $ sudo gpasswd -a nxlog root
    $ sudo chown -R nxlog.nxlog /var/spool/nxlog


NXlog on Windows
~~~~~~~~~~~~~~~~

Install the NXLog package from the official download `page <https://nxlog.org/products/nxlog-community-edition/download>`_ and deactivate the
system service. We just need the binaries installed on the system::

    $ C:\Program Files (x86)\nxlog\nxlog -u


.. _sidecar-configuration:

Sidecar Configuration
=====================

On the command line you can provide a path to the configuration file with the ``-c`` switch.
The default configuration path on Linux systems is ``/etc/graylog/sidecar/sidecar.yml`` and ``C:\Program Files\Graylog\sidecar\sidecar.yml`` on Windows.


Most configuration parameters come with built-in defaults.
The only parameters that need adjustment are ``server_url`` and ``server_api_token``.
You can get your API token by following the link on the :ref:`Sidecars Overview <sidecar_overview>` page.

sidecar.yml Reference
---------------------

.. |br| raw:: html

     <br>


+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| Parameter                           | Description                                                                                                         |
+=====================================+=====================================================================================================================+
| server_url                          | URL to the Graylog API, e.g. ``http://192.168.1.1:9000/api/``                                                       |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| server_api_token                    | The API token to use to authenticate against the Graylog server API. |br|                                           |
|                                     | e.g ``1jq26cssvc6rj4qac4bt9oeeh0p4vt5u5kal9jocl1g9mdi4og3n``  |br|                                                  |
|                                     | The token is mandatory and needs to be configured.                                                                  |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| node_id                             | The node ID of the sidecar. This can be a path to a file or an ID string. |br|                                      |
|                                     | Example file path: ``file:/etc/graylog/sidecar/node-id`` |br|                                                       |
|                                     | Example ID string: ``6033137e-d56b-47fc-9762-cd699c11a5a9`` |br|                                                    |
|                                     | ATTENTION: Every sidecar instance needs a unique ID! |br|                                                           |
|                                     | Default: ``file:/etc/graylog/sidecar/node-id``                                                                      |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| node_name                           | Name of the Sidecar instance, will also show up in the web interface. |br| The hostname will be used if not set.    |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| update_interval                     | The interval in seconds the sidecar will fetch new configurations from the Graylog server |br| Default: ``10``      |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| tls_skip_verify                     | This configures if the sidecar should skip the verification of TLS connections. Default: ``false``                  |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| send_status                         | This controls the transmission of detailed sidecar information like collector status, |br|                          |
|                                     | metrics and log file lists. It can be disabled to reduce load on the Graylog server if needed. |br|                 |
|                                     | Default: ``true``                                                                                                   |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| list_log_files                      | Send a directory listing to Graylog and display it on the host status page, |br|                                    |
|                                     | e.g. ``/var/log``. This can also be a list of directories. Default: ``[]``                                          |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| cache_path                          | The directory where the sidecar stores internal data. Default: ``/var/cache/graylog-sidecar``                       |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| collector_configuration_directory   | The directory where the sidecar generates configurations for collectors. |br|                                       |
|                                     | Default: ``/var/lib/graylog-sidecar/generated``                                                                     |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| log_path                            | The directory where the sidecar stores its logs. Default: ``/var/log/graylog-sidecar``                              |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| log_rotate_max_file_size            | The maximum size of the log file before it gets rotated. Default: ``10MiB``                                         |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| log_rotate_keep_files               | The maximum number of old log files to retain.                                                                      |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+
| collector_binaries_whitelist        | A list of binaries which are allowed to be executed by the Sidecar. |br|                                            |
|                                     | An empty list disables the white list feature. |br| Default:                                                        |
|                                     | ``/usr/bin/filebeat, /usr/bin/packetbeat, /usr/bin/metricbeat, /usr/bin/heartbeat,`` |br|                           |
|                                     | ``/usr/bin/auditbeat, /usr/bin/journalbeat, /usr/share/filebeat/bin/filebeat,`` |br|                                |
|                                     | ``/usr/share/packetbeat/bin/packetbeat, /usr/share/metricbeat/bin/metricbeat,`` |br|                                |
|                                     | ``/usr/share/heartbeat/bin/heartbeat, /usr/share/auditbeat/bin/auditbeat,`` |br|                                    |
|                                     | ``/usr/share/journalbeat/bin/journalbeat, /usr/bin/nxlog, /opt/nxlog/bin/nxlog``                                    |
|                                     |                                                                                                                     |
+-------------------------------------+---------------------------------------------------------------------------------------------------------------------+


.. _sidecar_first_start:

First start
-----------

Once you installed the Sidecar package and started the service for the first time,
you can verify that it shows up in the :ref:`Sidecars Overview <sidecar_overview>` page.
A new sidecar instance will not have any configurations assigned yet.
Take the :ref:`sidecar_step-by-step` to create your first configuration.

Mode of Operation
-----------------

When the Sidecar is assigned a configuration via the Graylog web interface, it will write a configuration file into the
``collector_configuration_directory`` directory for each collector backend.  E.g. if you assigned a Filebeat collector you will find a
``filebeat.yml`` file in that directory. All changes have to be made in the Graylog web interface.
Every time the Sidecar detects an update to its configuration it will
rewrite the corresponding collector configuration file. Manually editing these files is not recommended.

Every time a collector configuration file is changed the collector process is restarted. The Sidecar takes care of the collector processes and reports the status back to the web interface

Sidecar Status
--------------

Each Sidecar instance is able to send status information back to Graylog. By enabling the option ``send_status`` metrics like load or the IP address of the host Sidecar is running on
are sent. Also metrics that are relevant for a stable operation e.g. disk volumes over 75% utilization are included. Additionally with the ``list_log_files`` option a directory listing is displayed in
the Graylog web interface. In that way an administrator can see which files are available for collecting. The list is periodically updated and files with write access are highlighted for easy identification.
After enabling ``send_status`` or ``send_status`` + ``list_log_files`` go to the collector overview and click on one of them, a status page with the configured information will be displayed.

.. _sidecar_step-by-step:

Step-by-step guide
==================

We have prepared an example on how to configure the Sidecar using the Graylog web interface. The assumption is that we want to collect Apache
logfiles and ship them with a Filebeat collector to a Beats input that is listening on Port 5044 on your Graylog Server.


- The first step is to create a Beats input where collectors can send data to. Click on ``System / Inputs`` and start a global Beats input on the listening address 0.0.0.0 and port 5044.

.. image:: /images/sidecar_sbs0.png
  :width: 100 %

.. _sidecar_overview:

- Navigate to the Sidecars overview. In your Graylog web interface click on ``System / Sidecars``.

.. image:: /images/sidecars_overview.png
  :width: 100 %

- Navigate to the Sidecar ``Configuration`` page.

.. image:: /images/sidecar_sbs1.png
  :width: 100 %

- Next we create a new configuration: We give the configuration a name and select ``filebeat on Linux`` as collector.
  (This collector definition is shipped with Graylog, and comes with a default configuration template).
  Most of the configuration defaults should work for you. However you need to change the ``hosts:`` setting and point it
  to your Beats input. You also might want to change the ``paths:`` to the location of your Apache logs.
  When done click ``Create`` to save your configuration.

.. image:: /images/sidecar_sbs2.png
  :width: 100 %

.. _sidecar_assign_config_sbs:

- Next we need to assign our newly created configuration (and therefore the Filebeat collector) to our sidecar.
  Go to the ``Collector Administration`` page.

.. image:: /images/sidecar_sbs3.png
  :width: 100 %

- You will see a list of sidecars and underneath them a list of collectors that could be assigned to them.
  Please note that collectors are assigned to sidecars by means of applying a collector configuration to the sidecar.
  Therefore, we first select the ``filebeat`` collector and then click on the ``Configure`` menu, where we
  can select the ``filebeat-conf`` configuration we created earlier.

.. image:: /images/sidecar_sbs4.png
  :width: 100 %

- Confirming the assignment, will directly push this configuration to your sidecar which will go and start
  the Filebeat collector with this configuration.

.. image:: /images/sidecar_sbs5.png
  :width: 100 %

- If everything went fine, you should see the status ``running`` on the administration page.

.. image:: /images/sidecar_sbs6.png
  :width: 100 %

- Congratulations your collector setup is working now!
  You can go back to the Sidecars overview and click on the ``Show messages`` button to
  search for logs that have been collected via your sidecar.

.. image:: /images/sidecar_sbs7.png
  :width: 100 %

Creating a new Log Collector
============================
Graylog comes with a few predefined log collectors which can be easily extended
and changed to your needs.
Let's assume you want your sidecar to run `rsyslogd(8)` for you.

- Navigate to the Sidecars overview. In your Graylog web interface click on ``System / Sidecars``.

.. image:: /images/sidecars_overview.png
  :width: 100 %

- Navigate to the Sidecar ``Configuration`` page.

.. image:: /images/sidecar_sbs1.png
  :width: 100 %

- After we click on ``Create Log Collector``, we are presented with the following page,
  where we have to fill out some fields for our new collector.
  We give the collector a unique name and select ``Linux`` and ``Foreground Execution``.
  Given that you installed rsyslogd(8) under ``/usr/sbin/rsyslogd`` we configure the
  executable path accordingly.
  If you are using ``Foreground Execution`` make sure that the collector you are running
  does not daemonize itself. Otherwise the sidecar has no way of controlling the collector
  once it has forked off into the background.
  For rsyslogd we therefore provide ``-n`` as `Execute Parameter`.
  If your collector supports configuration validation, it is advised to use it.
  This acts as a pre-check, so that sidecar won't restart a collector with
  a broken configuration. For rsyslogd the option to do a configuration check is ``-N 1``.
  Optionally you can provide a `Default Template` which will be proposed
  once you create a configuration for this collector.

.. image:: /images/sidecar_new_collector.png
  :width: 100 %

- Next up you can use your newly created collector by creating a configuration
  for it and assign it to a Sidecar. Please follow the :ref:`sidecar_step-by-step` accordingly.

- **Note**: Your Sidecar might refuse to start your collector, because it needs
  to be added to the ``collector_binaries_whitelist`` first. Please edit your
  :ref:`Configuration <sidecar-configuration>` and restart your Sidecar.

Using Configuration Variables
=============================

Configuration variables can contain arbitrary strings like
the IP address of your Graylog server or the port of an input.
The variables can then be used in multiple collector configurations,
which avoids duplication and simplifies management.

To create a configuration variable go any ``Collector Configuration`` page:

.. image:: /images/sidecar_sbs2.png
  :width: 100 %

On the right you'll find a box ``Collector Configuration Reference`` which
contains `Runtime Variables` and `Variables`.
Click on ``Variables`` and then ``Create Variable`` to receive the following
modal:

.. image:: /images/sidecar_conf_variable.png
  :width: 100 %

In this example we replace the hard coded IP and Port from our
Beats input with a new variable named ``${user.BeatsInput}``:

.. image:: /images/sidecar_conf_variable2.png
  :width: 100 %

We can now use this variable in all our configurations.
If we ever need to change the IP/port of our input,
we just change the variable.

.. _sidecar_runtime_variables:

Runtime Variables
-----------------
Runtime variables contain runtime informations from each Sidecar that
is requesting this configuration.
An important example is the ``${sidecar.nodeId}`` variable.
The collector configuration should contain an instruction to fill
that variable in an extra field `gl2_source_collector`.
This allows Graylog to relate messages to the Sidecar that produced
them. (This is what makes the ``Show messages`` button on the Sidecars overview page work)

.. _sidecar_secure:

Secure Sidecar Communication
============================

The Communication between Sidecar and Graylog will be secured if your API :ref:`uses SSL <https_setup>`.

To secure the communication between the Collector and Graylog you just need to mark ``Enable TLS`` in your Beats Input. Without giving additional Information, Graylog will now create a self-signed certificate for this Input.
Now in the Sidecar Beats Output Configuration you just mark ``Enable TLS Support`` and ``Insecure TLS connection``. After this is saved, the communication between Beats and Graylog will use TLS.


Certificate based client authentication
---------------------------------------

If you want Graylog to only accept data from authenticated Collectors please follow the steps at :ref:`Secured Graylog and Beats input <sec_graylog_beats>`

Run Sidecar as non-root user
============================

The default is that the Sidecar is started with the root user to allow access to all log files. But this is not mandatory. If you like to start it with a daemon user, proceed like the following:

  - Create a daemon user e.g. ``sidecar``

The Sidecar itself is accessing the following files and directories:

  - ``sidecar.yml`` - /etc/graylog/sidecar/sidecar.yml
  - ``collector_configuration_directory`` - /var/lib/graylog-sidecar/generated/
  - ``node_id`` - /etc/graylog/sidecar/node-id
  - ``cache_path`` - /var/cache/graylog-sidecar/
  - ``log_path`` - /var/log/graylog-sidecar/

So to make these directories readable for the ``sidecar`` user, use:

  - ``chown -R sidecar /etc/graylog/sidecar``
  - ``chown -R sidecar /var/cache/graylog-sidecar``
  - ``chown -R sidecar /var/lib/graylog-sidecar``
  - ``chown -R sidecar /var/log/graylog-sidecar``

You can change all paths to different places in the file system. If you prefer to store all Sidecar data in the home directory of the ``sidecar`` user, just change the paths accordingly.

Now ``systemd`` needs to know that the Sidecar should be started with a non-root user. Open ``/etc/systemd/system/collector-sidecar.service`` with an editor and navigate to the ``[Service]`` section, add::

  User=sidecar
  Group=sidecar

To make use of these settings reload systemd::

  $ sudo systemctl daemon-reload
  $ sudo systemctl restart graylog-sidecar

Check the log files in ``/var/log/graylog-sidecar`` for any errors. Understand that not only the Sidecar but also all backends, like ``filebeat``, will be started as ``sidecar`` user after these changes.
So all log files that the backend should observe also need to be readable by the ``sidecar`` user. Depending on the Linux distribution there is usually an administrator group which has access to most log files.
By adding the ``sidecar`` user to that group you can grant access fairly easy. For example on Debian/Ubuntu systems this group is called ``adm`` (see `System Groups in Debian Wiki <https://wiki.debian.org/SystemGroups>`_ or `Security/Privileges - Monitor system logs in Ubuntu wiki <https://wiki.ubuntu.com/Security/Privileges#Monitor_system_logs>`_).

.. _graylog-upgrade-sidecar:

Upgrading from the Collector Sidecar
====================================

This guide describes how you can perform an upgrade from the deprecated
**Collector Sidecars** (0.1.x) to the new **Sidecars** (1.x).

One major difference between the old and the new Sidecars, is that
we replaced the UI based collector configuration approach with
one where you can manage the plain text configuration of the collectors directly.
This might seem like an inconvenience at first, but
gives you the flexibility to configure any collector backend you want.

Additionally, the new Sidecars don't assign configurations based on tags anymore.
Instead you have to assign configurations explicitly (see :ref:`Step-by-Step guide <sidecar_assign_config_sbs>`).


1. Install New Sidecar
----------------------

The new Sidecar has different paths and executable names, so it can coexist with the old one.
Install the new Sidecar by following the :ref:`Installation instructions <sidecar_installation>`
and have your Sidecar running as described in :ref:`First Start <sidecar_first_start>`.

**Note**: In case you were using filebeat on Linux, please make sure to also install
the official collector package, since the filebeat binary is not part of the Sidecar package anymore.


2. Migrate configuration
------------------------

Next, we need to migrate the configuration that was previously rendered
on each host by the **Collector Sidecar**, to a new **Collector Configuration**.

We recommend to use the :ref:`Sidecar Configuration Migrator <config_migrator>`.
However, retrieving the old configuration can also be done manually by fetching it from
your host at the ``/etc/graylog/collector-sidecar/generated/`` directory.

3. Adopt configuration to Graylog 3.0
-------------------------------------

There are a few things that might need attention after an upgrade:

- Use :ref:`Runtime variables <sidecar_runtime_variables>` for static fields

  The imported configuration contains instructions that add static fields
  which allows Graylog to relate messages to a Sidecar.
  You should replace the hardcoded values of ``gl2_source_collector`` and
  ``collector_node_id`` with runtime variables.

  In case of a Beats collector this would be::

    fields.gl2_source_collector: ${sidecar.nodeId}
    fields.collector_node_id: ${sidecar.nodeName}


- Migrate to the new Beats input

  Graylog 3.0 comes with a new Beats input. The former one was renamed
  to ``Beats (deprecated)``.
  The new input handles fields a little different. Therefore you
  should define ``fields_under_root: true`` for the new input
  to get the Graylog fields work.

4. Switch over to the new Sidecar
---------------------------------

Once you're done creating a new configuration, you can assign
it to your Sidecar (see :ref:`Step-by-Step guide <sidecar_assign_config_sbs>`).
If everything works as expected, make sure to uninstall the old
**Collector Sidecar** to avoid collecting your logs twice.

.. _config_migrator:

Sidecar Configuration Migrator
------------------------------
The task of the Sidecar configuration migrator is to extract the configuration
from existing **Collector Sidecars** and convert it into new **Sidecar** configurations.

This feature needs a **Collector Sidecar** with version 0.1.8 or greater.
Please upgrade the instance you want to import configurations from, if necessary.

- Navigate to the Collectors (legacy) overview. In your Graylog web interface click on ``System / Collectors (legacy)``.

.. image:: /images/sidecar_mig_1.png
  :width: 100 %

- Click on the name of the Collector you want to import configurations from

.. image:: /images/sidecar_mig_2.png
  :width: 100 %

- Click the ``Import Configuration`` button on a backend to import a configuration.
  If the import was successful, follow the link to create a new Sidecar configuration:

.. image:: /images/sidecar_mig_3.png
  :width: 100 %

- After clicking on ``Create Configuration`` use the ``Migrate`` button
  underneath the configuration editor:

.. image:: /images/sidecar_mig_4.png
  :width: 100 %

- A window opens up and lets you pick already imported configurations.
  Clicking ``Apply`` will paste the configuration into the editor.
  Afterwards you can edit and save the configuration as usual.

.. image:: /images/sidecar_mig_5.png
  :width: 100 %


Sidecar Glossary
================

To understand the different parts of the Graylog Sidecar they are explained in the following section.

Configuration
-------------

A configuration is the representation of a log collector configuration file in the Graylog web interface.
A configuration can be assigned to Sidecars, which also assigns the corresponding collector.
You can have multiple configurations for a single log collector. However, you can not
assign the same collector twice to a Sidecar.

Inputs
------

Inputs are the way how collectors ingest data. An input can be a log file that the collector should continuously read or a connection to the Windows event system that emits log events.
An input is connected to an output, otherwise there would be no way of sending the data to the next hop. So first create an output and then associate one or many inputs with it.


Debug
=====

The Sidecar is writing log files to the directory configured in ``log_path``. One file for each backend, there you can check for general issues like
file permissions or log transmission problems. The Sidecar itself is writing to ``sidecar.log``. Problems like failed connection to the Graylog API can
be found there.

You can also start the Sidecar in foreground and monitor the output of the process::

    $ graylog-sidecar -debug

Uninstall
=============
On Linux just uninstall the package, to perform an uninstall on Windows run::

    & "C:\Program Files\Graylog\graylog-sidecar.exe" -service stop
    & "C:\Program Files\Graylog\graylog-sidecar.exe" -service uninstall


Known Problems
==============

Currently we know of two problems with NXLog:

  - Since version 2.9.17 timestamps are transmitted `without millisecond precision <https://nxlog.co/question/1855/gelf-timestamp-field-missing-millisecond-precision>`_
  - On Windows machines NXlog is not able to store its collector state so features like file tailing don't work correctly in combination with Sidecar. Use Sidecar version 0.1.0-alpha.1 or newer.

Known issue if you use a loadbalancer or firewall in front of Graylog's API:

  - The Sidecar is using a persistent connection for API requests. Therefore it logs ``408 Request Time-out`` if the loadbalancer session or http timeout is lower than the configured ``update_interval``.
