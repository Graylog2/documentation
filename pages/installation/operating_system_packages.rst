.. _ospackages:

*************************
Operating System Packages
*************************

Until configuration management systems made their way into broader markets and many datacenters, one of the most common ways to install
software on Linux servers was to use operating system packages. Debian has ``DEB``, Red Hat has ``RPM`` and many other distributions are
based on those or come with their own package formats. Online repositories of software packages and corresponding package managers make installing
and configuring new software a matter of a single command and a few minutes of time.

Graylog offers official ``DEB`` and ``RPM`` package repositories. The packages have been tested on the following operating systems:

* Ubuntu 16.04, 18.04
* Debian 8, 9, 10
* RHEL/CentOS 6, 7


The repositories can be set up by installing a single package. Once that's done, the Graylog packages can be installed via ``apt-get`` or
``yum``. The packages can also be downloaded with a web browser at https://packages.graylog2.org/ if needed.

Prerequisites
-------------

Make sure to install and configure the following software before installing and starting any Graylog services:

* Java ( >= 8 )
* Elasticsearch (5.x or 6.x)
* MongoDB (3.6 or 4.0)

.. caution:: Graylog 3 **does not** work with Elasticsearch 7.x!
.. caution:: Graylog 3 does work with MongoDB 4.2 only in `4.0 compatibility mode <https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/#dbcmd.setFeatureCompatibilityVersion>`_ !

Step by Step Guides
-------------------
* :ref:`Ubuntu <ubuntuguide>`
* :ref:`Debian <debianguide>`
* :ref:`RHEL/CentOS <centosguide>`
* :ref:`SLES <sleguide>`


.. _operating_package_DEB-APT:

DEB / APT
---------

Download and install `graylog-3.2-repository_latest.deb <https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ sudo apt-get install apt-transport-https
  $ wget https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.deb
  $ sudo dpkg -i graylog-3.2-repository_latest.deb
  $ sudo apt-get update
  $ sudo apt-get install graylog-server

.. hint:: If you want the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, you need to install them now. The following install all official provided packages by Graylog at the same time: ``sudo apt-get install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins`` 

After the installation completed successfully, Graylog can be started with the following commands. Make sure to use the correct command for your operating system.


================================= =========== =======================================
OS                                Init System Command
================================= =========== =======================================
Debian 7                          SysV        ``sudo service graylog-server start``
Debian 8 & 9, Ubuntu 16.04, 18.04 systemd     ``sudo systemctl start graylog-server``
================================= =========== =======================================


The packages are configured to **not** start any Graylog services during boot. You can use the following commands to start Graylog when the operating system is booting.

================================= =========== ==================================================
OS                                Init System Command
================================= =========== ==================================================
Debian 7                          SysV        ``sudo update-rc.d graylog-server defaults 95 10``
Debian 8 & 9, Ubuntu 16.06, 18.04 systemd     ``sudo systemctl enable graylog-server``
================================= =========== ==================================================

.. _operating_package_upgrade_DEB-APT:

Update to latest version
^^^^^^^^^^^^^^^^^^^^^^^^

If you've been using the repository package to install Graylog before, it has to be updated first. The new package will replace the repository URL, without which you will only be able to get bugfix releases of your previously installed version of Graylog.

The update basically works like a fresh installation::

  $ wget https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.deb
  $ sudo dpkg -i graylog-3.2-repository_latest.deb
  $ sudo apt-get update
  $ sudo apt-get install graylog-server

.. caution:: If you have the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, you need to update them together with the Graylog server package. The following command updates all official provided packages by Graylog at the same time: ``sudo apt-get install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins`` 


Manual Repository Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't like to install the repository DEB to get the repository configuration onto your system, you can do so manually (although we don't recommend to do that).

First, add the `Graylog GPG keyring <https://packages.graylog2.org/repo/debian/keyring.gpg>`_ which is being used to sign the packages to your system.

.. hint:: We assume that you have placed the GPG key into ``/etc/apt/trusted.gpg.d/``.

Now create a file ``/etc/apt/sources.list.d/graylog.list`` with the following content::

  deb https://packages.graylog2.org/repo/debian/ stable 3.2

.. _operating_package_rpm-yum-dnf:

RPM / YUM / DNF
---------------

Download and install `graylog-3.2-repository_latest.rpm <https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.rpm>`_
via ``rpm(8)``::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.rpm
  $ sudo yum install graylog-server

.. hint:: If you want the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, you need to install them now. The following install all official provided packages by Graylog at the same time: ``sudo yum install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins`` 

After the installation completed successfully, Graylog can be started with the following commands. Make sure to use the correct command for your operating system.

=================== =========== =======================================
OS                  Init System Command
=================== =========== =======================================
CentOS 6            SysV        ``sudo service graylog-server start``
CentOS 7            systemd     ``sudo systemctl start graylog-server``
=================== =========== =======================================

The packages are configured to **not** start any Graylog services during boot. You can use the following commands to start Graylog when the operating system is booting.

=================== =========== ==================================================
OS                  Init System Command
=================== =========== ==================================================
CentOS 6            SysV        ``sudo update-rc.d graylog-server defaults 95 10``
CentOS 7            systemd     ``sudo systemctl enable graylog-server``
=================== =========== ==================================================

.. _operating_package_upgrade_rpm-yum-dnf:

Update to latest version
^^^^^^^^^^^^^^^^^^^^^^^^

If you've been using the repository package to install Graylog before, it has to be updated first. The new package will replace the repository URL, without which you will only be able to get bugfix releases of your previously installed version of Graylog.

The update basically works like a fresh installation::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-3.2-repository_latest.rpm
  $ sudo yum clean all
  $ sudo yum install graylog-server

Running ``yum clean all`` is required because YUM might use a stale cache and thus might be unable to find the latest version of the ``graylog-server`` package.

.. caution:: If you have the :ref:`Integrations Plugins <integrations_plugins>` or the :ref:`Enterprise Plugins <enterprise_features>` installed, you need to update them together with the Graylog server package. The following command updates all official provided packages by Graylog at the same time: ``sudo yum install graylog-server graylog-enterprise-plugins graylog-integrations-plugins graylog-enterprise-integrations-plugins`` 


Manual Repository Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't like to install the repository RPM to get the repository configuration onto your system, you can do so manually (although we don't recommend to do that).

First, add the `Graylog GPG key <https://github.com/Graylog2/fpm-recipes/blob/master/recipes/graylog-repository/files/rpm/RPM-GPG-KEY-graylog>`_ which is being used to sign the packages to your system.

.. hint:: We assume that you have placed the GPG key into ``/etc/pki/rpm-gpg/RPM-GPG-KEY-graylog``.

Now create a file named ``/etc/yum.repos.d/graylog.repo`` with the following content::

  [graylog]
  name=graylog
  baseurl=https://packages.graylog2.org/repo/el/stable/3.2/$basearch/
  gpgcheck=1
  repo_gpgcheck=0
  gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-graylog

.. _step_by_step_guides:

Step-by-step guides
-------------------

.. toctree::
   :maxdepth: 1

   os/ubuntu
   os/debian
   os/centos
   os/sles


Feedback
--------

Please file a `bug report in the GitHub repository for the operating system packages <https://github.com/Graylog2/fpm-recipes>`__ if you
run into any packaging related issues.

If you found this documentation confusing or have more questions, please open an `issue in the Github repository for the documentation <https://github.com/Graylog2/documentation/issues>`__.
