.. _enterprise-setup:

*****
Setup
*****

Graylog Enterprise comes as a Graylog server plugin which need to be installed
in addition to the Graylog open source setup.

Requirements
============

The following list shows the minimum required Graylog versions for the Graylog Enterprise plugins.

.. list-table:: Enterprise Version Requirements
    :header-rows: 1
    :widths: 7 20

    * - Enterprise Version
      - Required Graylog Version
    * - 1.0.0
      - 2.0.0, 2.0.1
    * - 1.0.1
      - 2.0.2, 2.0.3
    * - 1.2.0
      - 2.1.0, 2.1.1, 2.1.2
    * - 1.2.1
      - 2.1.3
    * - 2.2.0
      - 2.2.0
    * - Graylog & Enterprise
      - same version since 2.2.0


Installation
============

Since Graylog 2.4 the Graylog Enterprise plugin can be installed the same way Graylog is installed. In most setups this will be done with the package tool provided by the distribution you are using and the online repository.

.. note:: For previous versions of Graylog Enterprise please contact your Graylog account manager.

Once you installed the Graylog Enterprise plugin you need to obtain a license from `the Graylog Enterprise web page <https://www.graylog.org/enterprise/>`_.

Should a simple ``apt-get install graylog-enterprise-plugins`` or ``yum install graylog-enterprise-plugins`` not work for you, the following information might help you.

.. hint:: You might want the :ref:`Integrations Plugins <integrations_plugins>` in addition to the Enterprise Plugins. See following the names of all official provides package: ``graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins``

.. important:: The Graylog Enterprise plugin need to be installed on all your Graylog nodes!

DEB / RPM Package
-----------------

The default installation should be done with the system package tools. It includes the repository installation that is described in the :doc:`/pages/installation/operating_system_packages` installation guides.

When the usage of online repositories is not possible in your environment, you can download the Graylog Enterprise plugins at `https://packages.graylog2.org <https://packages.graylog2.org>`_.

.. note:: These packages can **only** be used when you installed Graylog via the :doc:`/pages/installation/operating_system_packages`!

DEB
~~~

The installation on distributions like Debian or Ubuntu can be done with *apt-get* as installation tool from the previous installed online repository.

::

  $ sudo apt-get install graylog-enterprise-plugins


RPM
~~~

The installation on distributions like CentOS or RedHat can be done with *yum* as installation tool from the previous installed online repository.

::

  $ sudo yum install graylog-enterprise-plugins


Tarball
-------

If you have done a manual installation you can get the tarball from the download locations listed in the following table.

.. This list keeps only the current supported versions. What is current stable and the previous version

.. list-table:: Enterprise Plugins download
    :header-rows: 1

    * - Enterprise Version
      - Download URL
    * - 3.1.0
      - :enterprise-plugins-tar:`3.1.0`
    * - 3.1.1
      - :enterprise-plugins-tar:`3.1.1`
    * - 3.1.2
      - :enterprise-plugins-tar:`3.1.2`
    * - 3.1.3
      - :enterprise-plugins-tar:`3.1.3`
    * - 3.2.0
      - :enterprise-plugins-tar:`3.2.0`
    * - 3.2.1
      - :enterprise-plugins-tar:`3.2.1`
    * - 3.2.2
      - :enterprise-plugins-tar:`3.2.2`
    * - 3.2.3
      - :enterprise-plugins-tar:`3.2.3`
    * - 3.2.4
      - :enterprise-plugins-tar:`3.2.4`
    

The tarball includes the enterprise plugin JAR file and required binaries that need to be installed.

::

  $ tar -tzf graylog-enterprise-plugins-3.2.1.tgz
    graylog-enterprise-plugins-3.2.1/LICENSE
    graylog-enterprise-plugins-3.2.1/plugin/graylog-plugin-enterprise-3.2.1.jar
    graylog-enterprise-plugins-3.2.1/bin/headless_shell
    graylog-enterprise-plugins-3.2.1/bin/chromedriver
    graylog-enterprise-plugins-3.2.1/bin/chromedriver_start.sh


**JAR file**

Depending on the Graylog setup method you have used, you have to install the plugin into different locations.

.. include:: /includes/plugin-installation-locations.rst

Also check the ``plugin_dir`` config option in your Graylog server configuration file. The default might have been changed.

Make sure to install the enterprise plugin JAR files alongside the other Graylog plugins.
Your plugin directory should look similar to this after installing the enterprise plugins.

