.. _enterprise-setup-updateoss:

*********************************
Graylog OSS to Graylog Enterprise
*********************************

If you have an existing Graylog open source instance, you can convert it to an Enterprise instance by installing the Graylog Enterprise plugin.

Once you've installed the Graylog Enterprise plugin, you need to obtain a license from `the Graylog Enterprise web page <https://www.graylog.org/enterprise/>`_.

.. important:: The Graylog Enterprise plugin need to be installed on all your Graylog nodes!

DEB / RPM Package
=================

The default installation should be done with the system package tools. It includes the repository installation that is described in the :doc:`/pages/installation/operating_system_packages` installation guides.

When the usage of online repositories is not possible in your environment, you can download the Graylog Enterprise plugins at `https://packages.graylog2.org <https://packages.graylog2.org>`_.

.. note:: These packages can **only** be used when you installed Graylog via the :doc:`/pages/installation/operating_system_packages`!

DEB
===

The installation on distributions like Debian or Ubuntu can be done with *apt-get* as installation tool from the previous installed online repository.

::

  $ sudo apt-get install graylog-enterprise


RPM
===

The installation on distributions like CentOS or RedHat can be done with *yum* as installation tool from the previous installed online repository.

::

  $ sudo yum install graylog-enterprise


Tarball
=======

If you have done a manual installation, you can get the tarball from the download locations listed in the following table.

.. This list keeps only the current supported versions. What is current stable and the previous version

.. list-table:: Enterprise Plugins download
    :header-rows: 1

    * - Enterprise Version
      - Download URL
    * - 4.0.0
      - :enterprise-plugins-tar:`4.0.0`
    * - 4.0.1
      - :enterprise-plugins-tar:`4.0.1`

The tarball includes the enterprise plugin JAR file and required binaries that need to be installed.

::

  $ tar -tzf graylog-enterprise-plugins-4.0.1.tgz
    graylog-enterprise-plugins-4.0.1/LICENSE
    graylog-enterprise-plugins-4.0.1/plugin/graylog-plugin-enterprise-3.3.8.jar
    graylog-enterprise-plugins-4.0.1/bin/headless_shell
    graylog-enterprise-plugins-4.0.1/bin/chromedriver
    graylog-enterprise-plugins-4.0.1/bin/chromedriver_start.sh


**JAR file**

Depending on the Graylog setup method you have used, you have to install the plugin into different locations.

.. include:: /includes/plugin-installation-locations.rst

Also check the ``plugin_dir`` config option in your Graylog server configuration file. The default might have been changed.

Make sure to install the enterprise plugin JAR files alongside the other Graylog plugins.
Your plugin directory should look similar to this after installing the enterprise plugins.

::

  plugin/
  ├── graylog-plugin-aws-4.0.1.jar
  ├── graylog-plugin-collector-4.0.1.jar
  ├── graylog-plugin-enterprise-4.0.1.jar
  └── graylog-plugin-threatintel-4.0.1.jar

**Binary files**

Depending on the Graylog setup method you have used, you have to copy the binaries into different locations.

.. list-table:: Binaries Installation Locations
    :header-rows: 1
    :widths: 7 20

    * - Installation Method
      - Directory
    * - :doc:`/pages/installation/operating_system_packages`
      - ``/usr/share/graylog-server/bin/``
    * - :doc:`/pages/installation/manual_setup`
      - ``/<extracted-graylog-tarball-path>/bin/``

Make sure to check the ``bin_dir`` configuration option set in your Graylog server configuration file, as the default may have changed.

Server Restart
==============

After you installed the Graylog Enterprise plugins you have to restart each of your Graylog servers
to load the plugins.

.. note:: We recommend restarting one server at a time!

You should see something like the following in your Graylog server logs. It indicates that the plugins have been successfully loaded.

::

  2017-12-18T17:39:10.797+01:00 INFO  [CmdLineTool] Loaded plugin: AWS plugins 3.3.2 [org.graylog.aws.plugin.AWSPlugin]
  2017-12-18T17:39:10.809+01:00 INFO  [CmdLineTool] Loaded plugin: Collector 3.3.2 [org.graylog.plugins.collector.CollectorPlugin]
  2017-12-18T17:39:10.811+01:00 INFO  [CmdLineTool] Loaded plugin: Enterprise Integration Plugin 3.3.2 [org.graylog.plugins.enterprise_integration.EnterpriseIntegrationPlugin]
  2017-12-18T17:39:10.805+01:00 INFO  [CmdLineTool] Loaded plugin: Graylog Enterprise 3.3.2 [org.graylog.plugins.enterprise.EnterprisePlugin]
  2017-12-18T17:39:10.827+01:00 INFO  [CmdLineTool] Loaded plugin: Threat Intelligence Plugin 3.3.2 [org.graylog.plugins.threatintel.ThreatIntelPlugin]
