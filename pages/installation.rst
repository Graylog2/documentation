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

-----------MORE INFO ABOUT CLASSIC SETUP AND WHY OTHERS ARE PREFERRED------------

Installing Graylog using the classic setup
------------------------------------------

-------------HOW TO---------------

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
