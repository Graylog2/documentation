*******************
Ubuntu installation
*******************

This guide describes the fastest way to install Graylog on Ubuntu 16.04 LTS. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on publicly exposed servers. This guide **does not cover** security settings!


Prerequisites
-------------

Taking a minimal server setup as base will need this additional packages::

    $ sudo apt-get update && sudo apt-get upgrade
    $ sudo apt-get install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen


MongoDB
-------

The Version included in Ubuntu 16.04 LTS can be used together with Graylog 2.3.x and higher::

    $ sudo apt-get install mongodb-server


Elasticsearch
-------------

Graylog 2.3.x can be used with Elasticsearch 5.x, please follow the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/5.4/deb.html>`__::


    $ wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    $ echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
    $ sudo apt-get update && sudo apt-get install elasticsearch

Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/5.4/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set the cluster name to ``graylog`` additionally you need to uncomment (remove the # as first character) the line::

    cluster.name: graylog

After you have modified the configuration, you can start Elasticsearch::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl restart elasticsearch.service


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

    $ wget https://packages.graylog2.org/repo/packages/graylog-2.3-repository_latest.deb
    $ sudo dpkg -i graylog-2.3-repository_latest.deb
    $ sudo apt-get update && sudo apt-get install graylog-server

Follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. These settings are mandatory and without them, Graylog will not start!

You need to use the following command to create your ``root_password_sha2``::

    echo -n yourpassword | sha256sum

To be able to connect to Graylog you should set ``rest_listen_uri`` and ``web_listen_uri`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable graylog-server.service
    $ sudo systemctl start graylog-server.service

The next step is to :ref:`ingest messages <ingest_data>` into your Graylog and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.


Cluster Setup
---------------------

If you plan to have multiple servers assuming different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` lists the locations of the files you need to modify.


Feedback
--------

Please file a `bug report in the GitHub repository for the operating system packages <https://github.com/Graylog2/fpm-recipes>`__ if you
run into any packaging related issues.

If you found this documentation confusing or have more questions, please open an `issue in the Github repository for the documentation <https://github.com/Graylog2/documentation/issues>`__.
