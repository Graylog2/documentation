.. _queries:

*********
Searching
*********

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

.. image:: /images/queries_time_range_selector.png

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

.. image:: /images/queries_keyword_time_selector.png

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

Once you submitted your search, selected the fields you want to show from the search sidebar, and chosen a resolution for the histogram, click on
the *Save search criteria* button on the sidebar.

.. image:: /images/saved_search_create.png

Give a name to the current search and click on save. When you want to use the saved search later on, you only need to select it from the saved search
selector.

.. image:: /images/saved_search_selector.png

Of course, you can always update the selected fields or name of your saved search. To do so, select the saved search from the saved search selector,
update the field selection or histogram resolution, and click on *Saved search* -> *Update search criteria*. It is also possible to delete the saved
search by selecting *Saved search* -> *Delete saved search*.

.. image:: /images/saved_search_update.png

Histogram
=========
The search page includes a search result histogram, where you can view in a concise way the number of messages received grouped by a certain time period that Graylog will adjust for you.

The histogram also allows you to further narrow down the cause for an issue:

- Delimit the search time range by brushing over the histogram. Just click and drag with your mouse over the chart to select the time range you want to use, and click on the search button to perform that search
- See the time where alerts are triggered in the graph annotations. If you are searching in a stream, you will only see alerts related to that stream

.. image:: /images/search_histogram.png

Analysis
========
Graylog provides several tools to analyze your search results. It is possible to save these analysis into dashboards, so you can check them over
time in a more convenient way. To analyze a field from your search results, expand the field in the search sidebar and click on the button of the
analysis you want to perform.

.. image:: /images/search_analysis.png


.. _field_statistics:

Field statistics
^^^^^^^^^^^^^^^^
Compute different statistics on your fields, to help you better summarize and understand the data in them.

The statistical information consist of: total, mean, minimum, maximum, standard deviation, variance, sum, and cardinality. On non-numeric fields,
you can only see the total amount of messages containing that field, and the cardinality of the field, i.e. the number of unique values it has.

.. image:: /images/field_statistics.png


.. _quick_values:

Quick values
^^^^^^^^^^^^
Quick values helps you to find out the distribution of values for a field. Alongside a graphic representation of the common values contained
in a field, Graylog will display a table with all different values, allowing you to see the number of times they appear. You can include any value
in your search query by clicking on the magnifying glass icon located in the value row.

.. image:: /images/quick_values.png


.. _field_graphs:

Field graphs
^^^^^^^^^^^^
You can create field graphs for any numeric field, by clicking on the *Generate chart* button in the search sidebar. Using the options in the
*Customize* menu on top of the field graph, you can change the statistical function used in the graph, the kind of graph to use to represent
the values, the graph interpolation, as well as the time resolution.

.. image:: /images/field_graph.png

Once you have customized some field graphs, you can also combine them by dragging them from the hamburger icon on the top corner of the graph,
and dropping them into another field graph. You can see the location of the hamburger icon and the end result in the following screenshots:

.. image:: /images/stacked_graph_1.png
.. image:: /images/stacked_graph_2.png

Field graphs appear every time you perform a search, allowing you to compare data, or combine graphs coming from different streams.

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
