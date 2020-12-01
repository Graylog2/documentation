elasticsearch-oss:7.10.0.. _here:

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

If you want to checkout Graylog on your local desktop without any further customization, you can run the following three commands to create the necessary environment::

  $ docker run --name mongo -d mongo:4.2
  $ docker run --name elasticsearch \
      -e "http.host=0.0.0.0" \
      -e "discovery.type=single-node" \
      -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
      -d docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
  $ docker run --name graylog --link mongo --link elasticsearch \
      -p 9000:9000 -p 12201:12201 -p 1514:1514 \
      -e GRAYLOG_HTTP_EXTERNAL_URI="http://127.0.0.1:9000/" \
      -d graylog/graylog:4.0.1


.. warning:: All configuration examples are created to run on the local computer. Should those be used on external servers, adjust ``GRAYLOG_HTTP_EXTERNAL_URI`` and add ``GRAYLOG_HTTP_PUBLISH_URI`` and ``GRAYLOG_HTTP_EXTERNAL_URI`` according to the :ref:`server.conf documentation <web_rest_api_options>`.


How to get log data in
----------------------

You can create different kinds of inputs under *System / Inputs*, however you can only use ports that have been properly mapped to your Docker container, otherwise data will not show up in the Graylog UI.

For example, to start a Graylog Docker container listening on port 5555, stop your container and recreate it, while appending ``-p 5555:5555`` to your `docker run <https://docs.docker.com/engine/reference/run/>`_ command::

  $ docker run --link mongo --link elasticsearch \
      -p 9000:9000 -p 12201:12201 -p 1514:1514 -p 5555:5555 \
      -e GRAYLOG_HTTP_EXTERNAL_URI="http://127.0.0.1:9000/" \
      -d graylog/graylog:4.0


Similarly, the same can be done for UDP by appending ``-p 5555:5555/udp``.

After ensuring that your Graylog Docker container is listening on ``:5555``, create a Raw/Plaintext Input by navigating to `http://localhost:9000/system/inputs <http://localhost:9000/system/inputs>`_ :

.. image:: /images/docker-01.png

|

.. image:: /images/docker-02.png

