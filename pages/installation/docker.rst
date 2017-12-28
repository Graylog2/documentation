******
Docker
******

Requirements
============

You will need a fairly recent version of `Docker <https://docs.docker.com/installation/>`__.

We will use the following Docker images in this chapter:

* Graylog: `graylog/graylog <https://hub.docker.com/r/graylog/graylog/>`_
* MongoDB: `mongo <https://hub.docker.com/_/mongo/>`_
* Elasticsearch: `docker.elastic.co/elasticsearch/elasticsearch <https://www.elastic.co/guide/en/elasticsearch/reference/5.5/docker.html>`_


Quick start
===========

If you simply want to checkout Graylog without any further customization, you can run the following three commands to create the necessary environment::

  $ docker run --name mongo -d mongo:3
  $ docker run --name elasticsearch \
      -e "http.host=0.0.0.0" -e "xpack.security.enabled=false" \
      -d docker.elastic.co/elasticsearch/elasticsearch:5.5.1
  $ docker run --link mongo --link elasticsearch \
      -p 9000:9000 -p 12201:12201 -p 514:514 \
      -e GRAYLOG_WEB_ENDPOINT_URI="http://127.0.0.1:9000/api" \
      -d graylog/graylog:2.3.0-1

How to get log data in
----------------------

You can create different kinds of inputs under *System / Inputs*, however you can only use ports that have been properly mapped to your docker container, otherwise data will not go through.

For example, to start a Raw/Plaintext TCP input on port 5555, stop your container and recreate it, whilst appending ``-p 5555:5555`` to your `docker run <https://docs.docker.com/engine/reference/run/>`_ command::

  $ docker run --link mongo --link elasticsearch \
      -p 9000:9000 -p 12201:12201 -p 514:514 -p 5555:5555 \
      -e GRAYLOG_WEB_ENDPOINT_URI="http://127.0.0.1:9000/api" \
      -d graylog/graylog:2.3.0-1


Similarly, the same can be done for UDP by appending ``-p 5555:5555/udp``.

After that you can send a plaintext message to the Graylog Raw/Plaintext TCP input running on port 5555 using the following command::

  $ echo 'First log message' | nc localhost 5555


Settings
--------

Graylog comes with a default configuration that works out of the box but you have to set a password for the admin user and the web interface needs to know how to connect from your browser to the Graylog REST API.

Both settings can be configured via environment variables (also see :ref:`configuration`)::

  -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
  -e GRAYLOG_WEB_ENDPOINT_URI="http://127.0.0.1:9000/api"

In this case you can login to Graylog with the username and password ``admin``.

Generate your own admin password with the following command and put the SHA-256 hash into the ``GRAYLOG_ROOT_PASSWORD_SHA2`` environment variable::

  $ echo -n yourpassword | shasum -a 256


All these settings and command line parameters can be put in a ``docker-compose.yml`` file, so that they don't have to be executed one after the other.

Example::

  version: '2'
  services:
    # MongoDB: https://hub.docker.com/_/mongo/
    mongodb:
      image: mongo:3
    # Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/docker.html
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:5.5.1
      environment:
        - http.host=0.0.0.0
        - transport.host=localhost
        - network.host=0.0.0.0
        # Disable X-Pack security: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/security-settings.html#general-security-settings
        - xpack.security.enabled=false
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      ulimits:
        memlock:
          soft: -1
          hard: -1
      mem_limit: 1g
    # Graylog: https://hub.docker.com/r/graylog/graylog/
    graylog:
      image: graylog/graylog:2.3.0-1
      environment:
        # CHANGE ME!
        - GRAYLOG_PASSWORD_SECRET=somepasswordpepper
        # Password: admin
        - GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
        - GRAYLOG_WEB_ENDPOINT_URI=http://127.0.0.1:9000/api
      links:
        - mongodb:mongo
        - elasticsearch
      depends_on:
        - mongodb
        - elasticsearch
      ports:
        # Graylog web interface and REST API
        - 9000:9000
        # Syslog TCP
        - 514:514
        # Syslog UDP
        - 514:514/udp
        # GELF TCP
        - 12201:12201
        # GELF UDP
        - 12201:12201/udp

