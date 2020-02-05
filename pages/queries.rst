.. _queries:

*********
Searching
*********

Search page
=====================
The search page is the heart of the Graylog. You can execute a query and visualize the search result with a variety of widgets. Any search can be saved or exported as dashboard.
Saved searches allow to easily reuse specific search configurations, while dashboards enable widget specific search queries and sharing with other users.
With 3.2 we have rewritten the search interface and unified the layout for the main search, saved searches and dashboards.

.. image:: /images/searching/search_page.png

Search query language
=====================

Syntax
^^^^^^

The search syntax is very close to the Lucene syntax. By default all message fields are included in the search if you don't specify a message
field to search in.

Messages that include the term *ssh*::

  ssh

Messages that include the term *ssh* or *login*::

  ssh login

Messages that include the exact phrase *ssh login*::

  "ssh login"

Messages where the field *type* includes *ssh*::

  type:ssh

Messages where the field *type* includes *ssh* or *login*::

  type:(ssh OR login)

.. note:: Elasticsearch 2.x and 5.x split queries on whitespace, so the query ``type:(ssh login)`` was equivalent to ``type:(ssh OR login)``.
  This is no longer the case in `Elasticsearch 6.0 <https://www.elastic.co/guide/en/elasticsearch/reference/6.6/breaking-changes-6.0.html#_changes_to_queries>`__
  and you must now include an ``OR`` operator between each term.

Messages where the field *type* includes the exact phrase *ssh login*::

  type:"ssh login"

Messages that have the field *type*::

  _exists_:type

Messages that do not have the field *type*::

  NOT _exists_:type

.. note:: Elasticsearch 2.x allows to use ``_missing_:type`` instead of ``NOT _exists_:type``. This query syntax has been removed in `Elasticsearch 5.0 <https://www.elastic.co/guide/en/elasticsearch/reference/5.0/breaking_50_search_changes.html#_deprecated_queries_removed>`__.

Messages that match regular expression ``ethernet[0-9]+``::

  /ethernet[0-9]+/

.. note:: Please refer to the Elasticsearch documentation about the `Regular expression syntax <https://www.elastic.co/guide/en/elasticsearch/reference/5.6/query-dsl-regexp-query.html#regexp-syntax>`_ for details about the supported regular expression dialect.


By default all terms or phrases are OR connected so all messages that have at least one hit are returned. You can use
**Boolean operators and groups** for control over this::

  "ssh login" AND source:example.org
  ("ssh login" AND (source:example.org OR source:another.example.org)) OR _exists_:always_find_me

You can also use the NOT operator::

  "ssh login" AND NOT source:example.org
  NOT example.org

**Note that AND, OR, and NOT are case sensitive and must be typed in all upper-case.**

**Wildcards:** Use `?` to replace a single character or `*` to replace zero or more characters::

  source:*.org
  source:exam?le.org
  source:exam?le.*

**Note that leading wildcards are disabled to avoid excessive memory consumption!** You can enable them in
your Graylog configuration file::

  allow_leading_wildcard_searches = true

Also note that ``message``, ``full_message``, and ``source`` are the only fields that are being analyzed by default.
While wildcard searches (using ``*`` and ``?``) work on all indexed fields, analyzed fields will behave a little bit different.
See `wildcard and regexp queries <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/_wildcard_and_regexp_queries.html>`_ for details.

**Fuzziness:** You can search for similar terms::

  ssh logni~
  source:exmaple.org~

This example is using the `Damerau–Levenshtein distance <http://en.wikipedia.org/wiki/Damerau-Levenshtein_distance>`_ with a default
distance of *2* and will match "ssh login" and "example.org" (intentionally misspelled in the query).

You can change the distance like this::

  source:exmaple.org~1

You can also use the fuzzyness operator to do a **proximity** search where the terms in a phrase can have different/fuzzy
distances from each other and don't have to be in the defined order::

  "foo bar"~5

Numeric fields support **range queries**. Ranges in square brackets are inclusive, curly brackets are exclusive and can
even be combined::

  http_response_code:[500 TO 504]
  http_response_code:{400 TO 404}
  bytes:{0 TO 64]
  http_response_code:[0 TO 64}

You can also do searches with one side unbounded::

  http_response_code:>400
  http_response_code:<400
  http_response_code:>=400
  http_response_code:<=400

It is also possible to combine unbounded range operators::

  http_response_code:(>=400 AND <500)

It is possible make a **range query** on the date field. It is important that the selected period of time at the timepicker fits the range you want to search in. If you search in the last 5 minutes, but the searched time is a week in the past the query will not return anything. The dates needs to be UTC and the format needs to be like Graylog displays them.::

  timestamp:["2019-07-23 09:53:08.175" TO "2019-07-23 09:53:08.575"]



