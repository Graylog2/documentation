.. _default_file_location:

**********************
Default file locations
**********************

As every possible way to install Graylog in your environment might confuse with the location of specific files, this page should give you a little help in this.


Graylog
=======

In the documentation and if you talk to someone references to the various configuration files or logfiles are given. This table should explain where you will find them.

+---------------------+---------------------------------------------------------+---------------------------------------------+
|                     | Omnibus (OVA / AWS / Openstack)                         | OS Package                                  |
+=====================+=========================================================+=============================================+
| graylog.conf /      | /opt/graylog/conf/graylog.conf                          | /etc/graylog/server/server.conf             |
| server.conf         |                                                         |                                             |
+---------------------+---------------------------------------------------------+---------------------------------------------+
|  logs               | /var/log/graylog/server/                                | /var/log/graylog-server/                    |
+---------------------+---------------------------------------------------------+---------------------------------------------+
|  plugins            | /opt/graylog/plugin                                     | /usr/share/graylog-server/plugin            |
+---------------------+---------------------------------------------------------+---------------------------------------------+
| log4j2.xml          | /opt/graylog/conf/log4j2.xml                            | /etc/graylog/server/log4j2.xml              |
| (logging)           |                                                         |                                             |
+---------------------+---------------------------------------------------------+---------------------------------------------+
| environment / heap  | :ref:`/etc/graylog/graylog-settings.json <graylog-ctl>` | * debian/ubuntu: /etc/default/graylog-server|
|                     |                                                         | * centos/RHEL: /etc/sysconfig/graylog-server|
+---------------------+---------------------------------------------------------+---------------------------------------------+

Elasticsearch
=============
In the `Elasticsearch documentation <https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-dir-layout.html#default-paths>`__ is very detailed described where to find each file. We will only name a few that are of interest in a Graylog setup.

+---------------------+---------------------------------------------------------+---------------------------------------------+
|                     | Omnibus (OVA / AWS / Openstack)                         | OS Package                                  |
+=====================+=========================================================+=============================================+
| configuration       | /opt/graylog/conf/elasticsearch/                        | /etc/elasticsearch                          |
+---------------------+---------------------------------------------------------+---------------------------------------------+
|  logs               | /var/log/graylog/elasticsearch/                         | /var/log/elasticsearch/                     |
+---------------------+---------------------------------------------------------+---------------------------------------------+
| environment / heap  | :ref:`/etc/graylog/graylog-settings.json <graylog-ctl>` | * debian/ubuntu: /etc/default/elasticsearch |
|                     |                                                         | * centos/RHEL: /etc/sysconfig/elasticsearch |
+---------------------+---------------------------------------------------------+---------------------------------------------+