After starting all three Docker containers by running ``docker-compose up``, you can open the URL ``http://127.0.0.1:9000`` in a web browser and log in with username ``admin`` and password ``admin`` (make sure to change the password later).


.. _configuration:

Configuration
=============

Every configuration option can be set via `environment variables <https://github.com/Graylog2/graylog2-server/blob/2.3/misc/graylog.conf>`__.
Simply prefix the parameter name with ``GRAYLOG_`` and put it all in upper case.

For example, setting up the SMTP configuration for sending Graylog alert notifications via email, the ``docker-compose.yml`` would look like this::

  version: '2'
  services:
    mongo:
      image: "mongo:3"
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:5.5.1
      # Other settings [...]
    graylog:
      image: graylog/graylog:2.3.0-1
      # Other settings [...]
      environment:
        GRAYLOG_TRANSPORT_EMAIL_ENABLED: "true"
        GRAYLOG_TRANSPORT_EMAIL_HOSTNAME: smtp
        GRAYLOG_TRANSPORT_EMAIL_PORT: 25
        GRAYLOG_TRANSPORT_EMAIL_USE_AUTH: "false"
        GRAYLOG_TRANSPORT_EMAIL_USE_TLS: "false"
        GRAYLOG_TRANSPORT_EMAIL_USE_SSL: "false"

Another option would be to store the configuration file outside of the container and edit it directly.


Custom configuration files
--------------------------

Instead of using a long list of environment variables to configure Graylog (see :ref:`configuration`), you can also overwrite the bundled Graylog configuration files.

The bundled configuration files are stored in ``/usr/share/graylog/data/config/`` inside the Docker container.

Create the new configuration directory next to the ``docker-compose.yml`` file and copy the default files from GitHub::

  $ mkdir -p ./graylog/config
  $ cd ./graylog/config
  $ wget https://raw.githubusercontent.com/Graylog2/graylog-docker/2.3/config/graylog.conf
  $ wget https://raw.githubusercontent.com/Graylog2/graylog-docker/2.3/config/log4j2.xml

The newly created directory ``./graylog/config/`` with the custom configuration files now has to be mounted into the Graylog Docker container.

This can be done by adding an entry to the `volumes <https://docs.docker.com/compose/compose-file/#volume-configuration-reference>`__ section of the ``docker-compose.yml`` file::

  version: '2'
  services:
    mongodb:
      image: mongo:3
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:5.5.1
      # Other settings [...]
    graylog:
      image: graylog/graylog:2.3.0-1
      # Other settings [...]
      volumes:
        # Mount local configuration directory into Docker container
        - ./graylog/config:/usr/share/graylog/data/config



.. _persisting-data:

Persisting data
===============

In order to make the recorded data persistent, you can use external volumes to store all data.

In case of a container restart, this will simply re-use the existing data from the former instances.

Using Docker volumes for the data of MongoDB, Elasticsearch, and Graylog, the ``docker-compose.yml`` file looks as follows::

  version: '2'
  services:
    # MongoDB: https://hub.docker.com/_/mongo/
    mongodb:
      image: mongo:3
      volumes:
        - mongo_data:/data/db
    # Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/docker.html
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:5.5.1
      volumes:
        - es_data:/usr/share/elasticsearch/data
      environment:
        - http.host=0.0.0.0
        - transport.host=localhost
        - network.host=0.0.0.0
        # Disable X-Pack security: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/security-settings.html#general-security-settings
        - xpack.security.enabled=false
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      ulimits:
        memlock:
          soft: -1
          hard: -1
      mem_limit: 1g
    # Graylog: https://hub.docker.com/r/graylog/graylog/
    graylog:
      image: graylog/graylog:2.3.0-1
      volumes:
        - graylog_journal:/usr/share/graylog/data/journal
      environment:
        # CHANGE ME!
        - GRAYLOG_PASSWORD_SECRET=somepasswordpepper
        # Password: admin
        - GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
        - GRAYLOG_WEB_ENDPOINT_URI=http://127.0.0.1:9000/api
      links:
        - mongodb:mongo
        - elasticsearch
      depends_on:
        - mongodb
        - elasticsearch
      ports:
        # Graylog web interface and REST API
        - 9000:9000
        # Syslog TCP
        - 514:514
        # Syslog UDP
        - 514:514/udp
        # GELF TCP
        - 12201:12201
        # GELF UDP
        - 12201:12201/udp
  # Volumes for persisting data, see https://docs.docker.com/engine/admin/volumes/volumes/ 
  volumes:
    mongo_data:
      driver: local
    es_data:
      driver: local
    graylog_journal:
      driver: local