Once on the Inputs page, search for ```Raw/Plaintext TCP`` and click ``Launch new input``

.. image:: /images/docker-03.png

|

.. image:: /images/docker-04.png

After launching the input, you'll see a dialog box pop up with several options. You can leave most these options as their defaults, but note that you'll need to provide a name for the input, as well as select the node, or "Global" for the location for the input.

.. image:: /images/docker-05.png

After that you can send a plaintext message to the Graylog Raw/Plaintext TCP input running on port 5555 using the following command::

  $ echo 'First log message' | nc localhost 5555

Which you can then view in the Graylog UI:

.. image:: /images/docker-06.png

Settings
--------

Graylog comes with a default configuration that works out of the box but you have to set a password for the admin user and the web interface needs to know how to connect from your browser to the Graylog REST API.

Both settings can be configured via environment variables (also see :ref:`configuration`)::

  -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
  -e GRAYLOG_HTTP_EXTERNAL_URI="http://127.0.0.1:9000/"

In this case you can login to Graylog with the username and password ``admin``.

Generate your own admin password with the following command and put the SHA-256 hash into the ``GRAYLOG_ROOT_PASSWORD_SHA2`` environment variable::

  echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1


All these settings and command line parameters can be put in a ``docker-compose.yml`` file, so that they don't have to be executed one after the other.

.. warning:: The following example does not persist any data and configurations. You should read the section :ref:`persisting-data` to add persistance to your docker-compose file.

Example Version 2::

  version: '2'
  services:
    # MongoDB: https://hub.docker.com/_/mongo/
    mongodb:
      image: mongo:4.2
    # Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/6.x/docker.html
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      environment:
        - http.host=0.0.0.0
        - transport.host=localhost
        - network.host=0.0.0.0
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      ulimits:
        memlock:
          soft: -1
          hard: -1
      mem_limit: 1g
    # Graylog: https://hub.docker.com/r/graylog/graylog/
    graylog:
      image: graylog/graylog:4.0
      environment:
        # CHANGE ME (must be at least 16 characters)!
        - GRAYLOG_PASSWORD_SECRET=somepasswordpepper
        # Password: admin
        - GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
        - GRAYLOG_HTTP_EXTERNAL_URI=http://127.0.0.1:9000/
      links:
        - mongodb:mongo
        - elasticsearch
      restart: always
      depends_on:
        - mongodb
        - elasticsearch
      ports:
        # Graylog web interface and REST API
        - 9000:9000
        # Syslog TCP
        - 1514:1514
        # Syslog UDP
        - 1514:1514/udp
        # GELF TCP
        - 12201:12201
        # GELF UDP
        - 12201:12201/udp

Example Version 3::

  version: '3'
  services:
    # MongoDB: https://hub.docker.com/_/mongo/
    mongo:
      image: mongo:4.2
      networks:
        - graylog
    # Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/6.x/docker.html
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      environment:
        - http.host=0.0.0.0
        - transport.host=localhost
        - network.host=0.0.0.0
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      ulimits:
        memlock:
          soft: -1
          hard: -1
      deploy:
        resources:
          limits:
            memory: 1g
      networks:
        - graylog
    # Graylog: https://hub.docker.com/r/graylog/graylog/
    graylog:
      image: graylog/graylog:4.0
      environment:
        # CHANGE ME (must be at least 16 characters)!
        - GRAYLOG_PASSWORD_SECRET=somepasswordpepper
        # Password: admin
        - GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
        - GRAYLOG_HTTP_EXTERNAL_URI=http://127.0.0.1:9000/
      networks:
        - graylog
      restart: always
      depends_on:
        - mongo
        - elasticsearch
      ports:
        # Graylog web interface and REST API
        - 9000:9000
        # Syslog TCP
        - 1514:1514
        # Syslog UDP
        - 1514:1514/udp
        # GELF TCP
        - 12201:12201
        # GELF UDP
        - 12201:12201/udp
  networks:
    graylog:
      driver: bridge

After starting all three Docker containers by running ``docker-compose up``, you can open the URL ``http://127.0.0.1:9000`` in a web browser and log in with username ``admin`` and password ``admin`` (make sure to change the password later). Change ``GRAYLOG_HTTP_EXTERNAL_URI=`` to your server IP if you run Docker remotely.


.. _configuration:

Configuration
=============

Every configuration option can be set via `environment variables <https://github.com/Graylog2/graylog2-server/blob/3.3/misc/graylog.conf>`__.
Simply prefix the parameter name with ``GRAYLOG_`` and put it all in upper case.

For example, setting up the SMTP configuration for sending Graylog alert notifications via email, the ``docker-compose.yml`` would look like this::

  version: '2'
  services:
    mongo:
      image: "mongo:4.2"
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      # Other settings [...]
    graylog:
      image: graylog/graylog:4.0
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
  $ wget https://raw.githubusercontent.com/Graylog2/graylog-docker/4.0/config/graylog.conf
  $ wget https://raw.githubusercontent.com/Graylog2/graylog-docker/4.0/config/log4j2.xml

The newly created directory ``./graylog/config/`` with the custom configuration files now has to be mounted into the Graylog Docker container.

This can be done by adding an entry to the `volumes <https://docs.docker.com/compose/compose-file/#volume-configuration-reference>`__ section of the ``docker-compose.yml`` file::

  version: '2'
  services:
    mongodb:
      image: mongo:4.2
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      # Other settings [...]
    graylog:
      image: graylog/graylog:4.0
      # Other settings [...]
      volumes:
        # Mount local configuration directory into Docker container
        - ./graylog/config:/usr/share/graylog/data/config

