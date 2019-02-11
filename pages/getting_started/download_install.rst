Download & Install Graylog
--------------------------
Graylog can be deployed in many different ways, You should download whatever works best for you. For those who would like to do an initial lab evaluation of Graylog, we recommend starting with the virtual machine appliances. 

Virtual Appliances are definitely the fastest way to get started. However, since the virtual appliances are generally not suitable for use in production, **they should be used strictly for proof of concept, evaluations or lab environments**. 

The virtual appliances are also completely unsecured. No hardening has been done and all default services are enabled. 

For production deployments users should select and deploy one of the other, more flexible, installation methods.

Operating System Packages
^^^^^^^^^^^^^^^^^^^^^^^^^
Graylog may be installed on the following operating systems.

* Ubuntu
* Debian
* RHEL/CentOS
* SLES

Most customers use package tools like DEB or RPM to install the Graylog software. Details are included in the section, :ref:`ospackages`.


Configuration Management
^^^^^^^^^^^^^^^^^^^^^^^^
Customers who prefer to deploy graylog via configuration management tools may do so. Graylog currently supports :ref:`confmgt`.


Containers
^^^^^^^^^^
Graylog supports Docker for deployment of Graylog, MongoDB and Elasticsearch. Installation and configuration instructions may be found on the :ref:`here` installation page.


Virtual Appliances
^^^^^^^^^^^^^^^^^^
Virtual Appliances may be downloaded from `virtual appliance download page <https://packages.graylog2.org/appliances/ova>`_ If you are unsure what the latest stable version number is, take a look at our `release page <https://www.graylog.org/downloads>`__.

.. image:: /images/gs/download.png

**Supported Virtual Appliances**

* OVA
* AWS-AMI

Deployment guide for :ref:`virtual-machine-appliances`.

Deployment guide for :ref:`AMI`.


Virtual Appliance Caveats
=========================
**Virtual appliances are not suitable for production deployment out of the box**. They do not have sufficient storage, nor do they offer capabilities like index replication that meet high availability requirements.

The virtual appliances are not hardened or otherwise secured. Use at your own risk and apply all security measures required by your organization.