Escaping
^^^^^^^^

The following characters must be escaped with a backslash::

  & | : \ / + - ! ( ) { } [ ] ^ " ~ * ?

Example::

  resource:\/posts\/45326

Time frame selector
===================

The time frame selector defines in what time range to search in. It offers three different ways of selecting a time range and
is vital for search speed: If you know you are only interested in messages of the last hour, only search in that time frame.
This will make Graylog search in :doc:`relevant indices <configuration/index_model>` only and greatly reduce system load and required resources.

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

Saved searches
==============
Sometimes you may want to search a specific search configuration to be used later. Graylog provides a saved search functionality
to accomplish exactly that.

Once you submitted your search, click on the *Save* button on the right side of the search bar.

.. image:: /images/searching/saved_search_create.png
   :align: center

Give a name to the current search and click on save. When you want to use the saved search later on, you only need to click on the *Load* button and select it from the list. You can also use the overview to delete a saved search.

.. image:: /images/searching/saved_search_load.png
   :align: center

Of course, you can always update your saved search. To do so, select it from the overview, change the search, e.g. by adding new fields for a message table, adding new widgets or defining a different search query and click on the *Save* button.
The open dialog allows changing the name and also contains a *Save as* button to create a new saved search without changing the original one.

.. image:: /images/searching/saved_search_update.png
   :align: center

Widgets
=======
A widget is either a Message Table or an Aggregation. It can be freely
placed inside a query. A widget can be edited or duplicated by clicking
on the chevron on the right side in the head of the widget.
Next to the chevron is a filter symbol, where filters can be added to the
top search query.

.. image:: /images/searching/views_widget.png
   :align: center

Aggregation
===========
The goal of an aggregation is to reduce the number of data points
in a meaningful way to get an answer from them. Data points can be
numeric field types in a message (e.g. a took_ms field which contains how
long a page needed to be rendered).
Or string values which can be used for grouping the aggregation
(e.g an action field which contains the name of the controller action).

Creating an aggregation
-----------------------
By clicking on `+ Create` -> `Custom Aggreatation` a new empty widget will
be shown on the very top of the Extended Search page.
A click on the chevron icon on the right side of the head will open the widget
in a modal in the edit mode.

.. image:: /images/searching/views_create_aggregation.png
   :align: center

:METRICS:
   **METRICS** are a collection of functions to aggregate data points.
   The result of the aggregation depends on the grouping of **ROWS** and/or
   **COLUMNS**. The data points of a field will be aggregated to the grouping.
   *Example* The ``avg()`` function will find the average of the
   numeric data points ``took_ms`` around the configured grouping. 

:ROWS/COLUMNS:
   Allows selecting fields whose values will be used to group results into
   new rows/columns. If the field is a ``timestamp`` for a row it will
   divide the data points into intervals. Otherwise the aggregation will take
   by default up to 15 elements of the selected field and apply the
   selected **METRICS** function to the data points.
   *Example* The ``timestamp`` field is aggregated with ``avg()`` on
   ``took_ms``. The column ``action`` will give the average loading
   time for a page per action for every 5 minutes.

:VISUALIZATION:
   To display the result of an aggregation it is often easier to
   compare lots of result values graphically. ``Bar Chart``,
   ``Data Table``, ``Line Chart``, ``Pie Chart``, ``Scatter Plot``,
   ``Single Number`` or ``World Map`` can be used as **VISUALIZATION**.
   The ``World Map`` needs geographical points in the form of ``latitude,longitude``.

:SORTING/DIRECTION:
   The order of the result values can be configured here. **SORTING** defines
   by which field the sorting should happen and **DIRECTION** configures
   if it will be ``ascending`` or ``descending``.


Message Table
=============

The Message Table displays the messages and their fields.
The Message Table can be configured to show the message fields and
the actual message. The actual message is rendered in a blue font,
below the fields.
Clicking on a message row opens the detailed view of a message with
all its fields.

.. image:: /images/searching/views_messages.png
   :align: center

Value and Field Actions
=======================
In the Sidebar and on Data Tables and Detail Message Rows are values and
fields visible. By clicking on a value or a field a context menu will be
shown where different actions can be executed.

Field actions
-------------
Based on the type of the field and where the menu is opened different
Field actions are shown when a field name (and not its value) is clicked.

.. image:: /images/searching/views_field_actions.png
   :align: center

:Chart:
   This will generate a new Widget containing a line chart where the fields
   average value is displayed over time. This chart can be taken as an
   starting point for a more defined aggregation. This is only possible
   on fields from a numerical type.