Start all services with exposed data directories::

  $ docker-compose up

Plugins
=======

In order to add plugins you can build a new image based on the existing `graylog/graylog`_ Docker image with the needed plugin included or you add a volume that points to the locally downloaded plugin file.

New Docker image
----------------

Simply create a new `Dockerfile <https://docs.docker.com/engine/reference/builder/>`_ in an empty directory with the following contents::

  FROM graylog/graylog:2.3.0-1
  RUN wget -O /usr/share/graylog/plugin/graylog-plugin-auth-sso-2.3.0.jar https://github.com/Graylog2/graylog-plugin-auth-sso/releases/download/2.3.0/graylog-plugin-auth-sso-2.3.0.jar

Build a new image from the new ``Dockerfile`` (also see `docker build <https://docs.docker.com/engine/reference/commandline/build/>`_)::

  $ docker build -t graylog-with-sso-plugin .

In this example, we created a new image with the `SSO plugin <https://github.com/Graylog2/graylog-plugin-auth-sso>`_ installed. From now on reference to the newly built image instead of `graylog/graylog`_.

The ``docker-compose.yml`` file has to reference the new Docker image::

  version: '2'
  services:
    mongo:
      image: "mongo:3"
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:5.5.1
      # Other settings [...]
    graylog:
      image: graylog-with-sso-plugin
      # Other settings [...]

Volume-mounted plugin
---------------------

Instead of building a new docker image, you can also add additional plugins by mounting them directly and individually into the ``plugin`` folder of the original Docker image. This way, you don't have to create a new docker image every time you want to add a new plugin (or remove an old one).

Simply create a ``plugin`` folder, download the plugin(s) you want to install into it and mount each file as an additional volume into the docker container::

  $ mkdir -p ./graylog/plugin
  $ wget -O ./graylog/plugin/graylog-plugin-auth-sso-2.3.0.jar https://github.com/Graylog2/graylog-plugin-auth-sso/releases/download/2.3.0/graylog-plugin-auth-sso-2.3.0.jar

The ``docker-compose.yml`` file has to reference the new Docker image::

  version: '2'
  services:
    mongo:
      image: "mongo:3"
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch:5.5.1
      # Other settings [...]
    graylog:
      image: graylog/graylog:2.3.0-1
      # Other settings [...]
      volumes:
        # Mount local plugin file into Docker container
        - ./graylog/plugin/graylog-plugin-auth-sso-2.3.0.jar:/usr/share/graylog/plugin/graylog-plugin-auth-sso-2.3.0.jar
        
You can add as many of these links as you wish in your ``docker-compose.yml`` file. Simply restart the container and docker will recreate the graylog container with the new volumes included::

  $ docker-compose restart 

Troubleshooting
===============

* In case you see warnings regarding open file limit, try to set ulimit from the outside of the container::

  $ docker run --ulimit nofile=64000:64000 ...

* The ``devicemapper`` storage driver can produce problems with Graylogs disk journal on some systems.
  In this case please `pick another driver <https://docs.docker.com/engine/userguide/storagedriver/selectadriver>`__ like ``aufs`` or ``overlay``.


Testing a beta version
======================

.. caution:: We only recommend running pre-release versions if you are an experienced Graylog user and know what you are doing.

You can also run a pre-release (alpha, beta, or release candidate) version of Graylog using Docker.

The pre-releases are tagged in the `graylog/graylog`_ Docker image.

Follow the `documentation for the Graylog image on Docker Hub <https://hub.docker.com/r/graylog/graylog/>`__ and pick an alpha/beta/rc tag like this::

  $ docker run --link mongo --link elasticsearch -p 9000:9000 -p 12201:12201 -p 514:514 \
      -e GRAYLOG_WEB_ENDPOINT_URI="http://127.0.0.1:9000/api" \
      -d graylog/graylog:2.3.0-rc.2-3
