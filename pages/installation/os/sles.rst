.. _sleguide:

*******************
SLES installation
*******************

This guide describes the fastest way to install Graylog on SLES 12 SP3. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This guide **does not cover** security settings! The server administrator must make sure the graylog server is not publicly exposed, and is following standard security best practices.


Prerequisites
-------------

The following patterns are required for a minimal setup (see `SLES 12 SP3 Deployment Guide <https://www.suse.com/documentation/sles-12/singlehtml/book_sle_deployment/book_sle_deployment.html#sec.i.yast2.proposal.sofware>`_)::

  - Base System
  - Minimal System (Appliances)
  - YaST configuration packages

.. warning:: This Guide assumes that the firewall is disabled and communication is possible to the outside world.

Assuming a minimal setup, you have to install the Java runtime environment::

  $ sudo zypper install java-1_8_0-openjdk

MongoDB
-------

Installing MongoDB on SLES should follow `the tutorial for SLES <https://docs.mongodb.com/v4.0/tutorial/install-mongodb-on-suse/>`_ from the MongoDB documentation. Add the GPG key and the repository before installing MongoDB::

  $ sudo rpm --import https://www.mongodb.org/static/pgp/server-4.0.asc
  $ sudo zypper addrepo --gpgcheck "https://repo.mongodb.org/zypper/suse/12/mongodb-org/4.0/x86_64/" mongodb
  $ sudo zypper -n install mongodb-org

In order to automatically start MongoDB on system boot, you have to activate the MongoDB service by running the following commands::

  $ sudo chkconfig mongod on
  $ sudo systemctl daemon-reload
  $ sudo systemctl restart mongod.service

Elasticsearch
-------------

Graylog can be used with Elasticsearch 6.x, please follow the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/rpm.html>`_.

First install the Elastic GPG key with ``rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch`` then add the repository file ``/etc/zypp/repos.d/elasticsearch.repo`` with the following contents::

    [elasticsearch-6.x]
    name=Elasticsearch repository for 6.x packages
    baseurl=https://artifacts.elastic.co/packages/oss-6.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md

followed by the installation of the latest release with ``sudo zypper install elasticsearch-oss``.

Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set the cluster name to ``graylog`` and uncomment ``action.auto_create_index: false`` to enable the action::

    $ sudo tee -a /etc/elasticsearch/elasticsearch.yml > /dev/null <<EOT
    cluster.name: graylog
    action.auto_create_index: false
    EOT


In order to automatically start Elasticsearch on system boot, you have to activate the Elasticsearch service by running the following commands::

    $ sudo chkconfig elasticsearch on
    $ sudo systemctl daemon-reload
    $ sudo systemctl restart elasticsearch.service

Graylog
-------

First install the Graylog GPG Key with ``rpm --import https://packages.graylog2.org/repo/debian/keyring.gpg`` then add the repository file ``/etc/zypp/repos.d/graylog.repo`` with the following content::

    [graylog]
    name=graylog
    baseurl=https://packages.graylog2.org/repo/el/stable/3.3/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-graylog

After that, install the latest release with ``sudo zypper install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins``.

.. hint:: If you do not want the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, then simply run ``sudo zypper install graylog-server``

Make sure to follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. These settings are mandatory and without them, Graylog will not start!

You can use the following command to create your ``password_secret``::

    cat /dev/urandom | base64 | cut -c1-96 | head -1

You need to use the following command to create your ``root_password_sha2``::

    echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

To be able to connect to Graylog you should set ``http_bind_address`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup::

  $ sudo chkconfig graylog-server on
  $ sudo systemctl daemon-reload
  $ sudo systemctl start graylog-server.service

The next step is to :ref:`ingest messages <ingest_data>` into your new Graylog Cluster and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.

Cluster Setup
---------------------

If you plan to have multiple servers assuming different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` lists the locations of the files you need to modify.


