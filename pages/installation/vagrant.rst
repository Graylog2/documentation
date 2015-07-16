*******
Vagrant
*******

Requirements
------------
You need a recent `vagrant` version, take a look `here https://www.vagrantup.com/downloads.html`_.

Installation
------------

These steps will create a Vagrant virtual machine with all Graylog services running::

  $ wget https://raw.githubusercontent.com/Graylog2/graylog2-images/master/vagrant/Vagrantfile
  $ vagrant up

Usage
-----

After starting the virtual machine, your Graylog instance is ready to use.
You can reach the web interface by pointing your browser to the IP address of your localhost: `http://<host IP>:9000`

The default login is Username: `admin`, Password: `admin`.

Basic configuration
===================

We are shipping the ``graylog-ctl`` tool with the virtual machine appliances to get you started
with a customised setup as quickly as possible. Run these (optional) commands to configure the
most basic settings of Graylog in the appliance::

  sudo graylog-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  sudo graylog-ctl set-admin-password <password>
  sudo graylog-ctl set-timezone <zone acronym>
  sudo graylog-ctl reconfigure

The ``graylog-ctl`` has much more functionality and is documented :ref:`here <graylog-ctl>`.
We strongly recommend to learn more about it to ensure smooth operation of your virtual appliance.
