.. _graylog-collector-sidecar:

*************************
Graylog Collector Sidecar
*************************

Graylog Collector Sidecar is a lightweight supervisor application for various log collectors. It allows the user to centralize the configuration of remote log collectors.
Configurations can be maintained through the Graylog web interface in a graphical way. For advanced configurations it's also possible to store the raw content in Graylog.
The Sidecar is then fetching the configuration meant for the target host, renders a configuration file and starts the selected log collector on it. It detects changes
automatically, performs an update and restarts the necessary process.


Installation
************

Install the actual log collector first, e.g. NXlog, and disable the system service. The Sidecar will run as a daemon process and take control over NXlog.
Download NXlog and follow the `instructions <https://nxlog.org/products/nxlog-community-edition/download>`_, afterwards::

    $ sudo /etc/init.d/nxlog stop
    $ sudo update-rc.d -f nxlog remove

Same on a Windows host::

    $ C:\Program Files (x86)\nxlog\nxlog -u

From now on NXlog will not start automatically and the Sidecar can start the collector process without any issues.
The Sidecar binary itself doesn't have any dependencies beside an installation of the used collector backend.

Linux/Unix
^^^^^^^^^^

We offer Debian/Ubuntu packages directly in the `releases <https://github.com/Graylog2/collector-sidecar/releases>`_ section.
Download and install the latest version via ``dpkg(1)``::

    $ wget https://github.com/Graylog2/collector-sidecar/releases/download/0.0.2/collector-sidecar_0.0.2-1_amd64.deb
    $ sudo dpkg -i collector-sidecar_0.0.2-1_amd64.deb

To register and enable a system service use the ``-service`` option::

    $ sudo graylog-collector-sidecar -service install
    $ sudo start collector-sidecar

Windows
^^^^^^^

Windows installation works in the same way. Download the Windows package and register the Sidecar services::

    $ C:\Program Files (x86)\graylog\collector-sidecar\graylog-collector-sidecar.exe -service install
    $ C:\Program Files (x86)\graylog\collector-sidecar\graylog-collector-sidecar.exe -service start

Configuration
*************

On the command line you can provide a path to the configuration file with the ``-c`` switch. If no path is specified it looks on Linux systems for::

    /etc/graylog/collector-sidecar/collector_sidecar.yml

and on Windows machines::

    C:\Program Files (x86)\graylog\collector-sidecar\collector_sidecar.yml

The configuration file is separated into global options and backend specific options. Global options are:

+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Parameter       | Description                                                                                                                           |
+=================+=======================================================================================================================================+
| server_url      | URL to the Graylog API, e.g. ``http://127.0.0.1:12900``                                                                               |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| node_id         | Name of the Sidecar instance, will also show up in the web interface                                                                  |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| collector_id    | Unique ID (UUID) of the instance. This can be a string or a path to an ID file                                                        |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| tags            | List of configuration tags. All configurations on the server side that match the tag list will be fetched and merged by this instance |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| log_path        | A path to a directory where the Sidecar can store the output of each running collector backend                                        |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| update_interval | The interval in seconds the sidecar will fetch new configurations from the Graylog server                                             |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+
| backends        | A list of collector backends the user wants to run on the target host                                                                 |
+-----------------+---------------------------------------------------------------------------------------------------------------------------------------+

Currently NXLog is supported as a backend collector, to make it work the Sidecar needs to know where the binary is installed and where it can
write a configuration file for it.

+--------------------+-------------------------------------------------------------------+
| Parameter          | Description                                                       |
+====================+===================================================================+
| name               | The type name of the collector                                    |
+--------------------+-------------------------------------------------------------------+
| enabled            | Weather this backend should be started by the Sidecar or not      |
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

Use the Graylog web interface to configure remote collectors
**************************************************************

Navigate to ``System → Collectors → Manage configurations``, this is the entry point for all Sidecar configurations.
Multiple configurations can be created. Because not all connected Sidecars should fetch all configurations, it's essential to provide tags for each configuration.
Every Sidecar is only fetching the configuration with the tag it was started with. See also the ``tags`` paramter in the section before.
Each configuration can hold parts for multiple collector backends.

So you can create one configuration with the tag ``linux`` and this include e.g. an input section for a NXlog collector and one for a Filebeat collector.
The Sidecar will then pick the right parts based on the backends that are enabled for the host system.

.. image:: /images/sidecar_configuration.png

There are three sections in a configuration: *Outputs*, *Inputs* and *Snippets*. In the example above, Sidecar is instructing NXlog to create a GELF output that
writes log messages back to Graylog. The two inputs are for reading in ``/var/log/syslog`` as a file input and listening on the UDP port 514 for incoming
syslog messages. Both inputs route there messages to the GELF output.

Snippets can be used to represent more complicated collector configurations. Simply paste the whole content of your NXlog configuration into a snippet
or use it as an extension to the inputs and outputs defined before. All snippets will be copied directly to the generated collector configuration, no
matter if there inputs or outputs defined.

Debug
*****

In case you want to debug a Sidecar setup, start the process in the foreground and monitor the output of the process::

    $ graylog-collector-sidecar -c /etc/graylog/collector-sidecar/collector_sidecar.yml
