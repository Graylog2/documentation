*************************
Operating System Packages
*************************

Until configuration management systems made their way into broader markets and many datacenters, one of the most common ways to install
software on Linux servers was to use operating system packages. Debian has ``DEB``, Red Hat has ``RPM`` and many other distributions are
based on those or come with own package formats. Online repositories of software packages and corresponding package managers make installing
and configuring new software a matter of a single command and a few minutes of time.

Graylog offers official ``DEB`` and ``RPM`` package repositories for the following operating systems.

* Ubuntu 12.04, 14.04
* Debian 7, 8
* CentOS 6, 7

The repositories can be setup by installing a single package. Once that's done the Graylog packages can be installed via ``apt-get`` or
``yum``. The packages can also be downloaded with a web browser at https://packages.graylog2.org/ if needed.

**Make sure to install and configure Java (>= 7), MongoDB and Elasticsearch before starting the Graylog services.**

Ubuntu 14.04
------------

Download and install `graylog-1.2-repository-ubuntu14.04_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.2-repository-ubuntu14.04_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ wget https://packages.graylog2.org/repo/packages/graylog-1.2-repository-ubuntu14.04_latest.deb
  $ sudo dpkg -i graylog-1.2-repository-ubuntu14.04_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

After the installation successfully completed, Graylog can be started with the following commands::

  $ sudo start graylog-server
  $ sudo start graylog-web

Ubuntu 12.04
------------

Download and install `graylog-1.2-repository-ubuntu12.04_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.2-repository-ubuntu12.04_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ wget https://packages.graylog2.org/repo/packages/graylog-1.2-repository-ubuntu12.04_latest.deb
  $ sudo dpkg -i graylog-1.2-repository-ubuntu12.04_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

After the installation successfully completed, Graylog can be started with the following commands::

  $ sudo start graylog-server
  $ sudo start graylog-web

Debian 7
--------

Download and install `graylog-1.2-repository-debian7_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.2-repository-debian7_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ wget https://packages.graylog2.org/repo/packages/graylog-1.2-repository-debian7_latest.deb
  $ sudo dpkg -i graylog-1.2-repository-debian7_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

After the installation successfully completed, Graylog can be started with the following commands::

  $ sudo service graylog-server start
  $ sudo service graylog-web start

Debian 8
--------

Download and install `graylog-1.2-repository-debian8_latest.deb <https://packages.graylog2.org/repo/packages/graylog-1.2-repository-debian8_latest.deb>`_
via ``dpkg(1)`` and also make sure that the ``apt-transport-https`` package is installed::

  $ wget https://packages.graylog2.org/repo/packages/graylog-1.2-repository-debian8_latest.deb
  $ sudo dpkg -i graylog-1.2-repository-debian8_latest.deb
  $ sudo apt-get install apt-transport-https
  $ sudo apt-get update
  $ sudo apt-get install graylog-server graylog-web

After the installation successfully completed, Graylog can be started with the following commands::

  $ sudo systemctl start graylog-server
  $ sudo systemctl start graylog-web

CentOS 6
--------

Download and install `graylog-1.2-repository-el6_latest.rpm <https://packages.graylog2.org/repo/packages/graylog-1.2-repository-el6_latest.rpm>`_
via ``rpm(8)``::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-1.2-repository-el6_latest.rpm
  $ sudo yum install graylog-server graylog-web

After the installation successfully completed, Graylog can be started with the following commands::

  $ sudo service graylog-server start
  $ sudo service graylog-web start

CentOS 7
--------

Download and install `graylog-1.2-repository-el7_latest.rpm <https://packages.graylog2.org/repo/packages/graylog-1.2-repository-el7_latest.rpm>`_
via ``rpm(8)``::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-1.2-repository-el7_latest.rpm
  $ sudo yum install graylog-server graylog-web

After the installation successfully completed, Graylog can be started with the following commands::

  $ sudo systemctl start graylog-server
  $ sudo systemctl start graylog-web

Feedback
--------

Please open an `issue <https://github.com/Graylog2/fpm-recipes/issues>`_ in the `Github repository <https://github.com/Graylog2/fpm-recipes>`_ if you
run into any packaging related issues. **Thank you!**
