.. _virtual-machine-appliances:

**************************
Virtual Machine Appliances
**************************

Download
========

Download the OVA image from `here <https://packages.graylog2.org/appliances/ova>`_
and save it to your disk locally.

Run the image
=============

You can run the OVA in many systems like `VMware <http://www.vmware.com>`_ or
`Virtualbox <https://www.virtualbox.org>`_. In this example we will guide you
through running the OVA in the free Virtualbox on OSX.

In Virtualbox select *File -> Import appliance*:

.. image:: /images/virtualbox1.png

Hit *Continue* and keep the suggested settings on the next page as they are. Make
sure that you have enough RAM and CPUs on your local machine. You can lower the
resources the virtual machine will get assigned but we recommend to not lower
it to ensure a good Graylog experience. In fact you might have to raise it if
you plan to scale out later and send more messages into Graylog.

Press *Import* to finish loading the OVA into Virtualbox:

.. image:: /images/virtualbox2.png

You can now start the VM and should see a login shell like this when the boot
completed:

.. image:: /images/virtualbox3.png

Logging in
==========

You can log into the shell of the operating system of the appliance with the
user *ubuntu* and the password *ubuntu*. You should of course change those
credentials if you plan to go into production with the appliance.

The web interface is reachable on port 80 at the IP address of your virtual
machine. The login prompt of the shell is showing you this IP address, too. (See
screenshot above). DHCP should be enabled in your network otherwise take a look into
the ``graylog-ctl`` command to apply a static IP address to the appliance.

The standard user for the web interface is *admin* with the password *admin*.

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
