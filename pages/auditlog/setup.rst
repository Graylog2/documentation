*****
Setup
*****

The Audit Log plugin is a commercial Graylog feature that can be installed in
addition to the Graylog open source server.

Installation
============

Please see the :ref:`Graylog Enterprise setup page <enterprise-setup>` for details on how to install
the Audit Log plugin.

.. note:: Make sure the Audit Log plugin is installed on every node in your Graylog cluster.

Configuration
=============

The audit log plugin provides two ways of writing audit log entries:

1. Database
2. Log file via `log4j2 <https://logging.apache.org/log4j/2.x/>`_ appender

Logging to the database is always enabled and cannot be disabled.

.. note:: All configuration needs to be done in the Graylog server configuration file
          **and** in the logging configuration. (only if the log4j2 appender is enabled)
          Check the :ref:`default file locations page <default_file_location>` for details.

The web interface can show the current configuration.

.. image:: /images/auditlog-setup-config.png

Database Configuration Options
------------------------------

The default MongoDB audit log has a few configuration options available.

.. list-table:: Configuration Options
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - ``auditlog_mongodb_keep_entries``
      - delete audit log entries older that configured interval
    * - ``auditlog_mongodb_cleanup_interval``
      - interval of the audit log entry cleanup job
    * - ``auditlog_mongodb_collection``
      - the MongoDB collection to store the audit log entries in

.. _auditlog-config-option-mongodb-keep-entries:

auditlog_mongodb_keep_entries
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This configures the interval after which old audit log entries in the MongoDB
database will be deleted. You have to use values like ``90d`` (90 days) to
configure the interval.

.. warning:: Make sure to configure this to fit your needs. Deleted audit log entries are gone forever!

The default value for this is ``365d``.

Example::

    auditlog_mongodb_keep_entries = 365d

.. _auditlog-config-option-mongodb-cleanup-interval:

auditlog_mongodb_cleanup_interval
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This configures the interval of the  background job that periodically deletes
old audit log entries from the MongoDB database. You have to use values like
``1h`` (1 hour) to configure the interval.

The default value for this is ``1h``.

Example::

    auditlog_mongodb_cleanup_interval = 1h

.. _auditlog-config-option-mongodb-collection:

auditlog_mongodb_collection
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This configures the name of the MongoDB collection where the audit log plugin#
stores the audit log entries.

The default value for this is ``audit_log``.

Example::

    auditlog_mongodb_collection = audit_log

Log4j2 Configuration Options
----------------------------

The optional log4j2 audit log appender has a few configuration options available.

.. note:: To configure the log4j2 appender you have to edit the Graylog server configuration file **and** the log4j2.xml file for your setup!

.. list-table:: Configuration Options
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - ``auditlog_log4j_enabled``
      - whether the log4j2 appender is enabled or not
    * - ``auditlog_log4j_logger_name``
      - log4j2 logger name
    * - ``auditlog_log4j_marker_name``
      - log4j2 marker name

.. _auditlog-config-option-log4j2-enabled:

auditlog_log4j_enabled
^^^^^^^^^^^^^^^^^^^^^^

The log4j2 audit log appender is disabled by default and can be enabled by
setting this option to ``true``.

The default value for this is ``false``.

Example::

    auditlog_log4j_enabled = true

.. _auditlog-config-option-log4j2-logger-name:

auditlog_log4j_logger_name
^^^^^^^^^^^^^^^^^^^^^^^^^^

This configures the log4j2 logger name of the audit log.

The default value for this is ``gl-org.graylog.plugins.auditlog``.

Example::

    auditlog_log4j_logger_name = graylog-auditlog

.. _auditlog-config-option-log4j2-marker-name:

auditlog_log4j_marker_name
^^^^^^^^^^^^^^^^^^^^^^^^^^

This configures the `log4j2 marker name <https://logging.apache.org/log4j/2.0/manual/markers.html>`_
for the audit log.

The default value for this is ``AUDIT_LOG``.

Example::

    auditlog_log4j_marker_name = AUDIT_LOG

Log4j2 Appender Configuration
-----------------------------

To write audit log entries into a file you have to enable the log4j2 appender
in your Graylog configuration file **and** add some configuration to the
``log4j2.xml`` file that is used by your server process.

The ``log4j2.xml`` file location is dependent on your deployment method.
so please check the :ref:`default file locations page <default_file_location>`.

An existing ``log4j2.xml`` config file needs another ``<Logger/>`` statement
in the ``<Loggers/>`` section and an additional appender in the ``<Appenders/>``
section of the file.

.. warning:: The file on your system might look different than the following example. Make sure to only add the audit log related snippets to your config and do not remove anything else!

Example ``log4j2.xml`` file with audit log enabled::

    <?xml version="1.0" encoding="UTF-8"?>
    <Configuration packages="org.graylog2.log4j" shutdownHook="disable">
        <Appenders>
            <!-- Graylog server log file appender -->
            <RollingFile name="rolling-file" fileName="/var/log/graylog-server/server.log" filePattern="/var/log/graylog-server/server.log.%i.gz">
                <PatternLayout pattern="%d{yyyy-MM-dd'T'HH:mm:ss.SSSXXX} %-5p [%c{1}] %m%n"/>
                <Policies>
                    <SizeBasedTriggeringPolicy size="50MB"/>
                </Policies>
                <DefaultRolloverStrategy max="10" fileIndex="min"/>
            </RollingFile>

            <!-- ##################################################### -->
            <!-- Rotate audit logs daily -->
            <RollingFile name="AUDITLOG" fileName="/var/log/graylog-server/audit.log" filePattern="/var/log/graylog-server/audit-%d{yyyy-MM-dd}.log.gz">
                <PatternLayout>
                    <Pattern>%d - %m - %X%n</Pattern>
                </PatternLayout>
                <Policies>
                    <TimeBasedTriggeringPolicy />
                </Policies>
            </RollingFile>
            <!-- ##################################################### -->
        </Appenders>
        <Loggers>
            <Logger name="org.graylog2" level="info"/>

            <!-- ##################################################### -->
            <!-- Graylog Audit Log.  The logger name has to match the "auditlog_log4j_logger_name" setting in the Graylog configuration file -->
            <Logger name="graylog-auditlog" level="info" additivity="false">
                <AppenderRef ref="AUDITLOG"/>
            </Logger>
            <!-- ##################################################### -->

            <Root level="warn">
                <AppenderRef ref="rolling-file"/>
            </Root>
        </Loggers>
    </Configuration>

The config snippets between the ``<!-- ######### -->`` tags have been added
to the existing ``log4j2.xml`` file.

Make sure that the ``name`` in the ``<Logger />`` tag matches the configured
``auditlog_log4j_logger_name`` in your Graylog server configuration. Otherwise
you will not see any log entries in the log file.

Caveats
^^^^^^^

You have to make sure that the log4j2 related settings in the Graylog server
config file and the ``log4j2.xml`` file are the same on **every node in your cluster**!

Since every Graylog server writes its own audit log entries when the plugin
is installed, the log files configured in the ``log4j2.xml`` file are written
on every node. But **only** the entries from the local node will show up in
that file.

If you have more than one node, you have to search in all configured files
on all nodes to get a complete view of the audit trail.
