.. _extended_search:

***************
Extended Search
***************

Views
=====
A views contains a set of queries. Each query has a collection of widgets
which display messages and charts depending on the search string entered
in the search bar and the selected time range. A view can be saved with
a name and that way reused and enhanced later on. For a better work
flow Parameters can be added in the search query. Parameters are part of
the Graylog Enterprise plugin.

.. image:: /images/views_1.png

Widgets
=======
A widget is either a Message Table or an Aggregation. It can be freely
placed inside a query. A widget can be edited or duplicated by clicking
on the chevron on the right side in the head of the widget.
Beside the chevron is a filter symbol, where filters can be add to the
top search query.

.. image:: /images/views_widget.png

Aggregation
===========
The goal of an aggregation is to reduce the number of data points
in a meaningful way to get an answer of them. Data points can be
numeric field types in a message (e.g. the took_ms field which contains how
long a page needed to be rendered).
Or string values which can be used for grouping the aggregation
(e.g the action field which contains the name of the controller action).

Creating an aggregation
-----------------------
By clicking on `+ Create` -> `Custom Aggreatation` a new empty widget will
be shown on the very top of the Extended Search page.
A click on the chevron icon on the right side of the head will open the widget
in a modal in the edit mode.

.. image:: /images/views_create_aggregation.png

:METRICS:
   **METRICS** are a collection of functions to aggregate data points.
   The result of the aggregation depends on the grouping of **ROWS** and/or
   **COLUMNS**. The data points of a field will be aggregated to the grouping.
   *Example* The ``avg()`` function will find the average of the
   numeric data points ``took_ms`` around the configured grouping. 

:ROWS/COLUMNS:
   Here can the fields be selected, where the aggregation will apply the
   **METRICS** function. If the field is a ``timestamp`` for a row it will
   divided the data points in to intervals. Otherwise the aggregation will take
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
   The ``World Map`` needs geographical points inform of ``latitude,longitude``.

:SORTING/DIRECTION:
   The order of the result values can be configured here. **SORTING** defines
   by which field the sorting should happen and **DIRECTION** configures
   if it will be ``ascending`` or ``descending``.

Message Table
=============

The Message Table displays the messages and their fields.
The Message Table can be configured to show the messages field and
the actual message. The actual message is rendered in a blue font,
below the fields.
Clicking on a message row opens the detailed view of a message with
all its fields.

.. image:: /images/views_messages.png

Value and Field Actions
=======================
In the Sidebar and on Data Tables and Detail Message Rows are values and
fields visible. By clicking on a value or a field a context menu will be
shown where different actions can be executed.
