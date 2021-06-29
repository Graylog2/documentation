###############
Log View Widget
###############

********
Overview
********

Log View is a widget that presents your log data in a format similar to Common Log Format. 
In other terms, it has the look and feel of console output. In addition, the Log View widget 
allows you to scroll through log events and as it populates new lines in real-time.

Of course, the Log View widget will provide you a way to sleuth around your log events, to 
accomplish such actions as:

* recording faults to diagnose and debug
* identifying security breaches and other system and network misuses.
* auditing

When you build aggregations in the Log View widget expect it to help you to create highly 
customizable reports and infographics. Furthermore, you can add them to your dashboards. 
Also, you can save and retrieve them, in the the event you need to review that data again. 
At any time, you can add new values, fields, metrics to build reports that you need.

.. note::
    According to the section :ref:`csv_export`, Graylog Open Source is limited to exports in CSV.
    However, three additional formats are available in Enterprise: JSON, Newline delimited JSON, 
    and Plain Text form.  

Log View Usage
==============

To get familiar with Log View, perform the following actions.

* Create a new Log View widget.
* Expand your report with additional fields, in the widget.
* Focus on the widget with an expanded view.
* Export data from your widget.  

.. _create_log_view:

Create a Log View Widget
------------------------

The Log View Widget is located on the expandable bar, screen left. 

.. image:: /images/searching/log_view_left_menu.png

To create your first widget:

#. Click the *Create* (+) button to extend the menu.
#. Select Log View to generate the widget in the main UI.

.. image:: /images/searching/log_view_default.png

When the button generates a new widget, ``timestamp``, ``source``, and ``message`` are the default 
fields presented in plain text format.

.. _add_fields:

Add New Fields to the Report
----------------------------

To build more informed reports, you might add a new field to the widget. For example, you may
need to associate activity between ``company.org`` and an http response code.

.. image:: /images/searching/log_view_expand_arrow.png

#. Click the diagonal arrow icon on right side of a logline.
#. Review and select one or more options, e.g. ``http_response_code``.

.. image:: /images/searching/log_view_select_fields.png

Alternately, you can add new fields via the chevron icon (mentioned in ":ref:`widgets-aggregation`").

#. Click *Edit* from the menu.
#. Locate *FIELD SELECTION AND ORDER* on the bottom left.
#. Click the dropdown arrow, or type in a value.
#. Click *Add* to include the field in your widget.
#. Press the *Apply Changes* button to save all your edits. 

.. image:: /images/searching/log_view_field_selection_alternate.png


.. _widget_focus:

Focus on the Widget
-------------------

When you return to the main Log View UI, identify the x-crossed arrow icon next to the other widget icons.

.. image:: /images/searching/log_view_widget_focus_icon_cu.png

Click the icon to expand your widget to full view:

.. image:: /images/searching/log_view_widget_focus_UI.png


Build a Dashboard with Shareable Data
------------------------------------

In this section, you will determine a format that best suits your message delivery efforts, and download a report. 
For example, you might pass on:

* plain text data to your peers for analysis (i.e. *Log File/Plain Text*)
* data to a logging library built in JavaScript (i.e. *JSON*)
* structured data objects to TCP or UNIX pipes (i.e. *NDJSON*)

If still configured, you may use the dashboard created in :ref:`create_log_view`.

.. image:: /images/searching/log_view_export_chevron.png

Follow the steps

#. Click the chevron icon to access the *Actions* menu. (The icon is circled red in the image above.)
#. Choose *Export* from the menu to access the dialog.

    *  Output Format --- choose from JSON, Log File/Plain Text, NDJSON (Newline-delimited JSON), or CSV.
    *  Fields to export --- add additional fields to the pre-defined options chosen in :ref:`add_fields`.
    *  Time Range --- Click the clock icon to configure an Absolute date range. The format is displayed in yyyy-MMM-dd HH:mm:ss.SSS.
#. Click the *Start Download* button after choosing all necessary fields and optional *Messages limit*.