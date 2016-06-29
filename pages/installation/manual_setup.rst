************
Manual Setup
************

Graylog server on Linux
=======================

Prerequisites
^^^^^^^^^^^^^

You will need to have the following services installed on either the host you are running ``graylog-server`` on or on dedicated machines:

* `Elasticsearch 2.1.x or later <https://www.elastic.co/downloads/elasticsearch>`_
* `MongoDB 2.0 or later <https://docs.mongodb.org/manual/administration/install-on-linux/>`_ (latest stable version is recommended)
* Oracle Java SE 8 or later (Oracle Java SE 7 is end of life and is no longer supported. OpenJDK 8 also works; latest stable update is recommended)

Most standard MongoDB packages of Linux distributions are outdated. Use the `official MongoDB APT repository <http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/>`_
(available for many distributions and operating systems)

You also **must** install **Java 8** or higher! Java 7 is not compatible with Graylog and will also not receive any more publicly available bug and security
fixes by Oracle.

A more detailed guide for installing the dependencies will follow. **The only important thing for Elasticsearch is that you set
the exactly same cluster name (e. g. ``cluster.name: graylog``) that is being used by Graylog in the Elasticsearch configuration (``conf/elasticsearch.yml``)**.

Downloading and extracting the server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Download the tar archive from the `download pages <https://www.graylog.org/download/>`_ and extract it on your system::

  ~$ tar xvfz graylog-VERSION.tgz
  ~$ cd graylog-VERSION

Configuration
^^^^^^^^^^^^^

Now copy the example configuration file::

  ~# cp graylog.conf.example /etc/graylog/server/server.conf

You can leave most variables as they are for a first start. All of them should be well documented.

Configure at least the following variables in ``/etc/graylog/server/server.conf``:

 * ``is_master = true``
    * Set only one ``graylog-server`` node as the master. This node will perform periodical and maintenance actions that slave nodes won't.
      Every slave node will accept messages just as the master nodes. Nodes will fall back to slave mode if there already is a master in the
      cluster.
 * ``password_secret``
    * You must set a secret that is used for password encryption and salting here. The server will refuse to start if it's not set. Generate
      a secret with for example ``pwgen -N 1 -s 96``.  If you run multiple ``graylog-server`` nodes, make sure you use the same
      ``password_secret`` for all of them!
 * ``root_password_sha2``
    * A SHA2 hash of a password you will use for your initial login. Set this to a SHA2 hash generated with ``echo -n yourpassword | shasum -a 256``
      and you will be able to log in to the web interface with username *admin* and password *yourpassword*.
 * ``elasticsearch_max_docs_per_index = 20000000``
    * How many log messages to keep per index. This setting multiplied with ``elasticsearch_max_number_of_indices`` results in the maximum number of
      messages in your Graylog setup. It is always better to have several more smaller indices than just a few larger ones.
 * ``elasticsearch_max_number_of_indices = 20``
    * How many indices to have in total. If this number is reached, the oldest index will be deleted. **Also take a look at the other retention
      strategies that allow you to automatically delete messages based on their age.**
 * ``elasticsearch_shards = 4``
    * The number of shards for your indices. A good setting here highly depends on the number of nodes in your Elasticsearch cluster. If you have
      one node, set it to ``1``.
 * ``elasticsearch_replicas = 0``
     * The number of replicas for your indices. A good setting here highly depends on the number of nodes in your Elasticsearch cluster. If you
       have one node, set it to ``0``.
 * ``mongodb_uri``
    * Enter your MongoDB connection and authentication information here.

Starting the server
^^^^^^^^^^^^^^^^^^^

You need to have Java installed. Running the OpenJDK is totally fine and should be available on all platforms. For example on Debian it is::

  ~$ apt-get install openjdk-8-jre

**You need at least Java 8** as Java 7 has reached EOL.

Start the server::

  ~$ cd bin/
  ~$ ./graylogctl start

The server will try to write a ``node_id`` to the ``graylog-server-node-id`` file. It won't start if it can't write there because of for
example missing permissions.

See the startup parameters description below to learn more about available startup parameters. Note that you might have to be `root`
to bind to the popular port 514 for syslog inputs.

You should see a line like this in the debug output of ``graylog-server`` successfully connected to your Elasticsearch cluster::

  2013-10-01 12:13:22,382 DEBUG: org.elasticsearch.transport.netty - [graylog-server] connected to node [[Unuscione, Angelo][thN_gIBkQDm2ab7k-2Zaaw][inet[/10.37.160.227:9300]]]

You can find the ``graylog-server`` logs in the directory ``logs/``.

**Important:** All ``graylog-server`` instances must have synchronised time. We strongly recommend to use
`NTP <http://en.wikipedia.org/wiki/Network_Time_Protocol>`_ or similar mechanisms on all machines of your Graylog infrastructure.

Supplying external logging configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Graylog is using `Apache Log4j 2 <https://logging.apache.org/log4j/2.x/>`_ for its internal logging and ships with a
`default log configuration file <https://github.com/Graylog2/graylog2-server/blob/2.0/graylog2-server/src/main/resources/log4j2.xml>`_
which is embedded within the shipped JAR.

In case you need to modify Graylog's logging configuration, you can supply a Java system property specifying the path to
the configuration file in your start script (e. g. ``graylogctl``).

Append this before the ``-jar`` paramter::

  -Dlog4j.configurationFile=file:///path/to/log4j2.xml

Substitute the actual path to the file for the ``/path/to/log4j2.xml`` in the example.