.. warning:: Graylog is running as USER graylog with the ID ``1100`` in Docker. That ID need to be able to read the configuration files you place into the container.


Reading individual configuration settings from files
----------------------------------------------------

The Graylog Docker image supports reading individual configuration settings from a file. This can be used to secure configuration settings with `Docker secrets <https://docs.docker.com/engine/swarm/secrets/>`__ or similar mechanisms.

This has the advantage, that configuration settings containing sensitive information don't have to be added to a custom configuration file or into an environment variable in plaintext.

The Graylog Docker image checks for the existence of environment variables with the naming scheme ``GRAYLOG_<CONFIG_NAME>__FILE`` on startup and expects the environment variable to contain the absolute path to a readable file.

For example, if the environment variable ``GRAYLOG_ROOT_PASSWORD_SHA2__FILE`` contained the value ``/run/secrets/root_password_hash``, the Graylog Docker image would use the contents of ``/run/secrets/root_password_hash`` as value for the ``root_password_sha2`` configuration setting.

Docker secrets
^^^^^^^^^^^^^^

.. note:: Docker secrets are only available in Docker Swarm services starting with Docker 1.13. Please refer to `Manage sensitive data with Docker secrets <https://docs.docker.com/engine/swarm/secrets/>`__  for more details.

Example for using Docker secrets in a Docker Swarm service::

    # Create SHA-256 hash of our password
    $ echo -n 'password' | sha256sum | awk '{ print $1 }'
    5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8

    # Create a Docker secret named "root_password_hash"
    $ printf '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8' | \
      docker secret create root_password_hash -
    nlujwooo5uu6z0m91bmve79uo

    $ docker secret ls
    ID                          NAME                 DRIVER              CREATED             UPDATED
    nlujwooo5uu6z0m91bmve79uo   root_password_hash                       34 seconds ago      34 seconds ago

    # Create Docker Swarm service named "graylog" with access
    # to the secret named "root_password_hash"
    $ docker service create --name graylog \
     --secret root_password_hash \
     -e GRAYLOG_ROOT_PASSWORD_SHA2__FILE=/run/secrets/root_password_hash \
     -p 9000:9000 graylog/graylog:4.0
    mclk5gm39ingk51s869dc0htz
    overall progress: 1 out of 1 tasks
    1/1: running   [==================================================>]
    verify: Service converged

    $ docker service ls
    ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
    mclk5gm39ing        graylog             replicated          1/1                 graylog:4.0      *:9000->9000/tcp


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
      image: mongo:4.2
      volumes:
        - mongo_data:/data/db
    # Elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/6.x/docker.html
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      volumes:
        - es_data:/usr/share/elasticsearch/data
      environment:
        - http.host=0.0.0.0
        - transport.host=localhost
        - network.host=0.0.0.0
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      ulimits:
        memlock:
          soft: -1
          hard: -1
      mem_limit: 1g
    # Graylog: https://hub.docker.com/r/graylog/graylog/
    graylog:
      image: graylog/graylog:4.0
      volumes:
        - graylog_data:/usr/share/graylog/data
      environment:
        # CHANGE ME (must be at least 16 characters)!
        - GRAYLOG_PASSWORD_SECRET=somepasswordpepper
        # Password: admin
        - GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
        - GRAYLOG_HTTP_EXTERNAL_URI=http://127.0.0.1:9000/
      links:
        - mongodb:mongo
        - elasticsearch
      restart: always
      depends_on:
        - mongodb
        - elasticsearch
      ports:
        # Graylog web interface and REST API
        - 9000:9000
        # Syslog TCP
        - 1514:1514
        # Syslog UDP
        - 1514:1514/udp
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
    graylog_data:
      driver: local

Start all services with exposed data directories::

  $ docker-compose up

Plugins
=======

In order to add plugins you can build a new image based on the existing `graylog/graylog`_ Docker image with the needed plugin included or you add a volume that points to the locally downloaded plugin file.

New Docker image
----------------

