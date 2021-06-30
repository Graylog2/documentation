Time Frame Selector
-------------------

The Time Frame selector allows you to pull specific time ranges from your Graylog data. 
This feature will help you and other Graylog users analyze issues that affect multiple aspects 
of your environment. Most importantly, the tool offer multiple ways to filter time ranges 
you need for success.

.. image:: /images/searching/time_frame_selector_wide.png


To that end, the tool helps you to build queries that can help you perform such actions as:

* understanding and responding to data breaches, broken processes, and other security incidents
* troubleshoot systems and networks
* understand the behaviors of your users
* conducting forensics activities
  

Time Frame Options
^^^^^^^^^^^^^^^^^^
You can access the Selector from the Search menu.

To access the window, click the clock icon. A dialog pops up, offering the following ranges:

* *Relative*
* *Absolute*
* *Keyword*


Relative Time Frame Selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The *Relative* time frame selector lets you search for messages within time ranges relative to 
*Now* or another date of your choosing. This selector offers a wide set of relative time frames 
that fit most of your search needs, including an *All Time* option.

.. image:: /images/searching/relative_time_frame_revised.png

Consider how this filter works:

* The *From* field allows you to type in values and select units for time via a dropdown menu. 
  You can choose from seconds, minutes, hours, and days. For your convenience, you can click the *Preset Times* 
  button to access pre-detemined times, interpreted in minutes, hours, and days. If you decide to select all 
  messages instead, your dashboard would display data from the data of first ingestion.
  
* The *Until* date allows relative time ranges to end at a specific period instead of default to the current time/date.

Absolute time frame selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When you know precisely the boundaries of your search, use the absolute time frame selector. This filter 
provides an accordion to separate the Calendar from Timestamp inputs.

This option displays an accordion containing two options:

* *Calendar*
* *Timestamp*

In the Calendar option, use the hourglass icon to jump from the very beginning of the day (00:00:00.000) to 
the very end of the day (23:59:59.99).

To understand, Calender in more detail, consider the functions of *Until* and *From* on the Calendar option:

* *Until* defaults to disabling all dates previous to the selected *From* date
* *From* date will disable all previous dates if you configure a *Query Time Range Limit* (in the *System > Configurations* page)

.. image:: /images/searching/absolute_selector_calendar.png

You can use the magic wand icon for both Calendar and Timestamp.

* In *Calendar*, the icon updates the *Time* to the current time but does not modify the date in the calendar
* In *Timestamp*, the icon updates the entire *Timestamp* to the current date and time

.. image:: /images/searching/absolute_selector_timestamp.png


Keyword time frame selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Graylog offers a keyword time frame selector that allows you to specify the time frame for the search in natural 
language like *last hour* or *last 90 days*. The web interface shows a preview of the two actual timestamps that 
will be used for the search.

.. image:: /images/searching/keyword_selector.png
   :align: center

Here are a few examples for possible values.

* "last month" searches between one month ago and now
* "4 hours ago" searches between four hours ago and now
* "1st of april to 2 days ago" searches between 1st of April and 2 days ago
* "yesterday midnight +0200 to today midnight +0200" searches between yesterday midnight and today midnight in 
* timezone +0200 - will be 22:00 in UTC

The time frame is parsed using the `natty natural language parser <http://natty.joestelmach.com/>`_. Please consult its 
documentation for details.