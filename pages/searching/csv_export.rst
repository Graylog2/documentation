Export results as CSV
^^^^^^^^^^^^^^^^^^^^^
It is also possible to export the results of your search as a CSV document. To do so, click on the three dots on the right side of the search bar and select the *Export as CSV* option.

.. image:: /images/searching/csv_export.png
   :align: center

This will open a modal where you can choose the fields the CSV document should contain. You can also optionally specify a stream to filter the messages.
Clicking on *Downlaod* will create the file based on the specified options and start the download.

.. image:: /images/searching/csv_export_dialog.png
   :align: center

**Hint**: Some Graylog inputs keep the original message in the ``full_message`` field. If you need to export the original message, you
can do so by clicking on the *List all fields* link at the bottom of the sidebar, and then selecting the ``full_message`` field.

.. Warning:: Exporting results to a CSV will **not** preserve sorting because Graylog is using the virtual ``_doc`` field to "sort" documents for performance reasons. If you need to have the exported data ordered you will need to either make a `scroll query to ElasticSearch <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-request-scroll.html>`__ and process it after, or to download the file and post process it via other means.
