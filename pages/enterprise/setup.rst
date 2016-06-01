*****
Setup
*****

Graylog Enterprise comes as a set of Graylog server plugins which need to be
installed in addition to the Graylog open source setup.

Requirements
============

The following list shows the minimum required Graylog versions for the Graylog Enterprise plugins.

.. list-table:: Enterprise Version Requirements
    :header-rows: 1
    :widths: 7 20

    * - Enterprise Version
      - Required Graylog Version
    * - 1.0.x
      - >= 2.0.2, < 2.1.0

Installation
============

Once you `purchase a license for Graylog Enterprise <https://www.graylog.org/enterprise/order>`_,
you will get download links for the tarballs and DEB/RPM packages in the confirmation mail.

.. note:: The Graylog Enterprise plugins need to be installed on all your Graylog nodes!

Tarball
-------

The tarball includes the enterprise plugin JAR files.

::

  $ tar -tzf graylog-enterprise-plugins-1.0.0.tgz
  graylog-enterprise-plugins-1.0.0/plugin/graylog-plugin-archive-1.0.0.jar
  graylog-enterprise-plugins-1.0.0/plugin/graylog-plugin-license-1.0.0.jar

Depending on the Graylog setup method you have used, you have to install the plugins into different locations.

.. include:: /includes/plugin-installation-locations.rst

Also check the ``plugin_dir`` config option in your Graylog server configuration file. The default might have been changed.

Make sure to install the enterprise plugin JAR files alongside the other Graylog plugins.
Your plugin directory should look similar to this after installing the enterprise plugins.

::

  plugin/
  ├── graylog-plugin-archive-1.0.0.jar
  ├── graylog-plugin-collector-1.0.2.jar
  ├── graylog-plugin-enterprise-integration-1.0.2.jar
  ├── graylog-plugin-license-1.0.0.jar
  ├── graylog-plugin-map-widget-1.0.2.jar
  ├── graylog-plugin-pipeline-processor-1.0.0-beta.4.jar
  └── usage-statistics-2.0.2.jar


DEB / RPM Package
-----------------

We also provide DEB and RPM packages for the enterprise plugins.

.. note:: These packages can **only** be used when you installed Graylog via the :doc:`/pages/installation/operating_system_packages`!

DEB
~~~

Use the following command to install the plugins via dpkg.

::

  $ sudo dpkg -i graylog-enterprise-plugins-1.0.0.deb

RPM
~~~

Use the following command to install the plugins via rpm.

::

  $ sudo rpm -Uvh graylog-enterprise-plugins-1.0.0-1.noarch.rpm


Server Restart
==============

After you installed the Graylog Enterprise plugins you have to restart each of your Graylog servers
to load the plugins.

.. note:: We recommend restarting one server at a time!

You should see something like the following in your Graylog server logs. It indicates that the plugins have been successfully loaded.

::

  2016-05-30 12:06:34,606 INFO : org.graylog2.bootstrap.CmdLineTool - Loaded plugin: ArchivePlugin 1.0.0 [org.graylog.plugins.archive.ArchivePlugin]
  2016-05-30 12:06:34,607 INFO : org.graylog2.bootstrap.CmdLineTool - Loaded plugin: License Plugin 1.0.0 [org.graylog.plugins.license.LicensePlugin]

License Installation
====================

The Graylog Enterprise plugins require a valid license to use the additional features.

Once you have `purchased a license <https://www.graylog.org/enterprise/order>`_
you can import it into your Graylog setup by going through the following steps.

#. As an admin user, open the System/License page from the menu in the web interface.
#. Click the Import new license button in the top right hand corner.
#. Copy the license text from the confirmation email and paste it into the text field.
#. The license should be valid and a preview of your license details should appear below the text field.
#. Click Import to activate the license.

The license automatically applies to all nodes in your cluster without the need to restart your server nodes.

.. note:: If there are errors, please check that you copied the entire license from the email without line breaks.
          The same license is also attached as a text file in case it is wrongly formatted in the email.

.. image:: /images/enterprise-license-1.png
