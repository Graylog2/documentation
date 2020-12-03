.. _enterprise-setup-updating:

**************************
Updating to latest version
**************************

If you've been using the repository package to install Graylog before, it has to be updated first. The new package will replace the repository URL, without which you will only be able to get bugfix releases of your previously installed version of Graylog.

The update basically works like a fresh installation. For apt-based systems, run the following commands::

  $ wget https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb
  $ sudo dpkg -i graylog-4.0-repository_latest.deb
  $ sudo apt-get update
  $ sudo apt-get install graylog-enterprise

For rpm-based systems, run the following commands::

  $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.rpm
  $ sudo yum clean all
  $ sudo yum install graylog-enterprise

Running ``yum clean all`` is required because YUM might use a stale cache and thus might be unable to find the latest version of the ``graylog-enterprise`` package.
