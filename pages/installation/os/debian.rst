.. _debianguide:

*******************
Debian installation
*******************

This guide describes the fastest way to install Graylog on Debian Linux 10 (Buster). All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This guide **does not cover** security settings! The server administrator must make sure the graylog server is not publicly exposed, and is following security best practices.


Prerequisites
-------------

If you're starting from a minimal server setup, you will need to install these additional packages::

  $ sudo apt update && sudo apt upgrade
  $ sudo apt install apt-transport-https openjdk-11-jre-headless uuid-runtime pwgen dirmngr gnupg wget 


MongoDB
-------

The official MongoDB repository provides the most up-to-date version and is the recommended way of installing MongoDB::

  $ wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
  $ echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
  $ sudo apt-get update 
  $ sudo apt-get install -y mongodb-org

The next step is to enable MongoDB during the operating system's startup::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable mongod.service
    $ sudo systemctl restart mongod.service
    $ sudo systemctl --type=service --state=active | grep mongod

The final last step is to make MongoDB run in `4.0` compatibility mode. This is needed at the time of writing.::

    $ mongo --eval " db.adminCommand( { setFeatureCompatibilityVersion: \"4.0\" } ) "

.. warning:: The above is important, otherwise Graylog will not work with this MongoDB Version!
  

Elasticsearch
-------------

Graylog can be used with Elasticsearch 6.x, please follow the below instructions to install the open source version of Elasticsearch. ::

    $ wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    $ echo "deb https://artifacts.elastic.co/packages/oss-6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
    $ sudo apt update && sudo apt install elasticsearch-oss

The above instructions are a derivative from the `Elasticsearch install page <https://www.elastic.co/guide/en/elasticsearch/reference/6.8/deb.html>`__


Modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``)
and set the cluster name to ``graylog`` and uncomment ``action.auto_create_index: false`` to enable the action::

    $ sudo vim /etc/elasticsearch/elasticsearch.yml

    cluster.name: graylog
    action.auto_create_index: false

After you have modified the configuration, you can start Elasticsearch and verify it is running. ::

    $ sudo systemctl daemon-reload
    $ sudo systemctl enable elasticsearch.service
    $ sudo systemctl restart elasticsearch.service
    $ sudo systemctl restart elasticsearch.service


Graylog
-------

Now install the Graylog repository configuration and Graylog itself with the following commands::

  $ wget https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.deb
  $ sudo dpkg -i graylog-3.2-repository_latest.deb
  $ sudo apt-get update && sudo apt-get install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins

.. hint:: If you do not want the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, then simply run ``sudo apt-get install graylog-server``


Edit the Configuration File
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Read the instructions *within* the configurations file and edit as needed, located at ``/etc/graylog/server/server.conf``.  Additionally add ``password_secret`` and ``root_password_sha2`` as these are *mandatory* and **Graylog will not start without them**.

To create your ``root_password_sha2`` run the following command::

  echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

To be able to connect to Graylog you should set ``http_bind_address`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup and verify it is running. ::

  $ sudo systemctl daemon-reload
  $ sudo systemctl enable graylog-server.service
  $ sudo systemctl start graylog-server.service
  $ sudo systemctl --type=service --state=active | grep graylog


The next step is to :ref:`ingest messages <ingest_data>` into your Graylog and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.

Multiple Server Setup
---------------------

If you plan to have multiple server taking care of different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` will give you the file you need to modify in your setup.

