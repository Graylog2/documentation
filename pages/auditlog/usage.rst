*****
Usage
*****

Once you installed the Audit Log plugin, Graylog will automatically write
audit log entries into the database.

View Audit Log Entries
======================

The plugin adds a new page to the web interface which can be reached via
"System/Audit Log". You can view and export existing audit log entries in
the database.

It also provides a simple search form to search and filter for audit events
you are interested in.

.. image:: /images/auditlog-view-entries-1.png

Expand Event Details
====================

Every row in the audit event entry table is clickable. Once clicked it will
reveal the details of the audit event.

All audit events have static fields like *actor*, *object* and others. In
addition to that, every event has some event specific fields.

The fields on the left side in the details are the static fields every event
has and the fields on the right side are the event specific fields.

.. image:: /images/auditlog-view-entries-2.png

Search & Filter
===============

To make it easier to get to the audit log entries you need, the audit log UI
provides a simple query language to search and filter the audit log entries.

You can either enter one or more words into the search field or choose to
look for some specific fields in the audit log entries.

.. list-table:: Available Fields
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - ``actor``
      - the user that triggered the audit event
    * - ``namespace``
      - the namespace of the audit event; might be different in plugins
    * - ``object``
      - the object of the audit event; what has been changed
    * - ``action``
      - name of the action that has been executed on the object
    * - ``success_status``
      - if the action failed or succeeded
    * - ``message``
      - the actual audit event message

Search for text in the message
------------------------------

If you just want to find some text in the audit event message, you can enter
the word you are looking for into the search bar

.. image:: /images/auditlog-search-entries-1.png

Search for specific fields
--------------------------

You can also filter the entries for specific fields like the ``actor``.

If you want to filter for all events triggered by the user *jane* you can
enter ``actor:jane`` into the search bar.

Maybe you want to filter for events for more than one actor. That can be done
by using either ``actor:jane,john`` or ``actor:jane actor:john``.

Or you want to find all audit events which have **not** been triggered by a
user. Add a ``-`` in front of the field name to negate the condition.
To show all events **except** those created by user *jane* you can add
``-actor:jane`` to the search field.

You can mix and match several field queries to find the entries you need. Here
are some more examples.

* ``actor:jane,john -namespace:server``
  get all events by users *jane* and *john* which are not in the *server*
  namespace
* ``index action:create`` get all events which have the word *index* in the
  event message and where the action is *create*
* ``message:index action:create`` same as above, just with an explicit field
  selector for the message field

.. image:: /images/auditlog-view-entries-3.png

Export Entries
==============

If the simple entry viewer is not enough, you can also export the result
of your query as JSON or CSV to further process it.

The "Export Results" button next to the search bar can be used to do that.

.. note:: The export from the UI is currently limited to the newest 10,000
          entries. Use the REST API if you need a bigger export.

Export via REST API
-------------------

If you want to backup the audit log entries or make them available to another
system, you can use the REST API to export them.


Example::

    # Export 20,000 audit log entries in JSON format
    curl -u admin:<admin-password> http://127.0.0.1:9000/api/plugins/org.graylog.plugins.auditlog/entries/export/json?limit=20000

    # Export 5,000 audit log entries with actor "jane" in CSV format
    curl -u admin:<admin-password> http://127.0.0.1:9000/api/plugins/org.graylog.plugins.auditlog/entries/export/csv?limit=5000&query=actor:jane

.. note:: Make sure the ``query`` parameter is properly escaped if it contains whitespace.
