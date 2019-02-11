.. _default_file_location:

**********************
Default file locations
**********************

Each installation flavor of Graylog will place the configuration files into a specific location on the local files system. The goal of this section is to provide a short overview about the most common and most important default file locations.


DEB package
===========

This paragraph covers Graylog installations on Ubuntu Linux, Debian Linux, and Debian derivates installed with the :ref:`DEB package <operating_package_DEB-APT>`.

.. _deb-graylog:
.. _scripts_dir:

Graylog
-------

+-----------------------+--------------------------------------+
|                       | File system path                     |
+=======================+======================================+
| Configuration         | ``/etc/graylog/server/server.conf``  |
+-----------------------+--------------------------------------+
| Logging configuration | ``/etc/graylog/server/log4j2.xml``   |
+-----------------------+--------------------------------------+
| Plugins               | ``/usr/share/graylog-server/plugin`` |
+-----------------------+--------------------------------------+
| Binaries              | ``/usr/share/graylog-server/bin``    |
+-----------------------+--------------------------------------+
| Scripts               | ``/usr/share/graylog-server/scripts``|
+-----------------------+--------------------------------------+
| JVM settings          | ``/etc/default/graylog-server``      |
+-----------------------+--------------------------------------+
| Message journal files | ``/var/lib/graylog-server/journal``  |
+-----------------------+--------------------------------------+
| Log Files             | ``/var/log/graylog-server/``         |
+-----------------------+--------------------------------------+


.. _deb-elasticsearch:

Elasticsearch
-------------

.. note:: These are only the most common file locations. Please refer to the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-dir-layout.html#default-paths>`__ for a comprehensive list of default file locations.

+---------------+---------------------------------------------+
|               | File system path                            |
+===============+=============================================+
| Configuration | ``/etc/elasticsearch``                      |
+---------------+---------------------------------------------+
| JVM settings  | ``/etc/default/elasticsearch``              |
+---------------+---------------------------------------------+
| Data files    | ``/var/lib/elasticsearch/data``             |
+---------------+---------------------------------------------+
| Log files     | ``/var/log/elasticsearch/``                 |
+---------------+---------------------------------------------+


.. _deb-mongodb:

MongoDB
-------

+---------------+-----------------------+
|               | File system path      |
+===============+=======================+
| Configuration | ``/etc/mongod.conf``  |
+---------------+-----------------------+
| Data files    | ``/var/lib/mongodb/`` |
+---------------+-----------------------+
| Log files     | ``/var/log/mongodb/`` |
+---------------+-----------------------+


RPM package
===========

This paragraph covers Graylog installations on Fedora Linux, Red Hat Enterprise Linux, CentOS Linux, and other Red Hat Linux derivates installed with the :ref:`RPM package <operating_package_rpm-yum-dnf>`.

.. _rpm-graylog:

Graylog
-------

+-----------------------+--------------------------------------+
|                       | File system path                     |
+=======================+======================================+
| Configuration         | ``/etc/graylog/server/server.conf``  |
+-----------------------+--------------------------------------+
| Logging configuration | ``/etc/graylog/server/log4j2.xml``   |
+-----------------------+--------------------------------------+
| Plugins               | ``/usr/share/graylog-server/plugin`` |
+-----------------------+--------------------------------------+
| Binaries              | ``/usr/share/graylog-server/bin``    |
+-----------------------+--------------------------------------+
| Scripts               | ``/usr/share/graylog-server/scripts``|
+-----------------------+--------------------------------------+
| JVM settings          | ``/etc/sysconfig/graylog-server``    |
+-----------------------+--------------------------------------+
| Message journal files | ``/var/lib/graylog-server/journal``  |
+-----------------------+--------------------------------------+
| Log Files             | ``/var/log/graylog-server/``         |
+-----------------------+--------------------------------------+


.. _rpm-elasticsearch:

Elasticsearch
-------------

.. note:: These are only the most common file locations. Please refer to the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-dir-layout.html#default-paths>`__ for a comprehensive list of default file locations.

+---------------+----------------------------------+
|               | File system path                 |
+===============+==================================+
| Configuration | ``/etc/elasticsearch``           |
+---------------+----------------------------------+
| JVM settings  | ``/etc/sysconfig/elasticsearch`` |
+---------------+----------------------------------+
| Data files    | ``/var/lib/elasticsearch/``      |
+---------------+----------------------------------+
| Log files     | ``/var/log/elasticsearch/``      |
+---------------+----------------------------------+


.. _rpm-mongodb:

MongoDB
-------

+---------------+-----------------------+
|               | File system path      |
+===============+=======================+
| Configuration | ``/etc/mongod.conf``  |
+---------------+-----------------------+
| Data files    | ``/var/lib/mongodb/`` |
+---------------+-----------------------+
| Log files     | ``/var/log/mongodb/`` |
+---------------+-----------------------+

