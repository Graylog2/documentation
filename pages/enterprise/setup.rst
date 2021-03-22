.. _enterprise-setup:

*****
Setup
*****

Graylog Enterprise comes as a single package that includes Graylog Server and the following plugins:

- Enterprise plugin
- Integrations plugin
- Enterprise Integrations plugin

If you're already running an open source instance, you can :ref:`install these plugins separately<enterprise-setup-updateoss>` to convert it to an Enterprise instance.


Requirements
============

.. warning:: We caution you not to upgrade Elasticsearch to 7.11! You are absolutely forbidden to upgrade to this version. If you do so, it will break your instance!

Graylog Enterprise has the following prerequisites:

* Some modern Linux distribution (Debian Linux, Ubuntu Linux, or CentOS recommended)
* `Elasticsearch 6.8+ or 7 <https://www.elastic.co/downloads/elasticsearch>`_
* `MongoDB 3.6, 4.0 or 4.2 <https://docs.mongodb.org/manual/administration/install-on-linux/>`_
* Oracle Java SE 8 (OpenJDK 8 also works; latest stable update is recommended)

Installation
============


DEB / APT
---------

For installation on apt-based systems (such as Debian or Ubuntu), run the following commands::

  $ sudo apt-get install apt-transport-https
  $ wget https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb
  $ sudo dpkg -i graylog-4.0-repository_latest.deb
  $ sudo apt-get update
  $ sudo apt-get install graylog-enterprise


RPM / YUM / DNF
---------------

For installation on rpm-based systems (such as CentOS or Redhat), run the following commands::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.rpm
  $ sudo yum install graylog-enterprise


Edit the Configuration File
----------------------------

Read the instructions *within* the configuration file and edit as needed. It is located at: ``/etc/graylog/server/server.conf``.  Additionally add ``password_secret`` and ``root_password_sha2`` as these are *mandatory* and **Graylog will not start without them**.

To create your ``root_password_sha2`` run the following command::

    $ echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

To be able to connect to Graylog you should set ``http_bind_address`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.


Starting Graylog
----------------
Graylog can be started with the following commands. Make sure to use the correct command for your operating system.

======================================== =========== =======================================
OS                                       Init System Command
======================================== =========== =======================================
CentOS 6                                 SysV        ``sudo service graylog-server start``
CentOS 7, 8                              systemd     ``sudo systemctl start graylog-server``
Debian 7                                 SysV        ``sudo service graylog-server start``
Debian 8 & 9, Ubuntu 16.04, 18.04, 20.04 systemd     ``sudo systemctl start graylog-server``
======================================== =========== =======================================


The packages are configured to **not** start any Graylog services during boot. You can use the following commands to start Graylog when the operating system is booting.

======================================== =========== ==================================================
OS                                       Init System Command
======================================== =========== ==================================================
CentOS 6                                 SysV        ``sudo update-rc.d graylog-server defaults 95 10``
CentOS 7, 8                              systemd     ``sudo systemctl enable graylog-server``
Debian 7                                 SysV        ``sudo update-rc.d graylog-server defaults 95 10``
Debian 8 & 9, Ubuntu 16.06, 18.04, 20.04 systemd     ``sudo systemctl enable graylog-server``
======================================== =========== ==================================================

Cluster Setup
=============

If you run a Graylog cluster you need to add the enterprise plugins to every Graylog node. Additionally your load-balancer must route ``/api/plugins/org.graylog.plugins.archive/`` only to the Graylog master node. Future versions of Graylog will forward these requests automatically to the correct node.


Update Graylog Enterprise
=========================

.. toctree::
   :titlesonly:

   setup/updating.rst
   setup/update-oss-to-enterprise.rst
