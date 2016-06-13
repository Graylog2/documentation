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

After that, install the latest release of MongoDB with ``sudo yum install -y mongodb-org``.

Additionally, run these last steps to start MongoDB during the operating system's boot and start it right away::

  $ sudo setenforce 0
  $ sudo chkconfig --add mongo
  $ sudo systemctl start mongod.service


Elasticsearch
-------------

Graylog 2.0.0 and higher requires Elasticsearch 2.x, so we took the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-repositories.html#_yum_dnf>`_.

First install the Elastic GPG key with ``rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch`` then add the repository file ``/etc/yum.repos.d/elasticsearch.repo`` with the following contents::

  [elasticsearch-2.x]
  name=Elasticsearch repository for 2.x packages
  baseurl=https://packages.elastic.co/elasticsearch/2.x/centos
  gpgcheck=1
  gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
  enabled=1

followed by the installation of the latest release with ``sudo yum install elasticsearch``.

Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-configuration.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set `the cluster name <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-configuration.html#cluster-name>`__ to ``graylog``::

  cluster.name: graylog

After you have modified the configuration, you can start Elasticsearch::

  $ sudo chkconfig --add elasticsearch
  $ sudo systemctl daemon-reload
  $ sudo systemctl enable elasticsearch.service
  $ sudo systemctl restart elasticsearch.service


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.rpm
  $ sudo yum install graylog-server

Follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. These settings are mandatory and without them, Graylog will not start!

The last step is to enable Graylog during the operating system's startup::

  $ sudo systemctl daemon-reload
  $ sudo systemctl enable graylog-server.service
  $ sudo systemctl start graylog-server.service


Feedback
--------

Please open an `issue in the Github repository for the operating system packages <https://github.com/Graylog2/fpm-recipes>`__ if you
run into any packaging related issues.

**Thank you!**
