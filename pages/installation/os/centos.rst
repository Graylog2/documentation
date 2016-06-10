*************************
CentOS Installation 
*************************

This describe the fastest way to install Graylog on CentOS 7. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on exposed Servers, this guide does not cover security settings!

Prerequisites
-------------

Taking a minimal Server Setup as base will need this additional packages::

 $ sudo yum install java-1.8.0-openjdk-headless.x86_64

If you like to use ``pwgen`` later on you need to Setup `epel <https://fedoraproject.org/wiki/EPEL>`_ on your system with ``sudo yum install epel-release`` and install the package with ``sudo yum install pwgen``

MongoDB
-------

Installing MongoDB on CentOS should follow `the tutorial for redhat <https://docs.mongodb.com/master/tutorial/install-mongodb-on-red-hat>`_ on the MongoDB Documentation. First add the repository file ``/etc/yum.repos.d/mongodb-org-3.2.repo`` with the content::

  [mongodb-org-3.2]
  name=MongoDB Repository
  baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
  gpgcheck=1
  enabled=1
  gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc

then followed by the installation of the latest release with ``sudo yum install -y mongodb-org``. Additional this last Steps to activate the MongoDB on Boot and start it direct::

 $ sudo setenforce 0
 $ sudo systemctl start mongod.service
 $ sudo chkconfig --add mongo


Elasticsearch
-------------

For Graylog Version 2 we need elasticsearch 2.x so we took the Information how to install from `the elastic repo guide <https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html>`_. First install the elastic GPG Key ``rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch`` then add the repository file ``/etc/yum.repos.d/elasticsearch.repo`` with the content::

 [elasticsearch-2.x]
 name=Elasticsearch repository for 2.x packages
 baseurl=https://packages.elastic.co/elasticsearch/2.x/centos
 gpgcheck=1
 gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
 enabled=1

followed by the installation of the latest release with ``sudo yum install elasticsearch``. Make sure to modify ``/etc/elasticsearch/elasticsearch.yml`` and add ``cluster.name: graylog`` and final start elasticsearch::

  $ sudo chkconfig --add elasticsearch
  $ sudo systemctl daemon-reload
  $ sudo systemctl enable elasticsearch.service
  $ sudo systemctl restart elasticsearch.service

Graylog
-------

Now just install the Graylog Repository and install::

 $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.rpm
 $ sudo yum install graylog-server

Follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. This need to be set, without Graylog will not start!

The last step is to enable Graylog on OS Boot and start the Service::

 $ sudo systemctl daemon-reload
 $ sudo systemctl enable graylog-server.service
 $ sudo systemctl start graylog-server.service

Feedback
--------

Please open an `issue <https://github.com/Graylog2/fpm-recipes/issues>`_ in the `Github repository <https://github.com/Graylog2/fpm-recipes>`_ if you
run into any packaging related issues. **Thank you!**
