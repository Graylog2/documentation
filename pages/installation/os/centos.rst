.. _centosguide:

*******************
CentOS installation
*******************

This guide describes the fastest way to install Graylog on CentOS 7. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This guide **does not cover** security settings! The server administrator must make sure the graylog server is not publicly exposed, and is following security best practices.


Prerequisites
-------------

Taking a minimal server setup as base will need this additional packages::

  $ sudo yum install java-1.8.0-openjdk-headless.x86_64

If you want to use ``pwgen`` later on you need to Setup `EPEL <https://fedoraproject.org/wiki/EPEL>`_ on your system with ``sudo yum install epel-release`` and install the package with ``sudo yum install pwgen``.


MongoDB
-------

Installing MongoDB on CentOS should follow `the tutorial for RHEL and CentOS <https://docs.mongodb.com/master/tutorial/install-mongodb-on-red-hat>`_ from the MongoDB documentation. First add the repository file ``/etc/yum.repos.d/mongodb-org.repo`` with the following contents::

  [mongodb-org-4.0]
  name=MongoDB Repository
  baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.0/x86_64/
  gpgcheck=1
  enabled=1
  gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc

After that, install the latest release of MongoDB with ``sudo yum install mongodb-org``.

Additionally, run these last steps to start MongoDB during the operating system's boot and start it right away::

  $ sudo systemctl daemon-reload
  $ sudo systemctl enable mongod.service
  $ sudo systemctl start mongod.service
  $ sudo systemctl --type=service --state=active | grep mongod



Elasticsearch
-------------

Graylog can be used with Elasticsearch 6.x, please follow the below instructions to install the open source version of Elasticsearch.

First install the Elastic GPG key with ``rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch`` then add the repository file ``/etc/yum.repos.d/elasticsearch.repo`` with the following contents::

    [elasticsearch-6.x]
    name=Elasticsearch repository for 6.x packages
    baseurl=https://artifacts.elastic.co/packages/oss-6.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md

followed by the installation of the latest release with ``sudo yum install elasticsearch-oss``.

Modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``)
and set the cluster name to ``graylog`` and uncomment ``action.auto_create_index: false`` to enable the action::

    $ sudo vim /etc/elasticsearch/elasticsearch.yml

    cluster.name: graylog
    action.auto_create_index: false

After you have modified the configuration, you can start Elasticsearch::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl restart elasticsearch.service
    $ sudo systemctl --type=service --state=active | grep elasticsearch


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.rpm
  $ sudo yum update && sudo yum install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins

.. hint:: If you do not want the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, then simply run ``sudo yum install graylog-server``

Edit the Configuration File
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Read the instructions *within* the configurations file and edit as needed, located at ``/etc/graylog/server/server.conf``.  Additionally add ``password_secret`` and ``root_password_sha2`` as these are *mandatory* and **Graylog will not start without them**.

To create your ``root_password_sha2`` run the following command::

  echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

To be able to connect to Graylog you should set ``http_bind_address`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup::

  $ sudo systemctl daemon-reload
  $ sudo systemctl enable graylog-server.service
  $ sudo systemctl start graylog-server.service
  $ sudo systemctl --type=service --state=active | grep graylog


The next step is to :ref:`ingest messages <ingest_data>` into your Graylog and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.

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


Multiple Server Setup
---------------------

If you plan to have multiple server taking care of different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` will give you the file you need to modify in your setup.

