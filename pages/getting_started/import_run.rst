Import the VM
^^^^^^^^^^^^^^

Although these steps and screenshots are for VMware, VirtualBox and other products will likely follow a similar process.

Select *File -> Import...*, choose the ``graylog.ova`` file you downloaded, and follow the prompts to create the virtual machine.

.. image:: /images/gs_2-import-vm.png

Start the VM
^^^^^^^^^^^^^

If you haven't already, start the virtual machine.  After the VM has started, you'll see something like the screenshot below.  Our VM is now running Graylog and everything it needs (more on that later).  Good job!

We could spread the various components across multiple VMs for performance, but there's no need to do that right now since we're just getting started.  Don't close this window just yet, since we're going to need it later.

.. image:: /images/gs_3-gl-server.png



The steps above are covered in more detail on our :ref:`virtual machine appliance installation page <virtual-machine-appliances>`. If you do not have DHCP enabled in your network you need to :ref:`assign a static IP <static_ip_ova>`. 
