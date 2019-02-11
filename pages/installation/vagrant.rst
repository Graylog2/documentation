.. _Vagrant:

*******
Vagrant
*******

Requirements
------------
You need a `recent <https://www.vagrantup.com/downloads.html>`_ `vagrant` version.

Installation
------------

These steps will create a Vagrant virtual machine with all Graylog services running::

  $ wget https://raw.githubusercontent.com/Graylog2/graylog2-images/3.0/vagrant/Vagrantfile
  $ vagrant up

Usage
-----

After starting the virtual machine, your Graylog instance is ready to use.
You can reach the web interface by pointing your browser to : `http://localhost:8080`

The default login is Username: `admin`, Password: `admin`.

Configuration
=============

Starting with Graylog 3.0.0, Vagrant virtual machines also use the
:doc:`Graylog Operating System packages </pages/installation/operating_system_packages>`.
Please check the :doc:`Graylog configuration file </pages/configuration/server.conf>`
documentation, if you need to further customize your appliance.

