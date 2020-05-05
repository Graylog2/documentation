Export results as CSV
^^^^^^^^^^^^^^^^^^^^^
It is also possible to export the results of your search as a CSV document. To do so, click on the three dots on the right side of the search bar and select the *Export to CSV* option.

.. image:: /images/searching/csv_export.png
   :align: center

This will open a modal where you can choose the fields the CSV document should contain. The initial fields are based on the message table configured for the search page.
It is also possible to define a limit. Because messages are loaded in chunks, all chunks up to the one where the limit is reached will be retrieved. Which means the total number of delivered messages can be higher than the defined limit.

Clicking on *Start Download* will create the file based on the specified options and start the download.

.. image:: /images/searching/csv_export_dialog_v2.png
   :align: center

When the search page or saved search contains multiple message tables, you can decide which message table you want to adopt the settings from. In this case you will see the following select when opening the CSV export modal:

.. image:: /images/searching/csv_export_widget_select.png
   :align: center

Additionally, you can select *Export to CSV* in a message table’s action menu, if you want to adopt its settings directly.

.. image:: /images/searching/csv_export_message_table_action_menu.png
   :align: center

Exporting search results on a dashboard
=======================================

The export on a dashboard is slightly different compared to the search page or saved searches. As described in the section :ref:`dashboards-widget-specific-criteria`, widgets on a dashboard have their own search criteria and the search parameters configured in a dashboard’s search bar only function as a filter. Just keep in mind you will always export the search result currently displayed by a message table. If you want to export only the search results the message table’s search criteria is referring to, make sure the dashboard’s filter is not defined.

Because the a dashboard filter does not contain all required search parameters, you will always have to select a message table when clicking on *Export to CSV* in a dashboard’s search bar.


Decorator support
=================

While the CSV export supports fields created by decorators, they are currently not being listed in the fields select options list. When you want to export a decorated field, enter its name in the field select and click on the option *Create field_name*. If you want to be sure a decorated field is available In the context of the current search, you can find a list of all active decorators in a message table’s edit modal.

**Hint**: Some Graylog inputs keep the original message in the ``full_message`` field. If you need to export the original message, you
can do so by clicking on the *List all fields* link at the bottom of the sidebar, and then selecting the ``full_message`` field.

.. Warning:: Exporting results to a CSV will **not** preserve sorting because Graylog is using the virtual ``_doc`` field to "sort" documents for performance reasons. If you need to have the exported data ordered you will need to either make a `scroll query to ElasticSearch <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-request-scroll.html>`__ and process it after, or to download the file and post process it via other means.
