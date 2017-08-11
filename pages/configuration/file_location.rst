.. _default_file_location:

**********************
Default file locations
**********************

Each installation flavor of Graylog will place the configuration files into a specific location on the local files system. The goal of this section is to provide a short overview about the most common and most important default file locations.


DEB package
===========

This paragraph covers Graylog installations on Ubuntu Linux, Debian Linux, and Debian derivates installed with the :ref:`DEB package <operating_package_DEB-APT>`.

.. _deb-graylog:

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


Omnibus package
===============

This paragraph covers Graylog installations via OVA, on AWS (via AMI), and on OpenStack using the `Graylog Omnibus package <https://github.com/Graylog2/omnibus-graylog2#readme>`_.

.. _omnibus-graylog:

Graylog
-------

+-----------------------+---------------------------------------------------------+
|                       | File system path                                        |
+=======================+=========================================================+
| Configuration         | ``/opt/graylog/conf/graylog.conf``                      |
+-----------------------+---------------------------------------------------------+
| Logging configuration | ``/opt/graylog/conf/log4j2.xml``                        |
+-----------------------+---------------------------------------------------------+
| Plugins               | ``/opt/graylog/plugin``                                 |
+-----------------------+---------------------------------------------------------+
| JVM settings          | :ref:`/etc/graylog/graylog-settings.json <graylog-ctl>` |
+-----------------------+---------------------------------------------------------+
| Message journal files | ``/var/opt/graylog/data/journal``                       |
+-----------------------+---------------------------------------------------------+
| Log files             | ``/var/log/graylog/server/``                            |
+-----------------------+---------------------------------------------------------+


.. _omnibus-elasticsearch:

Elasticsearch
-------------

.. note:: These are only the most common file locations. Please refer to the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-dir-layout.html#default-paths>`__ for a comprehensive list of default file locations.

+---------------+---------------------------------------------------------+
|               | File system path                                        |
+===============+=========================================================+
| Configuration | ``/opt/graylog/conf/elasticsearch/``                    |
+---------------+---------------------------------------------------------+
| JVM settings  | :ref:`/etc/graylog/graylog-settings.json <graylog-ctl>` |
+---------------+---------------------------------------------------------+
| Data files    | ``/var/opt/graylog/data/elasticsearch``                 |
+---------------+---------------------------------------------------------+
| Log files     | ``/var/log/graylog/elasticsearch/``                     |
+---------------+---------------------------------------------------------+


.. _omnibus-mongodb:

MongoDB
-------

+---------------+---------------------------------------------------------+
|               | File system path                                        |
+===============+=========================================================+
| Configuration | :ref:`/etc/graylog/graylog-settings.json <graylog-ctl>` |
+---------------+---------------------------------------------------------+
| Data files    | ``/var/opt/graylog/data/mongodb``                       |
+---------------+---------------------------------------------------------+
| Log files     | ``/var/log/graylog/mongodb/``                           |
+---------------+---------------------------------------------------------+
