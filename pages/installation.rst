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

**System requirements**

The Graylog server application has the following prerequisites:

* Some modern Linux distribution (Debian Linux, Ubuntu Linux, or CentOS recommended)
* `Elasticsearch 1.7.3 or later <https://www.elastic.co/downloads/elasticsearch>`_ (Elasticsearch 2.x is currently not supported)
* `MongoDB 2.0 or later <https://docs.mongodb.org/manual/administration/install-on-linux/>`_ (latest stable version is recommended)
* Oracle Java SE 7 or later (Oracle Java SE 8 is supported, OpenJDK 7 and OpenJDK 8 also work; latest stable update is recommended)

The Graylog web interface has the following prerequisites:

* Some modern Linux distribution (Debian Linux, Ubuntu Linux, or CentOS recommended)
* Oracle Java SE 7 or later (Oracle Java SE 8 is supported, OpenJDK 7 and OpenJDK 8 also work; latest point release is recommended)


This chapter is explaining the many ways to install Graylog and aims to help choosing the one that fits your needs.

**Choose an installation method:**

.. toctree::
   :titlesonly:

   installation/virtual_machine_appliances
   installation/graylog_ctl
   installation/operating_system_packages
   installation/config_management_tools
   installation/docker
   installation/vagrant
   installation/openstack
   installation/aws
   installation/windows
   installation/manual_setup