Simply create a new `Dockerfile <https://docs.docker.com/engine/reference/builder/>`_ in an empty directory with the following contents::

  FROM graylog/graylog:4.0
  RUN wget -O /usr/share/graylog/plugin/graylog-plugin-auth-sso-3.3.0.jar https://github.com/Graylog2/graylog-plugin-auth-sso/releases/download/3.3.0/graylog-plugin-auth-sso-3.3.0.jar

Build a new image from the new ``Dockerfile`` (also see `docker build <https://docs.docker.com/engine/reference/commandline/build/>`_)::

  $ docker build -t graylog-with-sso-plugin .

In this example, we created a new image with the `SSO plugin <https://github.com/Graylog2/graylog-plugin-auth-sso>`_ installed. From now on reference to the newly built image instead of `graylog/graylog`_.

The ``docker-compose.yml`` file has to reference the new Docker image::

  version: '2'
  services:
    mongo:
      image: "mongo:4.2"
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      # Other settings [...]
    graylog:
      image: graylog-with-sso-plugin
      # Other settings [...]

Volume-mounted plugin
---------------------

Instead of building a new docker image, you can also add additional plugins by mounting them directly and individually into the ``plugin`` folder of the original Docker image. This way, you don't have to create a new docker image every time you want to add a new plugin (or remove an old one).

Simply create a ``plugin`` folder, download the plugin(s) you want to install into it and mount each file as an additional volume into the docker container::

  $ mkdir -p ./graylog/plugin
  $ wget -O ./graylog/plugin/graylog-plugin-auth-sso-3.3.0.jar https://github.com/Graylog2/graylog-plugin-auth-sso/releases/download/3.3.0/graylog-plugin-auth-sso-3.3.0.jar

The ``docker-compose.yml`` file has to reference the new Docker image::

  version: '2'
  services:
    mongo:
      image: "mongo:3"
      # Other settings [...]
    elasticsearch:
      image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.0
      # Other settings [...]
    graylog:
      image: graylog/graylog:4.0
      # Other settings [...]
      volumes:
        # Mount local plugin file into Docker container
        - ./graylog/plugin/graylog-plugin-auth-sso-3.3.0.jar:/usr/share/graylog/plugin/graylog-plugin-auth-sso-3.3.0.jar

You can add as many of these links as you wish in your ``docker-compose.yml`` file. Simply restart the container and docker will recreate the graylog container with the new volumes included::

  $ docker-compose restart


Kubernetes automatic master selection
=====================================

Running Graylog in Kubernetes opens the challenge to set the ``is_master=true`` setting only for one node in the cluster. The problem can be solved by calculating the name of the pod if Graylog is running in a stafeful set with the following environment variable::

      env:
      - name: POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name


For a stateful set, the name of the first pod in a cluster always ends with ``-0``. See the `Documentation about stateful set <https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-identity>`__ . The master selection mechanism in docker-entrypoint.sh file does the following:


* Examine if Graylog is running inside Kubernetes
* Verify that the pod name ends in ``-0``
* Set ``is_master=true`` for this container

Nomad automatic master selection
================================

When running Graylog in a Nomad cluster, you must ensure that only one node in the cluster has the setting ``is_master=true`` in the server.conf file.

Whether the container is running on Nomad may be identified with an environmetal check on NOMAD_ALLOC_INDEX. Should that variable be set to 0, the container will set Graylog to ``is_master=true``. If the variable is set to anything other than 0 , it will set Graylog to ``is_master=false``.


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


See the `available tags for the Graylog image on Docker Hub <https://hub.docker.com/r/graylog/graylog/tags/>`__ and pick an alpha/beta/rc tag like this::

  $ docker run --link mongo --link elasticsearch -p 9000:9000 -p 12201:12201 -p 1514:1514 \
      -e GRAYLOG_HTTP_BIND_ADDRESS="127.0.0.1:9000" \
      -d graylog/graylog:4.0.0-rc.1-2
