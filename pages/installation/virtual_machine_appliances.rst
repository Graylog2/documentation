.. _virtual-machine-appliances:

**************************
Virtual Machine Appliances
**************************

Pre-Considerations
==================

Please run this appliance always in a separated network that is isolated from the internet.
Read also the notes about production readiness_!

Download
========

Download the `OVA image <https://packages.graylog2.org/appliances/ova>`_. If you are unsure what the latest version number is, take a look at our `release page <https://www.graylog.org/downloads>`__.


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



.. note:: If you don't have a working DHCP server for your virtual machine, you will get the error message:
   
      "Your appliance came up without a configured IP address. Graylog is probably not running correctly!"
   
   In this case, you have to login and edit configuration files under ``/etc/netplan/`` in order to setup a fixed IP address. Then create the file ``/var/lib/graylog-server/firstboot`` and reboot.


Logging in
==========

You can log into the shell of the operating system of the appliance with the
user *ubuntu* and the password *ubuntu*. You should of course change those
credentials.

The web interface is reachable on port 80 at the IP address of your virtual
machine. The login prompt of the shell is showing you this IP address, too. (See
screenshot above).

The standard user for the web interface is *admin*, the password is shown in the console of the virtual server on the first boot.

Configuration
=============

Please check the :doc:`Graylog configuration file </pages/configuration/server.conf>`
documentation, if you need to further customize your appliance.

VMWare ESXi
===========

.. note:: The appliances are build technically with VirtualBox. However most ESXi versions are able to import and run the appliance but be prepared for unexpected troubles especially during import.

If you are using the appliance on a VMWare host, you might want to install the hypervisor tools::

  sudo apt-get install -y open-vm-tools

Update OVA to latest Version
============================

2.x
   It is not possible to upgrade previous OVAs to Graylog 3.0.0.

3.x
   Starting with Graylog 3.0.0, OVAs use the Operating System packages, so
   you can upgrade your appliance by following
   :ref:`this update guide <operating_package_upgrade_DEB-APT>`.

.. _readiness:

Production readiness
====================

The Graylog appliance is not created to provide a production ready solution. It is build to offer a fast and easy way to try the software itself and not wasting time to install Graylog and it components to any kind of server.