In case you do not have a log rotation system already in place, you can also configure Graylog to rotate logs based on their size to prevent the
log files to grow without bounds using the `RollingFileAppender <https://logging.apache.org/log4j/2.x/manual/appenders.html#RollingFileAppender>`_.

One such example ``log4j2.xml`` configuration is shown below::

  <?xml version="1.0" encoding="UTF-8"?>
  <Configuration packages="org.graylog2.log4j" shutdownHook="disable">
    <Appenders>
        <RollingFile name="RollingFile" fileName="/tmp/logs/graylog.log"
                     filePattern="/tmp/logs/graylog-%d{yyyy-MM-dd}.log.gz">
          <PatternLayout>
            <Pattern>%d %-5p: %c - %m%n</Pattern>
          </PatternLayout>
          <!-- Rotate logs every day or when the size exceeds 10 MB (whichever comes first) -->
          <Policies>
            <TimeBasedTriggeringPolicy modulate="true"/>
            <SizeBasedTriggeringPolicy size="10 MB"/>
          </Policies>
          <!-- Keep a maximum of 10 log files -->
          <DefaultRolloverStrategy max="10"/>
        </RollingFile>

        <Console name="STDOUT" target="SYSTEM_OUT">
            <PatternLayout pattern="%d %-5p: %c - %m%n"/>
        </Console>

        <!-- Internal Graylog log appender. Please do not disable. This makes internal log messages available via REST calls. -->
        <Memory name="graylog-internal-logs" bufferSize="500"/>
    </Appenders>
    <Loggers>
        <Logger name="org.graylog2" level="info"/>
        <Logger name="com.github.joschi.jadconfig" level="warn"/>
        <Logger name="org.apache.directory.api.ldap.model.message.BindRequestImpl" level="error"/>
        <Logger name="org.elasticsearch.script" level="warn"/>
        <Logger name="org.graylog2.periodical.VersionCheckThread" level="off"/>
        <Logger name="org.drools.compiler.kie.builder.impl.KieRepositoryImpl" level="warn"/>
        <Logger name="com.joestelmach.natty.Parser" level="warn"/>
        <Logger name="kafka.log.Log" level="warn"/>
        <Logger name="kafka.log.OffsetIndex" level="warn"/>
        <Logger name="org.apache.shiro.session.mgt.AbstractValidatingSessionManager" level="warn"/>
        <Root level="warn">
            <AppenderRef ref="STDOUT"/>
            <AppenderRef ref="RollingFile"/>
            <AppenderRef ref="graylog-internal-logs"/>
        </Root>
    </Loggers>
  </Configuration>

Command line (CLI) parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are a number of CLI parameters you can pass to the call in your ``graylogctl`` script:

* ``-h``, ``--help``: Show help message
* ``-f CONFIGFILE``, ``--configfile CONFIGFILE``: Use configuration file `CONFIGFILE` for Graylog; default: ``/etc/graylog/server/server.conf``
* ``-d``, ``--debug``: Run in debug mode
* ``-l``, ``--local``: Run in local mode. Automatically invoked if in debug mode. Will not send system statistics, even if enabled and allowed. Only interesting for development and testing purposes.
* ``-p PIDFILE``, ``--pidfile PIDFILE``: Set the file containing the PID of graylog to `PIDFILE`; default: `/tmp/graylog.pid`
* ``-np``, ``--no-pid-file``: Do not write PID file (overrides `-p`/`--pidfile`)
* ``--version``: Show version of Graylog and exit

Problems with IPv6 vs. IPv4?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your `graylog-server` instance refuses to listen on IPv4 addresses and always chooses for example a `rest_listen_address` like `:::12900`
you can tell the JVM to prefer the IPv4 stack.

Add the `java.net.preferIPv4Stack` flag in your `graylogctl` script or from wherever you are calling the `graylog.jar`::

    ~$ sudo -u graylog java -Djava.net.preferIPv4Stack=true -jar graylog.jar

Create a message input and send a first message
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Log in to the web interface on port 9000 (e.g. ``http://127.0.0.1:9000``) and navigate to *System* -> *Nodes*. Select your ``graylog-server`` node there and click on *Manage inputs*.

.. image:: /images/create_input.png

Launch a new *Raw/Plaintext UDP* input, listening on port ``9099`` and listening on ``127.0.0.1``. No need to configure anything else for now.
The list of running inputs on that node should show you your new input right away. Let's send a message in::

  echo "Hello Graylog, let's be friends." | nc -w 1 -u 127.0.0.1 9099

This has sent a short string to the raw UDP input you just opened. Now search for *friends* using the searchbar on the top and you should already
see the message you just sent in. Click on it in the table and see it in detail:

.. image:: /images/setup_1.png

You have just sent your first message to Graylog! Why not spawn a syslog input and point some of your servers to it? You could also create some user
accounts for your colleagues.

HTTPS
^^^^^

Enabling HTTPS is easy. Just start the web interface TLS support in the ``/etc/graylog/server/server.conf`` like this::

  web_enable_tls=true

This will generate self-signed certificate. To use proper certificates you must provide a PEM-encoded private key in PKCS#8 format and a X.509 certificate.
Most certificate authorities provide instructions on how to create such keys and certificates.

The OpenSSL documentation also provides `examples on how to handle PKCS#8 files <https://www.openssl.org/docs/manmaster/apps/pkcs8.html#EXAMPLES>`_.

* ``web_tls_cert_file`` The X.509 certificate file (PEM-encoded) to use for securing the web interface port.
* ``web_tls_key_file`` The private key in PKCS#8 format (PEM-encoded) to use for securing the web interface port.
* ``web_tls_key_password`` The password, defaults to a blank password
