******************
Installing Graylog
******************

Modern server architectures and configurations are managed in many different ways. Some people still put new software
somewhere in ``opt`` manually for each server while others have already jumped on the configuration management train and
fully automated reproducible setups.

Graylog can be installed in many different ways so you can pick whatever works best for you. We recommend to start with the
`Virtual machine appliances`_ or the `Quick setup application`_ for the fastest way to get started and then pick one
of the other, more flexible installation methods to build a production ready setup. (Note: The `Virtual machine appliances`_
are suitable for production usage because they are prepared to scale out to multiple servers when required.)

This chapter is explaining the many ways to install Graylog and aims to help choosing the one that fits your needs.

Virtual machine appliances
==========================

The easiest way to get started with a production ready Graylog setup is using our official virtual machine appliances. We offer
those for the following platforms:

* `OVA for VMware / Virtualbox <https://www.graylog.org/links/images-ova/>`_
* `OpenStack <https://www.graylog.org/links/images-openstack/>`_
* `Amazon Web Services / EC2 <https://www.graylog.org/links/images-aws/>`_
* `Docker <https://www.graylog.org/links/images-docker/>`_

Please follow the links for specific instructions and downloads. The next chapters explain general principles of the appliances:

Configuring the appliances
--------------------------

The great thing about the new appliances is the ``graylog-ctl`` tool that we are shipping with them. We want you to get started
with a customised setup as soon as quickly as possible so you can now do things like::

  graylog-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  graylog-ctl set-admin-password <password>
  graylog-ctl set-timezone <zone acronym>
  graylog-ctl reconfigure

Assign a static IP
------------------

Per default the appliance make use of DHCP to setup the network. If you want to access Graylog under a static IP please
edit the file `/etc/network/interfaces` like this (just the important lines)::

  auto eth0
    iface eth0 inet static
    address <static IP address>
    netmask <netmask>
    gateway <default gateway>
    pre-up sleep 2

Activate the new IP and reconfigure Graylog to make use of it::

  $ sudo ifdown eth0 && sudo ifup eth0
  $ sudo graylog-ctl reconfigure

Wait some time till all services are restarted and running again. Afterwards you should be able to access Graylog with the new IP.

Scaling out
-----------

We are also providing an easy way to automatically scale out to more boxes once you grew out of your initial setup. Every appliance
is always shipping with all required Graylog components and you can at any time decide which role a specific box should take::

  graylog-ctl reconfigure-as-server
  graylog-ctl reconfigure-as-webinterface
  graylog-ctl reconfigure-as-datanode

Quick setup application
=======================

The quick setup application is a Java program that will install Graylog for you and take care of most configuration automatically.
It starts a little web server on the machine that you want to install Graylog on. You connect to it using your browser and will
be presented with an interactive wizard that asks you for some simple configuration variables. During the wizard the connections
between required components are tested to guarantee that the single steps succeeded. It usually takes no longer than five minutes
from starting the quick setup application to signing into your new Graylog setup.

It is important to remember that the quick setup app is **not** meant to create production ready setups. We strongly recommend to
use one of the other installation methods for a Graylog setup that is intended to run in production.

.. image:: /images/qsa1.png

Using the quick setup application
---------------------------------

All you need is a Linux machine with Java installed. The executable comes with a built-in web server that you point your browser to.
All the rest of the process is controlled from your browser.

Download and start the quick setup application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Start by `downloading <https://packages.graylog2.org/releases/graylog2-setup/graylog-setup-1.0.0.tar.gz>`_ the quick setup app.
Now extract the archive in any location you like. All parts of the Graylog system will be extracted in subdirectories.

Next step is to run the app and opening the URL you are seeing in your browser::

  $ wget https://packages.graylog2.org/releases/graylog2-setup/graylog-setup-<LATEST-VERSION>.tar.gz
  $ tar -xzf graylog-setup-<LATEST-VERSION>.tar.gz
  $ cd graylog-setup && ./bin/graylog setup
  Unpacking dependencies, please wait.
  Unpacking complete.
  Please open http://127.0.0.1:10000/ in your browser to get started.

