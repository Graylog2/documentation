*******
Vagrant
*******

Requirements
------------
You need a `recent <https://www.vagrantup.com/downloads.html>`_ `vagrant` version.

Installation
------------

These steps will create a Vagrant virtual machine with all Graylog services running::

  $ wget https://raw.githubusercontent.com/Graylog2/graylog2-images/2.1/vagrant/Vagrantfile
  $ vagrant up

Usage
-----

After starting the virtual machine, your Graylog instance is ready to use.
You can reach the web interface by pointing your browser to : `http://localhost:8080`

The default login is Username: `admin`, Password: `admin`.

Configuration
=============

We are shipping the ``graylog-ctl`` tool with the virtual machine appliances to get you started
with a customised setup as quickly as possible. Run these (optional) commands to configure the
most basic settings of Graylog in the appliance::

  sudo graylog-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  sudo graylog-ctl set-admin-password <password>
  sudo graylog-ctl set-timezone <zone acronym>
  sudo graylog-ctl reconfigure

The ``graylog-ctl`` has much more :ref:`functionality <graylog-ctl>` documented. We strongly recommend to learn more about it to ensure smooth operation of your virtual appliance.

If you want to create your own customised setup take a look at our :ref:`other installation methods <installing>`.
