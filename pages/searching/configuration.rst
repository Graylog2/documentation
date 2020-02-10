Search configuration
--------------------

Graylog allows customizing the options allowed to search queries, like limiting the time range users can select or configuring the list of displayed relative time ranges.

.. image:: /images/searching/queries_search_configuration.png

All search configuration settings can be customized using the web interface on the *System* -> *Configurations* page in the *Search configuration* section.


Query time range limit
^^^^^^^^^^^^^^^^^^^^^^

Sometimes the amount of data stored in Graylog is quite big and spans a wide time range (e. g. multiple years). In order to prevent daily users from accidentally running search queries which could use up lots of resources, it is possible to limit the time range that users are allowed to search in.

Using this feature, the time range of a search query exceeding the configured query time range limit will automatically be adapted to the given limit.

.. image:: /images/searching/queries_query_time_range_limit.png

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

More details about the format of ISO 8601 durations can be found `here <https://www.iso.org/obp/ui#iso:std:iso:8601:-1:ed-1:v1:en>`_.


Relative time ranges
^^^^^^^^^^^^^^^^^^^^

The list of time ranges displayed in the :ref:`relative-time-frame-selector` can be configured, too. It consists of a list of :ref:`ISO 8601 <iso_8601_duration>` durations which the users can select on the search page.

.. image:: /images/searching/queries_relative_timerange_options.png
