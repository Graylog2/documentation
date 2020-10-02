******************
Integrations Setup
******************

Integrations are tools that help Graylog work with external systems and will typically be content packs, inputs, or lookup tables.

Integrations are distributed in two plugins:

* ``graylog-integrations-plugins``
* ``graylog-enterprise-integrations-plugins``

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

  $ sudo apt-get install graylog-integrations-plugins graylog-enterprise-integrations-plugins


RPM
~~~

The installation on distributions like CentOS or RedHat can be done with *yum* as installation tool from the previous installed online repository.

::

  $ sudo yum install graylog-integrations-plugins graylog-enterprise-integrations-plugins

Tarballs
^^^^^^^^

If you have done a manual installation, you download the tarballs from the following links.


.. list-table:: Integrations Plugins download
    :header-rows: 1

    * - Integrations Version
      - Download URL
    * - 3.3.0
      - :integrations-plugins-tar:`3.3.0`
    * - 3.3.1
      - :integrations-plugins-tar:`3.3.1`
    * - 3.3.2
      - :integrations-plugins-tar:`3.3.2`
    * - 3.3.3
      - :integrations-plugins-tar:`3.3.3`       
    * - 3.3.4
      - :integrations-plugins-tar:`3.3.4`
    * - 3.3.5
      - :integrations-plugins-tar:`3.3.5`
    * - 3.3.6
      - :integrations-plugins-tar:`3.3.6`


.. list-table:: Enterprise Integrations Plugins download
    :header-rows: 1

    * - Enterprise Integrations Version
      - Download URL
    * - 3.3.0
      - :enterprise-integrations-plugins-tar:`3.3.0`
    * - 3.3.1
      - :enterprise-integrations-plugins-tar:`3.3.1`
    * - 3.3.2
      - :enterprise-integrations-plugins-tar:`3.3.2`
    * - 3.3.3
      - :enterprise-integrations-plugins-tar:`3.3.3`       
    * - 3.3.4
      - :enterprise-integrations-plugins-tar:`3.3.4`
    * - 3.3.5
      - :enterprise-integrations-plugins-tar:`3.3.5`
    * - 3.3.6
      - :enterprise-integrations-plugins-tar:`3.3.6`


.. note:: The integrations plugins need to be the same version as the Graylog server.


Server Restart
==============

Make sure to restart your Graylog servers once the plugins are installed.

Installation Success
====================

The following server log message will indicate that each plugin was installed properly.

::

    INFO: [CmdLineTool] Loaded plugin: Integrations Plugin 3.2.0 [org.graylog.integrations.IntegrationsPlugin]
    INFO: [CmdLineTool] Loaded plugin: Enterprise Integrations Plugin 3.2.0 [org.graylog.integrations.EnterpriseIntegrationsPlugin]

