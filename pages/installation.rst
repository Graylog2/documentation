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

This chapter is explaining the many ways to install Graylog2 and aims to help choosing the one that fits your needs.

Virtual machine appliances
==========================

The easiest way to get started with a production ready Graylog setup is using our official virtual machine appliances. We offer
those for the following platforms:

* `OVA for VMware / Virtualbox <https://github.com/Graylog2/graylog2-images/tree/master/ova>`_
* `OpenStack <https://github.com/Graylog2/graylog2-images/tree/master/openstack>`_
* `Amazon Web Services / EC2 <https://github.com/Graylog2/graylog2-images/tree/master/aws>`_
* `Docker <https://github.com/Graylog2/graylog2-images/tree/master/docker>`_

Please follow the links for specific instructions and downloads. The next chapters explain general principles of the appliances:

Configuring the appliances
--------------------------

The great thing about the new appliances is the ``graylog2-ctl`` tool that we are shipping with them. We want you to get started
with pa customised setup as soon as quickly as possible so you can now do things like::

  graylog2-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  graylog2-ctl set-admin-password <password>
  graylog2-ctl set-timezone <zone acronym>
  graylog2-ctl reconfigure

Scaling out
-----------

We are also providing an easy way to automatically scale out to more boxes once you grew out of your initial setup. Every appliance
is always shipping with all required Graylog components and you can at any time decide which role a specific box should take::

  graylog2-ctl reconfigure-as-server
  graylog2-ctl reconfigure-as-webinterface
  graylog2-ctl reconfigure-as-datanode

Quick setup application
=======================

The quick setup application is a Java program that will install Graylog for you and take care of most configuration automatically.
It starts a little web server on the machine that you want to install Graylog on. You connect to it using your browser and will
be presented with an interactive wizard that asks you for some simple configuration variables. During the wizard the connections
between required components are tested to guarantee that the single steps succeeded. It usually takes no longer than five minutes
from starting the quick setup application to signing into your new Graylog setup.

It is important to remember that the quick setup app is **not** meant to create production ready setups. I strongly recommend to
use one of the other installation methods for a Graylog setup that is intended to run in production.

.. image:: /images/qsa1.png

Using the quick setup application
---------------------------------

All you need is a Linux machine with Java installed. The executable comes with a built-in web server that you point your browser to.
All the rest of the process is controlled from your browser.

Download and start the quick setup application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Start by downloading the quick setup app from our `downloads page <http://www.graylog.org/download/>`_ Now extract the archive to any
location you like. All parts of the Graylog2 system will be extracted in subfolders.

Next step is to run the app and opening the URL you are seeing in your browser::

  $ wget http://packages.graylog2.org/releases/graylog2-setup/graylog2-setup-<LATEST-VERSION>.tar.gz
  $ tar -xzf graylog2-setup-<LATEST-VERSION>.tar.gz
  $ cd graylog2-setup && ./graylog2 setup
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

Creating a Graylog2 user account
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the next step you will be asked to create your first Graylog2 user account. This account will get administrator rights and allows you
to further configure the system later on. **Remember the username and password because you will need it for logging in to your
new Graylog2 system later.**

Finish setup
^^^^^^^^^^^^

Now finish the setup by clicking on *Install Graylog2*. You will only be able to click the button if you have successfully completed all
required steps before.

The quick setup app will start all required services and write some configuration files. This can take some time so please be patient
with the progress bar.

Usually the progress bar will turn all green after completion and you will be redirected to the final summary page. You are now running
Graylog!

Check the output of the quick setup app process in your shell to find out how to start Graylog2 after shutting down the quick setup app::


  Starting elasticsearch with the following command:
      [...]
  Starting graylog2 server with the following command:
      [...]
  Starting graylog2 web interface with the following command:
      [...]

  Terminating this process will stop Graylog2 as well. To run the processes manually, please refer to the output above.

  Happy logging!

Using your new Graylog2 system
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The quick setup app should have given you a link to your new Graylog2 setup. Log in with the username and password you defined before.

**Congratulations!** You are now running Graylog2. Please note that we do not recommend to run a system installed by the quick setup
app in production. Reason is that you are probably not familiar enough with the system and that you may have to tune some parameters to
be able to handle huge loads of log messages.

.. image:: /images/qsa2.png


The classic setup
=================

We recommend to only run this if you have good reasons not to use one of the other production ready installation methods described
in this chapter.

Installing Graylog using the classic setup: graylog-server on Linux
-------------------------------------------------------------------

Prerequisites
^^^^^^^^^^^^^

You will need to have the following services installed on either the host you are running ``graylog2-server`` on or on dedicated machines:

