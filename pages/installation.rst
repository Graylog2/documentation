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

———— TBD WHEN VM IMAGES ARE RELEASED ————

Quick setup application
=======================

The quick setup application is a Java program that will install Graylog for you and take care of most configuration automatically.
It starts a little web server on the machine that you want to install Graylog on. You connect to it using your browser and will
be presented with an interactive wizard that asks you for some simple configuration variables. During the wizard the connections
between required components are tested to guarantee that the single steps succeeded. It usually takes no longer than five minutes
from starting the quick setup application to signing into your new Graylog setup.

It is important to remember that the quick setup app is **not** meant to create production ready setups. I strongly recommend to
use one of the other installation methods for a Graylog setup that is intended to run in production.

.. image:: /images/qsa.png

Using the quick setup application
---------------------------------

-------------HOW TO---------------

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
