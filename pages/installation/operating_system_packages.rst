*************************
Operating System Packages
*************************

Until configuration management systems made their way into broader markets and many datacenters, one of the most common ways to install
software on Linux servers was to use operating system packages. Debian has ``DEB``, Red Hat has ``RPM`` and many other distributions are
based on those or come with own package formats. Online repositories of software packages and corresponding package managers make installing
and configuring new software a matter of a single command and a few minutes of time.

Graylog offers official ``DEB`` and ``RPM`` package repositories. The packages have been tested on the following operating systems:

* Ubuntu 12.04, 14.04, 16.04
* Debian 7, 8
* RHEL/CentOS 6, 7

The repositories can be setup by installing a single package. Once that's done the Graylog packages can be installed via ``apt-get`` or
``yum``. The packages can also be downloaded with a web browser at https://packages.graylog2.org/ if needed.

Prerequisites
-------------

Make sure to install and configure the following software before installing and starting any Graylog services:

* Java (>= 8)
* MongoDB (>= 2.4)
* Elasticsearch (>= 2.x)

.. _operationg_package_DEB-APT:

DEB / APT
---------

Download and install `graylog-2.0-repository_latest.deb <https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ sudo apt-get install apt-transport-https
  $ wget https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb
  $ sudo dpkg -i graylog-2.0-repository_latest.deb
  $ sudo apt-get update
  $ sudo apt-get install graylog-server

After the installation completed successfully, Graylog can be started with the following commands. Make sure to use the correct command for your operating system.

====================== =========== =======================================
OS                     Init System Command
====================== =========== =======================================
Ubuntu 14.04, 12.04    upstart     ``sudo start graylog-server``
Debian 7               SysV        ``sudo service graylog-server start``
Debian 8, Ubuntu 16.04 systemd     ``sudo systemctl start graylog-server``
====================== =========== =======================================

The packages are configured to **not** start any Graylog services during boot. You can use the following commands to start Graylog when the operating system is booting.

====================== =========== ==================================================
OS                     Init System Command
====================== =========== ==================================================
Ubuntu 14.04, 12.04    upstart     ``sudo rm -f /etc/init/graylog-server.override``
Debian 7               SysV        ``sudo update-rc.d graylog-server defaults 95 10``
Debian 8, Ubuntu 16.06 systemd     ``sudo systemctl enable graylog-server``
====================== =========== ==================================================

Manual Repository Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't like to install the repository DEB to get the repository configuration onto your system, you can do so manually (although we don't recommend to do that).

First, add the `Graylog GPG keyring <https://packages.graylog2.org/repo/debian/keyring.gpg>`_ which is being used to sign the packages to your system.

.. hint:: We assume that you have placed the GPG key into ``/etc/apt/trusted.gpg.d/``.

Now create a file ``/etc/apt/sources.list.d/graylog.list`` with the following content::

  deb https://packages.graylog2.org/repo/debian/ stable 2.0

.. _operating_package_rpm-yum-dnf:

RPM / YUM / DNF
---------------

Download and install `graylog-2.0-repository_latest.rpm <https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.rpm>`_
via ``rpm(8)``::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.rpm
  $ sudo yum install graylog-server

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

Manual Repository Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't like to install the repository RPM to get the repository configuration onto your system, you can do so manually (although we don't recommend to do that).

First, add the `Graylog GPG key <https://github.com/Graylog2/fpm-recipes/blob/master/recipes/graylog-repository/files/rpm/RPM-GPG-KEY-graylog>`_ which is being used to sign the packages to your system.

.. hint:: We assume that you have placed the GPG key into ``/etc/pki/rpm-gpg/RPM-GPG-KEY-graylog``.

Now create a file named ``/etc/yum.repos.d/graylog.repo`` with the following content::

  [graylog]
  name=graylog
  baseurl=https://packages.graylog2.org/repo/el/stable/2.0/$basearch/
  gpgcheck=1
  gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-graylog


Step-by-step guides
-------------------

.. toctree::
   :maxdepth: 1

   os/ubuntu
   os/centos

Feedback
--------

Please open an `issue <https://github.com/Graylog2/fpm-recipes/issues>`_ in the `Github repository <https://github.com/Graylog2/fpm-recipes>`_ if you
run into any packaging related issues. **Thank you!**