* [Elasticsearch 1.3.4 or higher](http://www.elasticsearch.org/downloads)
* MongoDB (as recent stable version as possible, **at least v2.0**)

Most standard MongoDB packages of Linux distributions are outdated. Use the `official MongoDB apt source <http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/>`_.
(Available for many distributions and operating systems)

You also **must** use **Java 7** or higher! Java 6 is not compatible with Graylog2 and will also not receive any more publicly available bug and security
fixes by Oracle.

A more detailed guide for installing the dependencies will follow. **The only important thing for Elasticsearch is that you configure
``cluster.name: graylog2`` in it's ``conf/elasticsearch.yml``**.

Downloading and extracting the server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Download the package from the `download pages <https://www.graylog.org/download/>`_

Extract the archive::

  ~$ tar xvfz graylog2-server-VERSION.tgz
  ~$ cd graylog2-server-VERSION

Configuration
^^^^^^^^^^^^^

Now copy the example configuration file::

  ~# cp graylog2.conf.example /etc/graylog/server/server.conf

You can leave most variables as they are for a first start. All of them should be well documented.

Configure at least these variables in ``/etc/graylog/server/server.conf``:

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
      messages in your Graylog2 setup. It is always better to have several more smaller indices than just a few larger ones.
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

**You need at least Java 7** (Java 6 has reached EOL)

Start the server::

  ~$ cd bin/
  ~$ ./graylogctl start

The server will try to write a ``node_id`` to the ``graylog-server-node-id`` file. It won't start if it can't write there because of for
example missing permissions.

See the startup parameters description below to learn more about available startup parameters. Note that you might have to be `root`
to bind to the popular port 514 for syslog inputs.

You should see a line like this in the debug output of ``graylog-server`` successfully connected to your Elasticsearch cluster::

  2013-10-01 12:13:22,382 DEBUG: org.elasticsearch.transport.netty - [graylog-server] connected to node [[Unuscione, Angelo][thN_gIBkQDm2ab7k-2Zaaw][inet[/10.37.160.227:9300]]]

You can find the ``graylog-server`` logs in ``logs/``.

**Important:** All ``graylog-server`` instances must have synchronised time. We strongly recommend to use
`NTP <http://en.wikipedia.org/wiki/Network_Time_Protocol>`_ on all machines of your Graylog infrastructure.

Supplying external logging configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``graylog-server`` uses log4j for its internal logging and ships with a
`default log configuration file <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/resources/log4j.xml>`
which is embedded within the shipped jar.

In case you need to overwrite the configuration ``graylog-server`` uses, you can supply a Java system property specifying the path to
the configuration file in your ``graylogctl`` script. Append this before the `-jar` paramter::

  -Dlog4j.configuration=file:///tmp/logj4.xml

Substitute the actual path to the file for the ``/tmp/log4j.xml`` in the example.

In case you do not have a log rotation system already in place, you can also configure Graylog2 to rotate logs based on their size to prevent its
logs to grow without bounds.

One such example ``log4j.xml`` configuration is shown below. Graylog2 includes the ``log4j-extras`` companion classes to support time based and size
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are a number of CLI parameters you can pass to the call in your ``graylogctl`` script:

* ``-h``, ``--help``: Show help message
* ``-f CONFIGFILE``, ``--configfile CONFIGFILE``: Use configuration file `CONFIGFILE` for graylog; default: ``/etc/graylog/server/server.conf``
* ``-t``, ``--configtest``: Validate graylog2 configuration and exit with exit code 0 if the configuration file is syntactically correct, exit code 1 and a description of the error otherwise
* ``-d``, ``--debug``: Run in debug mode
* ``-l``, ``--local``: Run in local mode. Automatically invoked if in debug mode. Will not send system statistics, even if enabled and allowed. Only interesting for development and testing purposes.
* ``-s``, ``--statistics``: Print utilization statistics to STDOUT
* ``-r``, ``--no-retention``: Do not automatically delete old/outdated indices
* ``-p PIDFILE``, ``--pidfile PIDFILE``: Set the file containing the PID of graylog to `PIDFILE`; default: `/tmp/graylog.pid`
* ``-np``, ``--no-pid-file``: Do not write PID file (overrides `-p`/`--pidfile`)
* ``--version``: Show version of graylog and exit

Problems with IPv6 vs. IPv4?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your `graylog-server` instance refuses to listen on IPv4 addresses and always chooses for example a `rest_listen_address` like `:::12900`
you can tell the JVM to prefer the IPv4 stack.

Add the `java.net.preferIPv4Stack` flag in your `graylog2ctl` script or from wherever you are calling the `graylog-server.jar`::

    ~$ sudo -u graylog java -Djava.net.preferIPv4Stack=true -jar graylog-server.jar



























Operating system packages
=========================

Until configuration management systems made their way into broader markets and many datacenters, one of the most common ways to install
software on Linux servers was to use operating system packages. Debian has `DEB`, Red Hat has `RPM` and many other distributions are
based on those or come with own package formats. Online repositories of software packages and corresponding package managers make installing
and configuring new software a matter of a single command and a few minutes of time.

Graylog offers official `DEB` and `RPM` package repositories for Ubuntu 12.04, Ubuntu 14.04, Debian 7 and CentOS 6.

-------------HOW TO---------------

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