Installing and connecting MongoDB
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should now see the quick setup app in your browser. The first thing to do is installing MongoDB. This is not done automatically
because it can be very dependent on your local architecture. The quick setup app will point you to the MongoDB downloads and the
setup usually takes less than a few minutes on most systems.

The quick setup app asks you for connection details to your MongoDB instance. We recommend to run it on the same box and just connecting
to `127.0.0.1`.

Creating a Graylog user account
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the next step you will be asked to create your first Graylog user account. This account will get administrator rights and allows you
to further configure the system later on. **Remember the username and password because you will need it for logging in to your
new Graylog system later.**

Finish setup
^^^^^^^^^^^^

Now finish the setup by clicking on *Install Graylog*. You will only be able to click the button if you have successfully completed all
required steps before.

The quick setup app will start all required services and write some configuration files. This can take some time so please be patient
with the progress bar.

Usually the progress bar will turn all green after completion and you will be redirected to the final summary page. You are now running
Graylog!

Check the output of the quick setup app process in your shell to find out how to start Graylog after shutting down the quick setup app::


  Starting elasticsearch with the following command:
      [...]
  Starting graylog server with the following command:
      [...]
  Starting graylog web interface with the following command:
      [...]

  Terminating this process will stop Graylog as well. To run the processes manually, please refer to the output above.

  Happy logging!

Using your new Graylog system
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The quick setup app should have given you a link to your new Graylog setup. Log in with the username and password you defined before.

**Congratulations!** You are now running Graylog. Please note that we do not recommend to run a system installed by the quick setup
app in production. Reason is that you are probably not familiar enough with the system and that you may have to tune some parameters to
be able to handle huge loads of log messages.

.. image:: /images/qsa2.png


The manual setup
================

We recommend to only run this if you have good reasons not to use one of the other production ready installation methods described
in this chapter.

Manual setup: graylog-server on Linux
-------------------------------------

Prerequisites
^^^^^^^^^^^^^

You will need to have the following services installed on either the host you are running ``graylog-server`` on or on dedicated machines:

