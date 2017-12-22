*******************
CentOS installation
*******************

This guide describes the fastest way to install Graylog on CentOS 7. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on publicly exposed servers. This guide **does not cover** security settings!


Prerequisites
-------------

Taking a minimal server setup as base will need this additional packages::

  $ sudo yum install java-1.8.0-openjdk-headless.x86_64

If you want to use ``pwgen`` later on you need to Setup `EPEL <https://fedoraproject.org/wiki/EPEL>`_ on your system with ``sudo yum install epel-release`` and install the package with ``sudo yum install pwgen``.


MongoDB
-------

Installing MongoDB on CentOS should follow `the tutorial for RHEL and CentOS <https://docs.mongodb.com/master/tutorial/install-mongodb-on-red-hat>`_ from the MongoDB documentation. First add the repository file ``/etc/yum.repos.d/mongodb-org-3.2.repo`` with the following contents::

  [mongodb-org-3.2]
  name=MongoDB Repository
  baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
  gpgcheck=1
  enabled=1
  gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc

After that, install the latest release of MongoDB with ``sudo yum install mongodb-org``.

In order to automatically start MongoDB on system boot, you have to activate the MongoDB service by running the following commands::

  $ sudo chkconfig --add mongod
  $ sudo systemctl daemon-reload
  $ sudo systemctl enable mongod.service
  $ sudo systemctl start mongod.service


Elasticsearch
-------------

Graylog 2.3.x can be used with Elasticsearch 5.x, please follow the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/5.4/rpm.html>`_.

First install the Elastic GPG key with ``rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch`` then add the repository file ``/etc/yum.repos.d/elasticsearch.repo`` with the following contents::

    [elasticsearch-5.x]
    name=Elasticsearch repository for 5.x packages
    baseurl=https://artifacts.elastic.co/packages/5.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md

followed by the installation of the latest release with ``sudo yum install elasticsearch``.

Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/5.4/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set the cluster name to ``graylog`` additionally you need to uncomment (remove the # as first character) the line::

    cluster.name: graylog

In order to automatically start Elasticsearch on system boot, you have to activate the Elasticsearch service by running the following commands::

    $ sudo chkconfig --add elasticsearch
    $ sudo systemctl daemon-reload
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl restart elasticsearch.service


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-2.3-repository_latest.rpm
  $ sudo yum install graylog-server

Follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. These settings are mandatory and without them, Graylog will not start!

You need to use the following command to create your ``root_password_sha2``::

  echo -n yourpassword | sha256sum

To be able to connect to Graylog you should set ``rest_listen_uri`` and ``web_listen_uri`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup::

  $ sudo chkconfig --add graylog-server
  $ sudo systemctl daemon-reload
  $ sudo systemctl enable graylog-server.service
  $ sudo systemctl start graylog-server.service

The next step is to :ref:`ingest messages <ingest_data>` into your new Graylog Cluster and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.

.. _selinux:

SELinux information
-------------------

.. hint:: We assume that you have ``policycoreutils-python`` installed to manage SELinux.

If you're using SELinux on your system, you need to take care of the following settings:

- Allow the web server to access the network: ``sudo setsebool -P httpd_can_network_connect 1``
- If the policy above does not comply with your security policy, you can also allow access to each port individually:
    - Graylog REST API and web interface: ``sudo semanage port -a -t http_port_t -p tcp 9000``
    - Elasticsearch (only if the HTTP API is being used): ``sudo semanage port -a -t http_port_t -p tcp 9200``
- Allow using MongoDB's default port (27017/tcp): ``sudo semanage port -a -t mongod_port_t -p tcp 27017``

If you run a single server environment with :ref:`NGINX or Apache proxy <configuring_webif_nginx>`, enabling the Graylog REST API is enough. All other rules are only required in a multi-node setup. 
Having SELinux disabled during installation and enabling it later, requires you to manually check the policies for MongoDB, Elasticsearch and Graylog.

.. hint:: Depending on your actual setup and configuration, you might need to add more SELinux rules to get to a running setup.


Further reading
^^^^^^^^^^^^^^^

* https://www.nginx.com/blog/nginx-se-linux-changes-upgrading-rhel-6-6/
* https://wiki.centos.org/HowTos/SELinux
* https://wiki.centos.org/TipsAndTricks/SelinuxBooleans
* http://www.serverlab.ca/tutorials/linux/administration-linux/troubleshooting-selinux-centos-red-hat/
* https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/SELinux_Users_and_Administrators_Guide/
* https://www.digitalocean.com/community/tutorials/an-introduction-to-selinux-on-centos-7-part-1-basic-concepts


Cluster Setup
---------------------

If you plan to have multiple servers assuming different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` lists the locations of the files you need to modify.


Feedback
--------

Please file a `bug report in the GitHub repository for the operating system packages <https://github.com/Graylog2/fpm-recipes>`__ if you
run into any packaging related issues.

If you found this documentation confusing or have more questions, please open an `issue in the Github repository for the documentation <https://github.com/Graylog2/documentation/issues>`__.
