**************************
Upgrading to Graylog 3.2.x
**************************

.. _upgrade-from-31-to-32:

.. contents:: Overview
   :depth: 3
   :backlinks: top


Configuration File Changes
--------------------------

The following alerting related configuration file settings changed in this release:

+----------------------------------------------------+---------+----------------------------------------------------+
| Setting                                            | Status  | Description                                        |
+====================================================+=========+====================================================+
| ``enabled_tls_protocols``                          | added   | Set system wide enabled TLS protocols              |
+----------------------------------------------------+---------+----------------------------------------------------+

See :ref:`server configuration page <server/.conf>` for details on the new settings.
