*********
OpenStack
*********

Installation
------------

These steps will download the Graylog image, uncompress it and import it into the Openstack image store::

  $ wget https://packages.graylog2.org/releases/graylog-omnibus/qcow2/graylog-1.3.3-2.qcow2.gz
  $ gunzip graylog.qcow2.gz
  $ glance image-create --name='graylog' --is-public=true --container-format=bare --disk-format=qcow2 --file graylog.qcow2

You should now see an image called `graylog` in the Openstack web interface under `Images`

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

The ``graylog-ctl`` has much more functionality and is documented :ref:`here <graylog-ctl>`.
We strongly recommend to learn more about it to ensure smooth operation of your virtual appliance.
