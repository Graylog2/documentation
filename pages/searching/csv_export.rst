Export results as CSV
^^^^^^^^^^^^^^^^^^^^^
It is also possible to export the results of your search as a CSV document. To do so, select all fields you want to export in the search
sidebar, click on the *More actions* button, and select *Export as CSV*.

.. image:: /images/searching/export_as_csv.png

**Hint**: Some Graylog inputs keep the original message in the ``full_message`` field. If you need to export the original message, you
can do so by clicking on the *List all fields* link at the bottom of the sidebar, and then selecting the ``full_message`` field.

.. Warning:: Exporting results to a CSV will **not** preserve sorting because Graylog is using the virtual ``_doc`` field to "sort" documents for performance reasons. If you need to have the exported data ordered you will need to either make a `scroll query to ElasticSearch <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-request-scroll.html>`__ and process it after, or to download the file and post process it via other means.
