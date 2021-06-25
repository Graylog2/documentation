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

Log View Usage
==============

To get familiar with Log View, perform the following actions.

* Create a new Log View widget.
* Expand your report with additional fields, in the widget.
* Focus on the widget with an expanded view.
* Build a chart in the widget.
* Print a report in NDJSON, 

Create Log View Widget
----------------------

The Log View Widget is located on the expandable bar, screen left. 

.. image:: /images/searching/log_view_left_menu.png

To create your first widget:

#. Click the *Create* (+) button to extend the menu.
#. Select Log View to generate the widget in the main UI.

.. image:: /images/searching/log_view_default.png

When the button generates a new widget, ``timestamp``, ``source``, and ``message`` are the default 
fields presented in plain text format.

Add New Fields to the Report
-------------------------------------

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

When you return to the main Log View UI, identify a x-crossed arrow icon next to the other widget icons.

.. image:: /images/searching/log_view_widget_focus_icon_cu.png

Click the icon to expand your widget to full view:

.. image:: /images/searching/log_view_widget_focus_UI.png


Export Log View Data
--------------------



The Log View widget allows you to select a sample of a line, then copy it. 
You can paste the selection to your text editor or a file, with formatting identical to the Log View layout.