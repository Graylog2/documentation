*******************
Ubuntu installation
*******************

This guide describes the fastest way to install Graylog on Ubuntu 16.04 LTS. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on publicly exposed servers. This guide **does not cover** security settings!


Prerequisites
-------------

Taking a minimal server setup as base will need this additional packages::

  $ apt-get install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen


MongoDB
-------

The Version included in Ubuntu 16.04 LTS can be used together with Graylog 2.0.0 and higher::

  $ apt-get install mongodb-server


Elasticsearch
-------------

Graylog 2.0.0 and higher requires Elasticsearch 2.x, so we took the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-repositories.html#_apt>`__::


  $ wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
  $ echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
  $ sudo apt-get update && sudo apt-get install elasticsearch


Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-configuration.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set `the cluster name <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-configuration.html#cluster-name>`__ to ``graylog``::

  cluster.name: graylog

After you have modified the configuration, you can start Elasticsearch::

  $ sudo /bin/systemctl daemon-reload
  $ sudo /bin/systemctl enable elasticsearch.service
  $ sudo /bin/systemctl restart elasticsearch.service


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

  $ wget https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb 
  $ sudo dpkg -i graylog-2.0-repository_latest.deb
  $ sudo apt-get update && sudo apt-get install graylog-server

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
