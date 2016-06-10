*************************
Ubuntu Installation 
*************************

This describe the fastest way to install Graylog on Ubuntu 16.04 LTS. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on exposed Servers, this guide does not cover security settings!

Prerequisites
-------------

Taking a minimal Server Setup as base will need this additional packages::

 $ apt-get install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen


MongoDB
-------

The Version included in Ubuntu 16.04 LTS can be used together with Graylog Version 2::

  $ apt-get install mongodb-server

Elasticsearch
-------------

For Graylog Version 2 we need elasticsearch 2.x so we took the Information how to install from `the elastic repo guide <https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html>`_::


  $ wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
  $ echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
  $ sudo apt-get update && sudo apt-get install elasticsearch


Now modify ``/etc/elasticsearch/elasticsearch.yml`` and add ``cluster.name: graylog`` and final start elasticsearch::

  $ sudo /bin/systemctl daemon-reload
  $ sudo /bin/systemctl enable elasticsearch.service

Graylog
-------

Now just install the Graylog Repository and install::

  $ wget https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb 
  $ sudo dpkg -i graylog-2.0-repository_latest.deb
  $ sudo apt-get update && sudo apt-get install graylog-server

Follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. This need to be set, without Graylog will not start!

The last step is to enable Graylog on OS Boot and start the Service::

 $ sudo systemctl daemon-reload
 $ sudo systemctl enable graylog-server.service
 $ sudo systemctl start graylog-server.service

Feedback
--------

Please open an `issue <https://github.com/Graylog2/fpm-recipes/issues>`_ in the `Github repository <https://github.com/Graylog2/fpm-recipes>`_ if you
run into any packaging related issues. **Thank you!**