* [Elasticsearch 1.3.4 or higher](http://www.elasticsearch.org/downloads)
* MongoDB (as recent stable version as possible, **at least v2.0**)

Most standard MongoDB packages of Linux distributions are outdated. Use the `official MongoDB APT repository <http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/>`_
(available for many distributions and operating systems)

You also **must** install **Java 7** or higher! Java 6 is not compatible with Graylog and will also not receive any more publicly available bug and security
fixes by Oracle.

A more detailed guide for installing the dependencies will follow. **The only important thing for Elasticsearch is that you configure
``cluster.name: graylog`` in its ``conf/elasticsearch.yml``**.

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
      one node, set it to ``1``. Read more about this in the knowledge base article about :doc:`configuring_es`.
 * ``elasticsearch_replicas = 0``
     * The number of replicas for your indices. A good setting here highly depends on the number of nodes in your Elasticsearch cluster. If you
       have one node, set it to ``0``. Read more about this in the knowledge base article about :doc:`configuring_es`.
 * ``mongodb_*``
    * Enter your MongoDB connection and authentication information here. Make sure that you connect the web interface to the same database.
      You don't need to configure ``mongodb_user`` and ``mongodb_password`` if ``mongodb_useauth`` is set to ``false``.

Starting the server
^^^^^^^^^^^^^^^^^^^

You need to have Java installed. Running the OpenJDK is totally fine and should be available on all platforms. For example on Debian it is::

  ~$ apt-get install openjdk-7-jre

**You need at least Java 7** as Java 6 has reached EOL.

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

The ``graylog-server`` uses Log4j for its internal logging and ships with a
`default log configuration file <https://github.com/Graylog2/graylog2-server/blob/1.0.0/graylog2-server/src/main/resources/log4j.xml>`
which is embedded within the shipped JAR.

In case you need to overwrite the configuration ``graylog-server`` uses, you can supply a Java system property specifying the path to
the configuration file in your ``graylogctl`` script. Append this before the `-jar` paramter::

  -Dlog4j.configuration=file:///tmp/logj4.xml

Substitute the actual path to the file for the ``/tmp/log4j.xml`` in the example.

In case you do not have a log rotation system already in place, you can also configure Graylog to rotate logs based on their size to prevent its
logs to grow without bounds.

One such example ``log4j.xml`` configuration is shown below. Graylog includes the ``log4j-extras`` companion classes to support time based and size
based log rotation. This is the example::

  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN" "log4j.dtd">
  <log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">

      <appender name="FILE" class="org.apache.log4j.rolling.RollingFileAppender">
          <rollingPolicy class="org.apache.log4j.rolling.FixedWindowRollingPolicy" >
              <param name="activeFileName" value="/tmp/server.log" /> <!-- ADAPT -->
              <param name="fileNamePattern" value="/tmp/server.%i.log" /> <!-- ADAPT -->
              <param name="minIndex" value="1" /> <!-- ADAPT -->
              <param name="maxIndex" value="10" /> <!-- ADAPT -->
          </rollingPolicy>
          <triggeringPolicy class="org.apache.log4j.rolling.SizeBasedTriggeringPolicy">
              <param name="maxFileSize" value="5767168" /> <!-- ADAPT: For example 5.5MB in bytes -->
          </triggeringPolicy>
          <layout class="org.apache.log4j.PatternLayout">
              <param name="ConversionPattern" value="%d %-5p: %c - %m%n"/>
          </layout>
      </appender>

      <!-- Application Loggers -->
      <logger name="org.graylog2">
          <level value="info"/>
      </logger>
      <!-- this emits a harmless warning for ActiveDirectory every time which we can't work around :( -->
      <logger name="org.apache.directory.api.ldap.model.message.BindRequestImpl">
          <level value="error"/>
      </logger>
      <!-- Root Logger -->
      <root>
          <priority value="info"/>
          <appender-ref ref="FILE"/>
      </root>

  </log4j:configuration>

Command line (CLI) parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are a number of CLI parameters you can pass to the call in your ``graylogctl`` script:

* ``-h``, ``--help``: Show help message
* ``-f CONFIGFILE``, ``--configfile CONFIGFILE``: Use configuration file `CONFIGFILE` for Graylog; default: ``/etc/graylog/server/server.conf``
* ``-t``, ``--configtest``: Validate the Graylog configuration and exit with exit code 0 if the configuration file is syntactically correct, exit code 1 and a description of the error otherwise
* ``-d``, ``--debug``: Run in debug mode
* ``-l``, ``--local``: Run in local mode. Automatically invoked if in debug mode. Will not send system statistics, even if enabled and allowed. Only interesting for development and testing purposes.
* ``-s``, ``--statistics``: Print utilization statistics to STDOUT
* ``-r``, ``--no-retention``: Do not automatically delete old/outdated indices
* ``-p PIDFILE``, ``--pidfile PIDFILE``: Set the file containing the PID of graylog to `PIDFILE`; default: `/tmp/graylog.pid`
* ``-np``, ``--no-pid-file``: Do not write PID file (overrides `-p`/`--pidfile`)
* ``--version``: Show version of Graylog and exit

Problems with IPv6 vs. IPv4?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your `graylog-server` instance refuses to listen on IPv4 addresses and always chooses for example a `rest_listen_address` like `:::12900`
you can tell the JVM to prefer the IPv4 stack.

Add the `java.net.preferIPv4Stack` flag in your `graylogctl` script or from wherever you are calling the `graylog.jar`::

    ~$ sudo -u graylog java -Djava.net.preferIPv4Stack=true -jar graylog.jar

Manual setup: graylog-web-interface on Linux
--------------------------------------------

Prerequisites
^^^^^^^^^^^^^

The only thing you need is at least one compatible ``graylog-server`` node. Please use the same version number to make sure that it
is compatible.

You also **must** use **Java 7**! Java 6 is not compatible with Graylog and will also not receive any more publicly available bug
and security fixes by Oracle.

Downloading and extracting the web-interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Download the package from the `download pages <https://www.graylog.org/download/>`_.

Extract the archive::

  ~$ tar xvfz graylog-web-interface-VERSION.tgz
  ~$ cd graylog-web-interface-VERSION

Configuring the web interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Open ``conf/graylog-web-interface.conf`` and set the two following variables:

* ``graylog2-server.uris="http://127.0.0.1:12900/"``: This is the list of ``graylog-server`` nodes the web interface will try to use.
  You can configure one or multiple, separated by commas. Use the ``rest_listen_uri`` (configured in ``graylog.conf``) of your ``graylog-server`` instances here.

* ``application.secret=""``: A secret for encryption. Use a long, randomly generated string here. (for example generated using ``pwgen -N 1 -s 96``)

Starting the web interface
^^^^^^^^^^^^^^^^^^^^^^^^^^

You need to have Java installed. Running the OpenJDK is totally fine and should be available on all platforms. For example on Debian it is::

  ~$ apt-get install openjdk-7-jre

**You need at least Java 7** as Java 6 has reached EOL.

Now start the web interface::

  ~$ bin/graylog-web-interface
  Play server process ID is 5723
  [info] play - Application started (Prod)
  [info] play - Listening for HTTP on /0:0:0:0:0:0:0:0:9000

The web interface will listen on port 9000. You should see a login screen right away after pointing your browser to it. Log in with username
``admin`` and the password you configured at ``root_password_sha2`` in the ``graylog.conf`` of your ``graylog-server``.

Changing the listen port and address works like this::

  ~$ bin/graylog-web-interface -Dhttp.port=1234 -Dhttp.address=127.0.0.1

Java generally prefers to bind to an IPv6 address if that is supported by your system, while you might want to prefer IPv4. To change Java's
default preference you can pass ``-Djava.net.preferIPv4Stack=true`` to the startup script::

  ~$ bin/graylog-web-interface -Djava.net.preferIPv4Stack=true

All those ``-D`` settings can also be added to the ``JAVA_OPTS`` environment variable which is being read by the startup script, too.

You can start the web interface in background for example like this::

  ~$ nohup bin/graylog-web-interface &

Custom configuration file path
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can put the configuration file into another directory like this:

  ~$ bin/graylog-web-interface -Dconfig.file=/etc/graylog-web-interface.conf

Create a message input and send a first message
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Log in to the web interface and navigate to *System* -> *Nodes*. Select your ``graylog-server`` node there and click on *Manage inputs*.

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

Enabling HTTPS is easy. Just start the web interface like this::

  bin/graylog-web-interface -Dhttps.port=443

This will generate self-signed certificate. To use proper certificates you must configure a Java key store. Most signing authorities provide
instructions on how to create a Java keystore and the official keystore utility docs can be found
`here <http://docs.oracle.com/javase/7/docs/technotes/tools/solaris/keytool.html>`_.

  * ``https.keyStore`` The path to the keystore containing the private key and certificate, if not provided generates a keystore for you
  * ``https.keyStoreType`` The key store type, defaults to JKS
  * ``https.keyStorePassword`` The password, defaults to a blank password
  * ``https.keyStoreAlgorithm`` The key store algorithm, defaults to the platforms default algorithm

To disable HTTP without SSL completely and enforce HTTPS, use this parameter::

  -Dhttp.port=disabled

Configuring logging
^^^^^^^^^^^^^^^^^^^

The default setting of the web interface is to write its own logs to ``STDOUT``. You can take control of the logging by specifying an own
`Logback <http://logback.qos.ch/>`_ configuration file to use::

  bin/graylog-web-interface -Dlogger.file=/etc/graylog-web-interface-log.xml

This is an example Logback configuration file that has a disabled ``STDOUT`` appender and an enabled appender that writes to a file
(``/var/log/graylog/web/graylog-web-interface.log``), keeps 30 days of logs in total and creates a new log file if a file should have
reached a size of 100MB::

  <configuration>

      <!--
      <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
          <encoder>
              <pattern>%date %-5level [%thread] - [%logger]- %msg%n</pattern>
          </encoder>
      </appender>
      -->

      <appender name="ROLLING_FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
          <file>/var/log/graylog/web/graylog-web-interface.log</file>
          <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
              <FileNamePattern>/var/log/graylog/web/graylog-web-interface.log.%d{yyyy-MM-dd}.%i.log.gz</FileNamePattern>
              <MaxHistory>30</MaxHistory>
              <timeBasedFileNamingAndTriggeringPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
                  <maxFileSize>100MB</maxFileSize>
              </timeBasedFileNamingAndTriggeringPolicy>
          </rollingPolicy>
          <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
              <pattern>%date [%thread] %-5level %logger{36} - %msg%n</pattern>
          </encoder>
      </appender>

      <root level="INFO">
          <!--<appender-ref ref="STDOUT" />-->
          <appender-ref ref="ROLLING_FILE" />
      </root>

  </configuration>

Operating system packages
=========================

Until configuration management systems made their way into broader markets and many datacenters, one of the most common ways to install
software on Linux servers was to use operating system packages. Debian has ``DEB``, Red Hat has ``RPM`` and many other distributions are
based on those or come with own package formats. Online repositories of software packages and corresponding package managers make installing
and configuring new software a matter of a single command and a few minutes of time.

Graylog offers official ``DEB`` and ``RPM`` package repositories for Ubuntu 12.04, Ubuntu 14.04, Debian 7 and CentOS 6.

The repositories can be setup by installing a single package. Once that's done the Graylog packages can be installed via ``apt-get`` or
``yum``. The packages can also be downloaded with a web browser at https://packages.graylog2.org/ if needed.

**Make sure to install and configure MongoDB and Elasticsearch before starting the Graylog services.**

Ubuntu 14.04
------------

Download and install `graylog-1.0-repository-ubuntu14.04_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.0-repository-ubuntu14.04_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ sudo dpkg -i graylog-1.0-repository-ubuntu14.04_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

Ubuntu 12.04
------------

Download and install `graylog-1.0-repository-ubuntu12.04_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.0-repository-ubuntu12.04_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ sudo dpkg -i graylog-1.0-repository-ubuntu12.04_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

Debian 7
--------

Download and install `graylog-1.0-repository-debian7_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.0-repository-debian7_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ sudo dpkg -i graylog-1.0-repository-debian7_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

CentOS 6
--------

Download and install `graylog-1.0-repository-el6_latest.rpm <https://packages.graylog2.org/repo/packages/graylog-1.0-repository-el6_latest.rpm>`_
via ``rpm(8)``::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-1.0-repository-el6_latest.rpm
  $ yum install graylog-server graylog-web

Please open an `issue <https://github.com/Graylog2/fpm-recipes/issues>`_ in the `Github repository <https://github.com/Graylog2/fpm-recipes>`_ if you
run into any packaging related issues. **Thank you!**


Chef, Puppet, Ansible, Vagrant
==============================

The DevOps movement turbocharged market adoption of the newest generation of configuration management and orchestration tools like
`Chef <https://www.chef.io>`_, `Puppet <http://puppetlabs.com>`_ or `Ansible <http://www.ansible.com>`_. Graylog offers official scripts for
all three of them:

* https://supermarket.chef.io/cookbooks/graylog2
* https://forge.puppetlabs.com/graylog2/graylog2
* https://galaxy.ansible.com/list#/roles/1508

There are also official `Vagrant <https://www.vagrantup.com>`_ images if you want to spin up a local virtual machine quickly.
(Note that the pre-built `Virtual machine appliances`_ are a preferred way to run Graylog in production)

* https://github.com/Graylog2/graylog2-images/tree/master/vagrant

Amazon Web Services
===================

The `Virtual machine appliances`_ are supporting Amazon Web Services EC2 AMIs as platform.

Docker
======

The `Virtual machine appliances`_ are supporting Docker as runtime.

Microsoft Windows
=================

Unfortunately there is no officially supported way to run Graylog on Microsoft Windows operating systems even though all parts run on the
Java Virtual Machine. We recommend to run the `Virtual machine appliances`_ on a Windows host. It should be technically possible
to run Graylog on Windows but it is most probably not worth the time to work your way around the cliffs.

Should you require running Graylog on Windows, you need to disable the message journal in ``graylog-server`` by changing the following setting in the ``graylog.conf``::

  message_journal_enabled = false

Due to restrictions of how Windows handles file locking the journal will not work correctly. This will be improved in future versions.

**Please note that this impacts Graylog's ability to buffer messages, so we strongly recommend running the Linux-based OVAs on Windows.**
