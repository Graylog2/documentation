******************
Integrations Setup
******************

Integrations are tools to help Graylog work with external systems. Integrations will typically be content packs, inputs, or lookup tables.

Integrations are installed in Graylog with a single plugin named ``graylog-plugin-integrations``.

Requirements
============

The following list shows the Graylog versions that the integrations plugin is compatible with.

.. list-table:: Integrations Version Requirements
    :header-rows: 1
    :widths: 7 20

    * - Integrations Versions
      - Required Graylog Version
    * - 2.5.0+0
      - 2.5.0


Installation
============

To install the ``graylog-plugin-integrations`` plugin, you can use one of the following options.

.. important:: The Integrations plugin need to be installed on all your Graylog nodes!

DEB / RPM Packages
------------------

If you have installed Graylog with operating system packages (as described in the :doc:`/pages/installation/operating_system_packages` installation guides), then you can use the following operating system packages.

When the usage of online repositories is not possible in your environment, you can download the Integrations packages from the URLs indicated in each section.

.. note:: These packages can **only** be used when you installed Graylog via the :doc:`/pages/installation/operating_system_packages`!

DEB
~~~

The installation on distributions like Debian or Ubuntu can be done with *apt-get* as installation tool from the previous installed online repository.

::

  $ sudo apt-get install graylog-plugin-integrations

**Download Url**

:integrations-plugin-deb:`2.5.0+0`

RPM
~~~

The installation on distributions like CentOS or RedHat can be done with *yum* as installation tool from the previous installed online repository.

::

  $ sudo yum install graylog-plugin-integrations

**Download Url**

:integrations-plugin-rpm:`2.5.0+0`

Jar File
---------

:integrations-plugin-jar:`2.5.0+0`

Depending on the Graylog setup method you have used, you have to install the plugins into different locations.

.. include:: /includes/plugin-installation-locations.rst

Also check the ``plugin_dir`` config option in your Graylog server configuration file. The default might have been changed.

Make sure to install the plugin JAR file alongside the other Graylog plugins.
Your plugin directory should look similar to this after installing the integrations plugin.

::

  plugin/
  ├── ...
  ├── graylog-plugin-integrations-2.5.0+0.jar
  └── ...


Server Restart
==============

After you installed the Integrations plugin, you have to restart each of your Graylog servers. We recommend restarting one server at a time.

You should see something like the following in your Graylog server logs. It indicates that the plugins have been successfully loaded.

::

2018-12-10T17:39:10.811+01:00 INFO  [CmdLineTool] Loaded plugin: Integrations Plugin 2.5.0 [org.graylog.integrations.IntegrationsPlugin]

Cluster Setup
=============

If you run a Graylog cluster you need to add the integrations plugins to every Graylog node. Additionally your load-balancer must route ``/api/plugins/org.graylog.plugins.archive/`` only to the Graylog master node. Future versions of Graylog will forward these requests automatically to the correct node.