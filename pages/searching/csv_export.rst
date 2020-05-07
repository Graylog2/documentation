Export results as CSV
^^^^^^^^^^^^^^^^^^^^^
It is possible to export the results of your search as a CSV document. To do so, click on the three dots on the right side of the search bar and select the *Export to CSV* option.

.. image:: /images/searching/csv_export.png
   :align: center

This will open a modal where you can choose the fields the CSV document should contain. The initial fields are based on the message table configured for the search page.
It is also possible to define a limit. Because messages are loaded in chunks, all chunks up to the one where the limit is reached will be retrieved.
Which means the total number of delivered messages can be higher than the defined limit.

Clicking on *Start Download* will create the file based on the specified options and start the download.

.. image:: /images/searching/csv_export_dialog_v2.png
   :align: center

When the search page or saved search contains multiple message tables, you can decide which message table you want to adopt the settings from.
In this case you will see the following select when opening the CSV export modal:

.. image:: /images/searching/csv_export_widget_select.png
   :align: center

Additionally, you can select *Export to CSV* in a message table’s action menu, if you want to adopt its settings directly.

.. image:: /images/searching/csv_export_message_table_action_menu.png
   :align: center

Exporting Message Tables on a Dashboard
=======================================

The export on a dashboard is slightly different compared to the search page or saved searches.
Because dashboards do not have a single result set, you always need to select a message table when clicking on *Export to CSV* in a dashboard’s search bar action menu.
You can find more information on this topic in the section :ref:`dashboards-widget-specific-criteria`.

Even though a message table on dashboard has its own search criteria and the dashboard’s search bar only functions as a filter, you will always export the result set currently displayed by the message table.
If you want to export only the search results the message table’s search criteria is referring to, make sure the dashboard’s filter is not defined.

Decorator Support
=================

While the CSV export supports fields created by decorators, they are currently not being listed in the fields select options list.
When you want to export a decorated field, enter its name in the field select and click on the option *Create field_name*.
To ensure a decorated field is available in the context of the current search, open a message table's edit modal, by clicking on *Edit* in its context menu and find the decorators in the left sidebar.

Exporting the full message
==========================

If you want to export the original message, keep in mind some Graylog inputs store the original message in the ``full_message`` field.

.. Warning:: Exporting results to a CSV will **not** preserve sorting because Graylog is using the virtual ``_doc`` field to "sort" documents for performance reasons.
If you need to have the exported data ordered you will need to either make a `scroll query to ElasticSearch <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-request-scroll.html>`__ and
process it after, or to download the file and post process it via other means.