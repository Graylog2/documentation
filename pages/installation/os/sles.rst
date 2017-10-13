*******************
SLES installation
*******************

This guide describes the fastest way to install Graylog on SLES 12 SP3. All links and packages are present at the time of writing but might need to be updated later on.

.. warning:: This setup should not be done on publicly exposed servers. This guide **does not cover** security settings!


Prerequisites
-------------

The following Patterns are use as a minimal server setup::

  - Base System
  - Minimal System (Appliances)
  - Yast configuration packages

.. warning:: This Guide makes the assumption that the firewall is disabled and communication is possible to the outside world.

Taking a minimal server setup as base will need this additional packages::

  $ sudo zypper install java-1_8_0-openjdk


MongoDB
-------

Installing MongoDB on SLES should follow `the tutorial for SLES <https://docs.mongodb.com/v3.4/tutorial/install-mongodb-on-suse/>`_ from the MongoDB documentation. Add the GPG Key and the Repository before you install MongoDB::

  $ sudo rpm --import https://www.mongodb.org/static/pgp/server-3.4.asc
  $ sudo zypper addrepo --gpgcheck "https://repo.mongodb.org/zypper/suse/12/mongodb-org/3.4/x86_64/" mongodb
  $ sudo zypper -n install mongodb-org



Additionally, run these last steps to start MongoDB during the operating system's boot and start it right away::

  $ sudo chkconfig mongod on
  $ sudo systemctl daemon-reload
  $ sudo systemctl restart mongod.service


Elasticsearch
-------------

Graylog 2.3.x can be used with Elasticsearch 5.x, please follow the installation instructions from `the Elasticsearch installation guide <https://www.elastic.co/guide/en/elasticsearch/reference/5.6/rpm.html>`_.

First install the Elastic GPG key with ``rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch`` then add the repository file ``/etc/zypp/repos.d/elasticsearch.repo`` with the following contents::

    [elasticsearch-5.x]
    name=Elasticsearch repository for 5.x packages
    baseurl=https://artifacts.elastic.co/packages/5.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md

followed by the installation of the latest release with ``sudo zypper install elasticsearch``.

Make sure to modify the `Elasticsearch configuration file <https://www.elastic.co/guide/en/elasticsearch/reference/5.6/settings.html#settings>`__  (``/etc/elasticsearch/elasticsearch.yml``) and set the cluster name to ``graylog`` additionally you need to uncomment (remove the # as first character) the line::

    cluster.name: graylog

After you have modified the configuration, you can start Elasticsearch::

    $ sudo chkconfig elasticsearch on
    $ sudo systemctl daemon-reload
    $ sudo systemctl restart elasticsearch.service


Graylog
-------

First install the Graylog GPG Key with ``rpm --import https://raw.githubusercontent.com/Graylog2/fpm-recipes/master/recipes/graylog-repository/files/rpm/RPM-GPG-KEY-graylog`` then add the repository file ``/etc/zypp/repos.d/graylog.repo`` with the following content::

    [graylog]
    name=graylog
    baseurl=https://packages.graylog2.org/repo/el/stable/2.3/$basearch/
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-graylog

followed by the installation of the latest release with ``sudo zypper install graylog-server``.

Make sure to follow the instructions in your ``/etc/graylog/server/server.conf`` and add ``password_secret`` and ``root_password_sha2``. These settings are mandatory and without them, Graylog will not start!

You need to use the following command to create your ``password_secret``::

    cat /dev/urandom | base64 | cut -c1-96 | head -1

You need to use the following command to create your ``root_password_sha2``::

    echo -n yourpassword | sha256sum

To be able to connect to Graylog you should set ``rest_listen_uri`` and ``web_listen_uri`` to the public host name or a public IP address of the machine you can connect to. More information about these settings can be found in :ref:`Configuring the web interface <configuring_webif>`.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

The last step is to enable Graylog during the operating system's startup::

  $ sudo chkconfig graylog-server on
  $ sudo systemctl daemon-reload
  $ sudo systemctl start graylog-server.service

The next step is to :ref:`ingest messages <ingest_data>` into your Graylog and extract the messages with :ref:`extractors <extractors>` or use :ref:`the Pipelines <pipelinestoc>` to work with the messages.



Multiple Server Setup
---------------------

If you plan to have multiple server taking care of different roles in your cluster :ref:`like we have in this big production setup <big_production_setup>` you need to modify only a few settings. This is covered in our :ref:`Multi-node Setup guide<configure_multinode>`. The :ref:`default file location guide <default_file_location>` will give you the file you need to modify in your setup.


Feedback
--------

Please file a `bug report in the GitHub repository for the operating system packages <https://github.com/Graylog2/fpm-recipes>`__ if you
run into any packaging related issues.

If you found this documentation confusing or have more questions, please open an `issue in the Github repository for the documentation <https://github.com/Graylog2/documentation/issues>`__.
