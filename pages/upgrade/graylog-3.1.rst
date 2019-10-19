**************************
Upgrading to Graylog 3.1.x
**************************

.. _upgrade-from-30-to-31:

.. contents:: Overview
   :depth: 3
   :backlinks: top

Views & Extended Search
=======================

The Views and Extended Search feature has been open-sourced in this version. (except the support for parameters) It was only accessible in Graylog Enterprise in Graylog 3.0.


HTTP API Changes
----------------

The following Views related HTTP API paths changed due to the migration to open source:

+--------------------------------------------------------+-----------------------+
| Old Path                                               | New Path              |
+========================================================+=======================+
| ``/api/plugins/org.graylog.plugins.enterprise/views``  | ``/api/views``        |
+--------------------------------------------------------+-----------------------+
| ``/api/plugins/org.graylog.plugins.enterprise/search`` | ``/api/views/search`` |
+--------------------------------------------------------+-----------------------+

Configuration File Changes
--------------------------

The following views related configuration file settings changed due to the migration to open source:

+------------------------------------------+------------------------------+
| Removed Setting                          | New Setting                  |
+==========================================+==============================+
| ``enterprise_search_maximum_search_age`` | ``views_maximum_search_age`` |
+------------------------------------------+------------------------------+


Alerts
======

The old Alerts system has been replaced by an Alerts & Events system in Graylog 3.1.

Existing alerts will be automatically migrated to the new system when the Graylog 3.1 server starts for the first time.
The migration will log the number of migrated legacy alert conditions and alarm callbacks::

    2019-08-05T10:36:06.404Z INFO  [V20190722150700_LegacyAlertConditionMigration] Migrated <2> legacy alert conditions and <2> legacy alarm callbacks

Alarm Callback Plugins
----------------------

The new Alerts & Events system is supporting the execution of legacy Alarm Callback plugins for now. We recommend to switch event definitions over to event notifications, though. At some point in the future support for legacy Alarm Callback plugins will be removed. More information for plugin developers can be found on the :ref:`event_notifications_api` page.

.. note:: Please note, that the data sent via a legacy Alarm Callback might be slightly different than via the old Alerts system. If you've built automation on top of alerts, you might want to check that everything still works after the migration.


Alert Condition Plugins
-----------------------

The new Alerts & Events system is *not* supporting the execution of legacy Alert Condition plugins. Old alerts using the internal alert conditions are automatically migrated to new event definitions. (message count, field value and field content value conditions) Custom alert condition plugins cannot be migrated and need to be rewritten as event definitions in the new system.

Deprecated HTTP API Endpoints
-----------------------------

The following HTTP API endpoints are deprecated and will be removed in a future release:

+------------------------------------------------------------------+
| Deprecated API Endpoints                                         |
+==================================================================+
| ``/api/streams/{streamid}/alerts/{alertId}/history``             |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/{alertId}/history``             |
+------------------------------------------------------------------+
| ``/api/alerts/callbacks``                                        |
+------------------------------------------------------------------+
| ``/api/alerts/callbacks/types``                                  |
+------------------------------------------------------------------+
| ``/api/alerts/callbacks/{alarmCallbackId}/test``                 |
+------------------------------------------------------------------+
| ``/api/alerts/conditions``                                       |
+------------------------------------------------------------------+
| ``/api/alerts/conditions/types``                                 |
+------------------------------------------------------------------+
| ``/api/streams/alerts``                                          |
+------------------------------------------------------------------+
| ``/api/streams/alerts/paginated``                                |
+------------------------------------------------------------------+
| ``/api/streams/alerts/{alertId}``                                |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alarmcallbacks``                       |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alarmcallbacks/available``             |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alarmcallbacks/alarmCallbackId``       |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/conditions``                    |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/conditions/test``               |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/conditions/{conditionId}``      |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/conditions/{conditionId}/test`` |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts``                               |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/check``                         |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/paginated``                     |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/receivers``                     |
+------------------------------------------------------------------+
| ``/api/streams/{streamid}/alerts/sendDummyAlert``                |
+------------------------------------------------------------------+

The deprecated API endpoints don't have a one to one mapping to new ones, but the following Endpoints can be used to manage
Event Definitions and Event Notifications as well as search for events:

+-------------------------------+
| New Events API Endpoints      |
+===============================+
| ``/api/events/definitions``   |
+-------------------------------+
| ``/api/events/entity_types``  |
+-------------------------------+
| ``/api/events/notifications`` |
+-------------------------------+
| ``/api/events/search``        |
+-------------------------------+

Configuration File Changes
--------------------------

The following alerting related configuration file settings changed in this release:

+----------------------------------------------------+---------+----------------------------------------------------+
| Setting                                            | Status  | Description                                        |
+====================================================+=========+====================================================+
| ``alert_check_interval``                           | removed | Was part of the old and now removed alerts system. |
+----------------------------------------------------+---------+----------------------------------------------------+
| ``processing_status_persist_interval``             | added   | Related to the new alerts system.                  |
+----------------------------------------------------+---------+----------------------------------------------------+
| ``processing_status_update_threshold``             | added   | Related to the new alerts system.                  |
+----------------------------------------------------+---------+----------------------------------------------------+
| ``processing_status_journal_write_rate_threshold`` | added   | Related to the new alerts system.                  |
+----------------------------------------------------+---------+----------------------------------------------------+
| ``default_events_index_prefix``                    | added   | Related to the new alerts system.                  |
+----------------------------------------------------+---------+----------------------------------------------------+
| ``default_system_events_index_prefix``             | added   | Related to the new alerts system.                  |
+----------------------------------------------------+---------+----------------------------------------------------+

See :ref:`server configuration page <server/.conf>` for details on the new settings.
