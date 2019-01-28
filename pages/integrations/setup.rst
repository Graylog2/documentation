******************
Integrations Setup
******************

Integrations are tools that help Graylog work with external systems and will typically be content packs, inputs, or lookup tables.

Integrations are distributed in two plugins:

* ``graylog-plugin-integrations``
* ``graylog-plugin-enterprise-integrations``

.. important:: The plugins needs to be installed on all your Graylog nodes!

Installation
============

To install the plugins, you can use one of the following options.


Operating System Packages
-------------------------

If you have installed Graylog using linux system packages (as described in the :doc:`/pages/installation/operating_system_packages` installation guides), then you can use the following DEB or RPM operating system packages.

DEB
~~~

The installation on distributions like Debian or Ubuntu can be done with *apt-get* as installation tool from the previous installed online repository.

::

  $ sudo apt-get install graylog-plugin-integrations graylog-plugin-enterprise-integrations


RPM
~~~

The installation on distributions like CentOS or RedHat can be done with *yum* as installation tool from the previous installed online repository.

::

  $ sudo yum install graylog-plugin-integrations graylog-plugin-enterprise-integrations


Jar File
~~~~~~~~

You can also download and install the plugin JAR files. See the :ref:`Plugins <installing_and_loading_plugins>` page for instructions.


Server Restart
==============

Make sure to restart your Graylog servers once the plugins are installed.

Installation Success
====================

The following server log message will indicate that each plugin was installed properly.

::

    INFO: [CmdLineTool] Loaded plugin: Integrations Plugin 3.0.0 [org.graylog.integrations.IntegrationsPlugin]
    INFO: [CmdLineTool] Loaded plugin: Enterprise Integrations Plugin 3.0.0 [org.graylog.integrations.EnterpriseIntegrationsPlugin]


**Downloads URLs**

* :integrations-plugin-deb:`3.0.0+0`

* :integrations-plugin-rpm:`3.0.0+0`

* :integrations-plugin-jar:`3.0.0+0`
