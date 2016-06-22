******
Docker
******

Requirements
------------

You need a recent `docker` version installed, take a look `here <https://docs.docker.com/installation/>`__ for instructions.

This will create three containers with all Graylog services running::

  $ docker run --name some-mongo -d mongo
  $ docker run --name some-elasticsearch -d elasticsearch elasticsearch -Des.cluster.name="graylog"
  $ docker run --link some-mongo:mongo --link some-elasticsearch:elasticsearch -d graylog2/server

Testing a beta version
----------------------

You can also run a pre-release or beta version of Graylog using Docker. The pre-releases are included in the `graylog2/server` image.
Follow this `guide <https://hub.docker.com/r/graylog2/server/>`_ and pick an alpha/beta/rc tag like::

  $ docker run --link some-mongo:mongo --link some-elasticsearch:elasticsearch -d graylog2/server:2.0.0-beta.1-1
 
We only recommend to run beta versions if you are an experienced Graylog user and know what you are doing.

Settings
--------

Graylog comes with a default configuration that works out of the box but you have to set a password for the admin user.
Also the web interface needs to know how to connect from your browser to the Graylog API. Both can be done via environment variables::

  -e GRAYLOG_PASSWORD_SECRET=somepasswordpepper
  -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
  -e GRAYLOG_REST_TRANSPORT_URI="http://127.0.0.1:12900"

In this case you can login to Graylog with the username and password `admin`.  Generate your own password with this command::

  $ echo -n yourpassword | shasum -a 256

This all can be put in a `docker-compose.yml` file, like::

  some-mongo:
    image: "mongo:3"
  some-elasticsearch:
    image: "elasticsearch:2"
    command: "elasticsearch -Des.cluster.name='graylog'"
  graylog:
    image: graylog2/server:2.0.0-1
    environment:
      GRAYLOG_PASSWORD_SECRET: somepasswordpepper
      GRAYLOG_ROOT_PASSWORD_SHA2: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
      GRAYLOG_REST_TRANSPORT_URI: http://127.0.0.1:12900
    links:
      - some-mongo:mongo
      - some-elasticsearch:elasticsearch
    ports:
      - "9000:9000"
      - "12900:12900"

After starting the three containers with `docker-compose up` open your browser with the URL `http://127.0.0.1:9000` and
login with `admin:admin`

How to get log data in
----------------------

You can create different kinds of inputs under *System -> Inputs*, however you can only use ports that have been properly
mapped to your docker container, otherwise data will not go through.

E.g. to start a raw TCP input on port 5555, stop your container and recreate it, whilst appending `-p 5555:5555` to your run argument.
Similarly, the same can be done for UDP by appending `-p 5555:5555/udp` option. Then you can send raw text to Graylog like
`echo 'first log message' | nc localhost 5555`

Persist log data
----------------

In order to make the log data and configuration of Graylog persistent, you can use external volumes to store all data. In case of a container restart simply re-use the existing data from the former instances.
Create the configuration directory and copy the default files::

  mkdir /graylog/config
  cd /graylog/config
  wget https://raw.githubusercontent.com/Graylog2/graylog2-images/2.0/docker/config/graylog.conf
  wget https://raw.githubusercontent.com/Graylog2/graylog2-images/2.0/docker/config/log4j2.xml

The `docker-compose.yml` file looks like this::

  some-mongo:
    image: "mongo:3"
    volumes:
      - /graylog/data/mongo:/data/db
  some-elasticsearch:
    image: "elasticsearch:2"
    command: "elasticsearch -Des.cluster.name='graylog'"
    volumes:
      - /graylog/data/elasticsearch:/usr/share/elasticsearch/data
  graylog:
    image: graylog2/server
    volumes:
      - /graylog/data/journal:/usr/share/graylog/data/journal
      - /graylog/config:/usr/share/graylog/data/config
    environment:
      GRAYLOG_PASSWORD_SECRET: somepasswordpepper
      GRAYLOG_ROOT_PASSWORD_SHA2: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
      GRAYLOG_REST_TRANSPORT_URI: http://127.0.0.1:12900
  
    links:
      - some-mongo:mongo
      - some-elasticsearch:elasticsearch
    ports:
      - "9000:9000"
      - "12900:12900"
      - "12201/udp:12201/udp"
      - "1514/udp:1514/udp"

Start all services with exposed data directories::

  $ docker-compose up
 
Configuration
-------------

Every configuration option can be set via environment variables, take a look `here <https://github.com/Graylog2/graylog2-server/blob/master/misc/graylog.conf>`__ for an overview.
Simply prefix the parameter name with `GRAYLOG_` and put it all in upper case.
Another option would be to store the configuration file outside of the container and edit it directly.

Plugins
-------

In order to add plugins you can build a new image based on the existsing `graylog2/server` image with the needed plugin included. Simply
create a new Dockerfile in an empty directory::

  FROM graylog2/server:2.0.3-2
  RUN wget -O /usr/share/graylog/plugin/graylog-plugin-beats-1.0.3.jar https://github.com/Graylog2/graylog-plugin-beats/releases/download/1.0.3/graylog-plugin-beats-1.0.3.jar

Build a new image from that::

  $ docker build -t graylog-with-beats-plugin .

In this example we created a new image with the Beats plugin installed. From now on reference to that image instead of the `graylog2/server` e.g. in a `docker-compose.yml` file::

  some-mongo:
    image: "mongo:3"
    volumes:
      - /graylog/data/mongo:/data/db
  some-elasticsearch:
    image: "elasticsearch:2"
    command: "elasticsearch -Des.cluster.name='graylog'"
    volumes:
      - /graylog/data/elasticsearch:/usr/share/elasticsearch/data
  graylog:
    image: graylog-with-beats-plugin
  ...

Problems
--------

* In case you see warnings regarding open file limit, try to set ulimit from the outside of the container::

  $ docker run --ulimit nofile=64000:64000 ...

* The `devicemapper` storage driver can produce problems with Graylogs disk journal on some systems.
  In this case please pick another driver like `aufs` or `overlay`. Have a look `here <https://docs.docker.com/engine/userguide/storagedriver/selectadriver>`__

Build
-----

To build the image from scratch run::

  $ docker build --build-arg GRAYLOG_VERSION=${GRAYLOG_VERSION} -t graylog2/server .

Production readiness
====================

You can use the Graylog appliances (OVA, Docker, AWS, ...) for small production setups but please consider to harden the security of the box before.

 * Set another password for the default ubuntu user
 * Disable remote password logins in /etc/ssh/sshd_config and deploy proper ssh keys
 * Seperate the box network-wise from the outside, otherwise Elasticsearch can be reached by anyone

If you want to create your own customised setup take a look at our :ref:`other installation methods <installing>`.