::

  plugin/
  ├── graylog-plugin-aws-3.2.1.jar
  ├── graylog-plugin-collector-3.2.1.jar
  ├── graylog-plugin-enterprise-3.2.1.jar
  └── graylog-plugin-threatintel-3.2.1.jar

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

  2017-12-18T17:39:10.797+01:00 INFO  [CmdLineTool] Loaded plugin: AWS plugins 3.2.1 [org.graylog.aws.plugin.AWSPlugin]
  2017-12-18T17:39:10.809+01:00 INFO  [CmdLineTool] Loaded plugin: Collector 3.2.1 [org.graylog.plugins.collector.CollectorPlugin]
  2017-12-18T17:39:10.811+01:00 INFO  [CmdLineTool] Loaded plugin: Enterprise Integration Plugin 3.2.1 [org.graylog.plugins.enterprise_integration.EnterpriseIntegrationPlugin]
  2017-12-18T17:39:10.805+01:00 INFO  [CmdLineTool] Loaded plugin: Graylog Enterprise 3.2.1 [org.graylog.plugins.enterprise.EnterprisePlugin]
  2017-12-18T17:39:10.827+01:00 INFO  [CmdLineTool] Loaded plugin: Threat Intelligence Plugin 3.2.1 [org.graylog.plugins.threatintel.ThreatIntelPlugin]

Cluster Setup
=============

If you run a Graylog cluster you need to add the enterprise plugins to every Graylog node. Additionally your load-balancer must route ``/api/plugins/org.graylog.plugins.archive/`` only to the Graylog master node. Future versions of Graylog will forward these requests automatically to the correct node.


License Installation
====================

The Graylog Enterprise plugins require a valid license to use the additional features.

Once you have `obtained a license <https://www.graylog.org/enterprise/>`_
you can import it into your Graylog setup by going through the following steps.

#. As an admin user, open the "Enterprise/License" page from the menu in the web interface.
#. Click the Import new license button in the top right hand corner.
#. Copy the license text from the confirmation email and paste it into the text field.
#. The license should be valid and a preview of your license details should appear below the text field.
#. Click Import to activate the license.

The license automatically applies to all nodes in your cluster without the need to restart your server nodes.

.. note:: If there are errors, please check that you copied the entire license from the email without line breaks.
          The same license is also attached as a text file in case it is wrongly formatted in the email.

.. image:: /images/enterprise-license-1.png


License Verification
====================

Some Graylog licenses require to check their validity on a regular basis. This includes the free Graylog Enterprise license with a specific amount of traffic included.

If your network environment requires Graylog to use a proxy server in order to communicate with the external services via HTTPS, you'll have to configure the proxy server in the :ref:`Graylog configuration file<http_config>`.

The Graylog web interface shows all details about the license, but if you are still unclear about the requirements, please contact our `sales team <https://www.graylog.org/contact-sales>`_ with your questions.

Details on License Verification
-------------------------------


Graylog Enterprise periodically sends the following information to
'api.graylog.com' via HTTPS on TCP port 443 for each installed
license:

* A nonce to avoid modified reports
* The ID of the license
* The ID of the Graylog cluster
* A flag indicating if the license is violated
* A flag indicating if the license has expired
* A flag indicating if Graylog detected that the traffic measuring mechanisms have been modified
* A list of how much traffic was received and written by Graylog in the recent days, in bytes

Details on licensed traffic
---------------------------

Graylog has four counters, only the last is counted for the licensed traffic.

- ``org.graylog2.traffic.input``
   the incoming message without any decoding, what is written to the journal before any processing.
- ``org.graylog2.traffic.decoded``
   the message after the codec of the input has parsed the message (for example syslog parser)
- ``org.graylog2.traffic.system-output-traffic``  
   currently, this is stored in memory only and includes the traffic from archive restores.
- ``org.graylog2.traffic.output`` 
   what is written to Elasticsearch after all processing is done. 

Only the Elasticsearch output is measured, all other outgoing traffic does not count.  The measurement happens when the message is serialized to elasticsearch. If a message is written to multiple indices the message will count for each index. It does not matter how many copies (replicas) the index has configured as this is done in elasticsearch. 

Each of the counters follows these rules:

- count the length of the field name.
- If the content of the field is a string, the length of the string is counted not the bytes of that string
- for non-string content in the field, the byte length of that content is counted
    - byte = 1 byte
    - char/short = 2 bytes
    - bool/int/float = 4 bytes
    - long/double = 8 bytes
    - dates = 8 bytes
- all internal fields are not counted (those meta information that are created by Graylog)


