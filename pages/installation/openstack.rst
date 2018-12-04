.. _OpenStack:

*********
OpenStack
*********

Installation
------------

Download the Graylog image from the `package <https://packages.graylog2.org/appliances/qcow2>`_ site, uncompress it and import it into the OpenStack image store::

  $ wget https://packages.graylog2.org/releases/graylog-omnibus/qcow2/graylog-2.5.0-1.qcow2.gz
  $ gunzip graylog-2.5.0-1.qcow2.gz
  $ glance image-create --name='graylog' --is-public=true --container-format=bare --disk-format=qcow2 --file graylog-2.5.0-1.qcow2

You should now see an image called `graylog` in the OpenStack web interface under `Images`

Usage
-----

Launch a new instance of the image, make sure to reserve at least 4GB ram for the instance. After spinning up, login with
the username `ubuntu` and your selected ssh key. Run the reconfigure program in order to setup Graylog and start all services::

  $ ssh ubuntu@<vm IP>
  $ sudo graylog-ctl reconfigure

Open `http://<vm ip>` in your browser to access the Graylog web interface. Default username and password is `admin`.

Networking
===================

Your browser needs access to port 80 or 443 for reaching the web interface. The interface itself creates a connection back to the REST API of the Graylog server on port 9000. As long as you are in the same private Neutron Network, this works out of the box. 
But in the most common OpenStack deployment topology if you want to use the OpenStack floating IP address of your VM, this mechanism doesn’t work automatically anymore. You have to tell Graylog how to reach the API from the users browser perspective::

  sudo graylog-ctl set-external-ip http://<floating ip>:9000/api/
  sudo graylog-ctl reconfigure

Also make sure that port 80, 443 and 9000 is allowed for incoming traffic on a security group assigned the the VM.

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
