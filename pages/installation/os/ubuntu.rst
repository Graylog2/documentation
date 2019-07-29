*******************
Ubuntu installation
*******************

This guide describes the fastest way to install Graylog on Ubuntu 18.04 LTS. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on publicly exposed servers. This guide **does not cover** security settings!


Prerequisites
-------------

Taking a minimal server setup as base will need this additional packages::

    $ sudo apt-get update && sudo apt-get upgrade
    $ sudo apt-get install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen


MongoDB
-------

The official MongoDB repository provides the most up-to-date version and is the recommended way of installing MongoDB [#]_::

    $ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 
    $ echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    $ sudo apt-get update
    $ sudo apt-get install -y mongodb-org  
  
.. [#] For e.g. corporate proxies and other non-free environments you can use a keyserver approach via wget.
    ``wget -qO- 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9DA31620334BD75D9DCB49F368818C72E52529D4' | sudo apt-key add -``

The last step is to enable MongoDB during the operating system's startup::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable mongod.service
    $ sudo systemctl restart mongod.service
    

Elasticsearch
-------------

Graylog can be used with Elasticsearch 6.x, please follow the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/6.6/deb.html>`__::


    $ wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    $ echo "deb https://artifacts.elastic.co/packages/oss-6.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-6.x.list
    $ sudo apt-get update && sudo apt-get install elasticsearch-oss

Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set the cluster name to ``graylog`` additionally you need to uncomment (remove the # as first character) the line, and add ``action.auto_create_index: false`` to the configuration file::

    cluster.name: graylog
    action.auto_create_index: false


After you have modified the configuration, you can start Elasticsearch::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl restart elasticsearch.service


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

    $ wget https://packages.graylog2.org/repo/packages/graylog-3.0-repository_latest.deb
    $ sudo dpkg -i graylog-3.0-repository_latest.deb
    $ sudo apt-get update && sudo apt-get install graylog-server

Follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. These settings are mandatory and without them, Graylog will not start!

You need to use the following command to create your ``root_password_sha2``::

    echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

To be able to connect to Graylog you should set ``http_bind_address`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable graylog-server.service
    $ sudo systemctl start graylog-server.service

The next step is to :ref:`ingest messages <ingest_data>` into your Graylog and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.


Multiple Server Setup
---------------------

If you plan to have multiple server taking care of different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` will give you the file you need to modify in your setup.