:Aggregate:
   This action will generate a new Widget containing a data table
   where the fields value are listed in the rows and the count
   of occurrence will be displayed next to it.
   This was formerly known as the "Quick Values" action.
:Statistics:
   Here the field values will be given to various statistics function
   depending on the type of the field. The result will be displayed
   in a Data Table Widget.
:Add to table:
   Add the field to the displayed fields of the message table where
   the Field Actions menu is shown.
:Add to all tables:
   Add the field to the displayed fields of all tables.
:Remove from table:
   Remove the field from the list displayed fields from this table.
:Remove from table:
   Remove the field from the list displayed fields from all tables.

Value actions
-------------
The value actions produce different results depending on the type of the
value and where the menu is opened. The following actions can be executed.

.. image:: /images/searching/views_value_actions.png
   :align: center

:Insert into view:
   This action will open up a modal where a view can be selected.
   A select-able list of Parameters will be shown from the selected
   view and after choosing a parameter a new browser tab will be
   opened containing the view with the value used in the parameter.
   This action is only available in enterprise Graylog.
:Exclude from results:
   Will add `NOT field:value` to the query to exclude all results
   where the field contains the value of the value action.
:Add to query:
   Will add `field:value` to the query to filter the results
   additionally for where the field has the value of the value action.
:Use in new query:
   Will open a new view tab with `field:value` as query string.
:Show documents for value:
   Available in Data Tables it will show the documents which
   where aggregated to display this value.
:Create extractor:
   For values of type string in Message Tables a short cut to create
   an extractor is given with this action.
:Highlight this value:
   This action will highlight this value for this field in all
   Message Tables and Data Tables.


.. _decorators:

Decorators
==========
Decorators allow you to alter message fields during search time automatically, while *preserving the unmodified message on disk*. Decorators
are specially useful to make some data in your fields more readable, combine data in some field, or add new fields with more information about
the message. As decorators are configured per stream (including the :ref:`default stream <default_stream>`), you are also able to present a
single message in different streams differently.

As changes made by decorators are not persisted, you cannot search for decorated values or use field analyzers on them. You can
still use those features in the original non-decorated fields.

Decorators are applied on a stream-level, and are shared among all users capable of accessing a stream, so all users can share the same results
and benefit from the advantages decorators add.

Graylog includes some message decorators out of the box, but you can add new ones from pipelines or by writing your own as plugins.

In order to apply decorators to your search results, click on the *Decorators* tab in your search sidebar, select the decorator you want
to apply from the dropdown, and click on *Apply*. Once you save your changes, the search results will already contain the decorated values.

.. image:: /images/create_decorator.png

When you apply multiple decorators to the same search results, you can change the order in which they are applied at any time by using
drag and drop in the decorator list.

.. _syslog_severity_mapper:

Syslog severity mapper
^^^^^^^^^^^^^^^^^^^^^^
The syslog severity mapper decorator lets you convert the numeric syslog level of syslog messages, to a human readable string. For example,
applying the decorator to the ``level`` field in your logs would convert the syslog level ``4`` to ``Warning (4)``.

To apply a syslog severity mapper decorator, you need to provide the following data:

* **Source field**: Field containing the numeric syslog level
* **Target field**: Field to store the human readable string. It can be the same one as the source field, if you wish to replace the numeric
  value on your search results

Format string
^^^^^^^^^^^^^
The format string decorator provides a simple way of combining several fields into one. It can also be used to modify the content of a field
in, without altering the stored result in Elasticsearch.

To apply a format string decorator you need to provide the following data:

* **Format string**: Pattern used to format the resulting string. You can provide fields in the message by enclosing them in ``${}``.
  E.g. ``${source}`` will add the contents of the ``source`` message field into the resulting string
* **Target field**: Field to store the resulting value
* **Require all fields** (optional): Check this box to only format the string when all other fields are present

For example, using the format string ``Request to ${controller}#${action} finished in ${took_ms}ms with code ${http_response_code}``, could
produce the text ``Request to PostsController#show finished in 57ms with code 200``, and make it visible in one of the message fields in
your search results.

Pipeline Decorator
^^^^^^^^^^^^^^^^^^
The pipeline decorator provides a way to decorate messages by processing them with an existing :doc:`processing pipeline <pipelines>`.
In contrast to using a processing pipeline, changes done to the message by the pipeline are not persisted. Instead, the pipeline is used at search time
to modify the *presentation* of the message.

The prerequisite of using the pipeline decorator is that an existing pipeline is required.

