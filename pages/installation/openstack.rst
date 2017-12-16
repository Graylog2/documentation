*********
OpenStack
*********

Installation
------------

Download the Graylog image from the `package <https://packages.graylog2.org/appliances/qcow2>`_ site, uncompress it and import it into the OpenStack image store::

  $ wget https://packages.graylog2.org/releases/graylog-omnibus/qcow2/graylog-2.3.0-1.qcow2.gz
  $ gunzip graylog-2.3.0-1.qcow2.gz
  $ glance image-create --name='graylog' --is-public=true --container-format=bare --disk-format=qcow2 --file graylog-2.3.0-1.qcow2

You should now see an image called `graylog` in the OpenStack web interface under `Images`

Usage
-----

Launch a new instance of the image, make sure to reserve at least 4GB ram for the instance. After spinning up, login with
the username `ubuntu` and your selected ssh key. Run the reconfigure program in order to setup Graylog and start all services::

  $ ssh ubuntu@<vm IP>
  $ sudo graylog-ctl reconfigure

Open `http://<vm ip>` in your browser to access the Graylog web interface. Default username and password is `admin`.

Basic configuration
===================

We are shipping the ``graylog-ctl`` tool with the virtual machine appliances to get you started
with a customised setup as quickly as possible. Run these (optional) commands to configure the
most basic settings of Graylog in the appliance::

  sudo graylog-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  sudo graylog-ctl set-admin-password <password>
  sudo graylog-ctl set-timezone <zone acronym>
  sudo graylog-ctl reconfigure

The ``graylog-ctl`` has much more :ref:`functionality <graylog-ctl>` documented.
We strongly recommend to learn more about it to ensure smooth operation of your virtual appliance.

Production readiness
====================

The Graylog appliance is not created to provide a production ready solution. It is build to offer a fast and easy way to try the software itself and not wasting time to install Graylog and it components to any kind of server. 

If you want to create your own production ready setup take a look at our :ref:`other installation methods <installing>`.