Time frame selector
-------------------

The time frame selector defines in what time range to search in. It offers three different ways of selecting a time range and
is vital for search speed: If you know you are only interested in messages of the last hour, only search in that time frame.
This will make Graylog search in :doc:`relevant indices </pages/configuration/index_model>` only and greatly reduce system load and required resources.

.. image:: /images/searching/queries_time_range_selector.png
   :align: center

.. _relative-time-frame-selector:

Relative time frame selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The relative time frame selector lets you look for messages from the selected option to the time you hit the search button. The selector
offers a wide set of relative time frames that fit most of your search needs.

Absolute time frame selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
When you know exactly the boundaries of your search, you want to use the absolute time frame selector. Simply introduce the dates and
times for the search manually or click in the input field to open up a calendar where you can choose the day with your mouse.

Keyword time frame selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Graylog offers a keyword time frame selector that allows you to specify the time frame for the search in natural language like *last hour* or *last 90 days*. The web interface shows a preview of the two actual timestamps that will be used for the search.

.. image:: /images/searching/queries_keyword_time_selector.png
   :align: center

Here are a few examples for possible values.

* "last month" searches between one month ago and now
* "4 hours ago" searches between four hours ago and now
* "1st of april to 2 days ago" searches between 1st of April and 2 days ago
* "yesterday midnight +0200 to today midnight +0200" searches between yesterday midnight and today midnight in timezone +0200 - will be 22:00 in UTC

The time frame is parsed using the `natty natural language parser <http://natty.joestelmach.com/>`_. Please consult its documentation for details.