.. note:: Please take note, that the pipeline you use for decoration should not be connected to a stream. This would mean that it is run twice (during indexing *and* search time) for each message, effectively rendering the second run useless.

When you are done creating a pipeline, you can now add a decorator using it on any number of streams. In order to create one, you proceed just like for
any other decorator type, by clicking on the *Decorator* sidebar, selecting the type ("Pipeline Processor Decorator" in this case) and clicking the *Apply* button next to one.

.. image:: /images/pipeline_decorator_select_type.png

Upon clicking *Apply*, the pipeline to be used for decorating can be selected.

.. image:: /images/pipeline_decorator_select_pipeline.png

After selecting a pipeline and clicking *Save*, you are already set creating a new pipeline decorator.

Debugging decorators
^^^^^^^^^^^^^^^^^^^^

When a message is not decorated as expected, or you need to know how it looked like originally, you can see all changes that were done during decoration by clicking "Show changes" in the message details.

.. image:: /images/pipeline_decorator_show_changes.png

In this view, deleted content is shown in red, while added content is shown in green. This means that added fields will have a single green entry, removed fields a single red entry and modified fields will have two entries, a red and a green one.

Further functionality
^^^^^^^^^^^^^^^^^^^^^

If the existing decorators are not sufficient for your needs, you can either search the `Graylog marketplace <http://marketplace.graylog.org>`__, or :ref:`write your own decorator <writing_decorators>`.

Export results as CSV
=====================
It is also possible to export the results of your search as a CSV document. To do so, select all fields you want to export in the search
sidebar, click on the *More actions* button, and select *Export as CSV*.

.. image:: /images/export_as_csv.png

**Hint**: Some Graylog inputs keep the original message in the ``full_message`` field. If you need to export the original message, you
can do so by clicking on the *List all fields* link at the bottom of the sidebar, and then selecting the ``full_message`` field.

.. Warning:: Exporting results to a CSV will **not** preserve sorting because Graylog is using the virtual ``_doc`` field to "sort" documents for performance reasons. If you need to have the exported data ordered you will need to either make a `scroll query to ElasticSearch <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/search-request-scroll.html>`__ and process it after, or to download the file and post process it via other means.

Search result highlighting
==========================

Graylog supports search result highlighting since v0.20.2:

.. image:: /images/search_result_highlighting.png

Enabling/Disabling search result highlighting
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Using search result highlighting will result in slightly higher resource consumption of searches. You can enable and disable
it using a configuration parameter in the ``graylog.conf`` of your Graylog nodes::

  allow_highlighting = true


Search configuration
====================

Graylog allows customizing the options allowed to search queries, like limiting the time range users can select or configuring the list of displayed relative time ranges.

.. image:: /images/queries_search_configuration.png

All search configuration settings can be customized using the web interface on the *System* -> *Configurations* page in the *Search configuration* section.


Query time range limit
^^^^^^^^^^^^^^^^^^^^^^

Sometimes the amount of data stored in Graylog is quite big and spans a wide time range (e. g. multiple years). In order to prevent normal users from accidentally running search queries which could use up lots of resources, it is possible to limit the time range that users are allowed to search in.

Using this feature, the time range of a search query exceeding the configured query time range limit will automatically be adapted to the given limit.

.. image:: /images/queries_query_time_range_limit.png

.. _iso_8601_duration:

The query time range limit is a *duration* formatted according to ISO 8601 following the basic format ``P<date>T<time>`` with the following rules:

========== ===========
Designator Description
========== ===========
``P``      Duration designator (for period) placed at the start of the duration representation
``Y``      Year designator that follows the value for the number of years
``M``      Month designator that follows the value for the number of months
``W``      Week designator that follows the value for the number of weeks
``D``      Day designator that follows the value for the number of days
``T``      Time designator that precedes the time components of the representation
``H``      Hour designator that follows the value for the number of hours
``M``      Minute designator that follows the value for the number of minutes
``S``      Second designator that follows the value for the number of seconds
========== ===========

Examples:

================= ===========
ISO 8601 duration Description
================= ===========
``P30D``          30 days
``PT1H``          1 hour
``P1DT12H``       1 day and 12 hours
================= ===========

More details about the format of ISO 8601 durations can be found `on Wikipedia <https://en.wikipedia.org/wiki/ISO_8601#Durations>`_.


Relative time ranges
^^^^^^^^^^^^^^^^^^^^

The list of time ranges displayed in the :ref:`relative-time-frame-selector` can be configured, too. It consists of a list of :ref:`ISO 8601 <iso_8601_duration>` durations which the users can select on the search page.

.. image:: /images/queries_relative_timerange_options.png
