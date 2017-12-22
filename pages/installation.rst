.. _installing:

******************
Installing Graylog
******************

Modern server architectures and configurations are managed in many different ways. Some people still put new software
somewhere in ``opt`` manually for each server while others have already jumped on the configuration management train and
fully automated reproducible setups.

Graylog can be installed in many different ways so you can pick whatever works best for you. We recommend to start with the
:ref:`virtual machine appliances <virtual-machine-appliances>` for the fastest way to get started and then pick one
of the other, more flexible installation methods to build an easier to scale setup.

This chapter is explaining the many ways to install Graylog and aims to help choosing the one that fits your needs.

.. toctree::
   :caption: Choose an installation method
   :titlesonly:

   installation/virtual_machine_appliances
   installation/operating_system_packages
   installation/config_management_tools
   installation/docker
   installation/vagrant
   installation/openstack
   installation/aws
   installation/windows
   installation/manual_setup


.. _system-requirements:

===================
System requirements
===================

The Graylog server application has the following prerequisites:

* Some modern Linux distribution (Debian Linux, Ubuntu Linux, or CentOS recommended)
* `Elasticsearch 2.3.5 or later <https://www.elastic.co/downloads/elasticsearch>`_
* `MongoDB 2.4 or later <https://docs.mongodb.org/manual/administration/install-on-linux/>`_ (latest stable version is recommended)
* Oracle Java SE 8 (OpenJDK 8 also works; latest stable update is recommended)

.. caution:: Graylog prior to 2.3 **does not** work with Elasticsearch 5.x!
