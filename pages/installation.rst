.. _installing:

******************
Installing Graylog
******************

Modern server architectures and configurations are managed in many different ways. Some people still put new software
somewhere in ``opt`` manually for each server while others have already jumped on the configuration management train and
fully automated reproducible setups.

Graylog can be installed in many different ways so you can pick whatever works best for you. We recommend to start with the
:ref:`virtual machine appliances <virtual-machine-appliances>` for the fastest way to get started and then pick one
of the other, more flexible installation methods to build an easier to scale setup. (Note: The :ref:`virtual machine appliances <virtual-machine-appliances>`
are suitable for production usage because they are also prepared to scale out to some level when required.)

This chapter is explaining the many ways to install Graylog and aims to help choosing the one that fits your needs.

**Choose an installation method:**

.. toctree::
   :titlesonly:

   installation/virtual_machine_appliances
   installation/operating_system_packages
   installation/docker
   installation/config_management_tools
   installation/aws
   installation/windows
   installation/manual_setup
