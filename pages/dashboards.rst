.. _dashboards:

**********
Dashboards
**********

Why dashboards matter
=====================

Using dashboards allows you to build pre-defined searches on your data to always have everything important
just one click away. 

Sometimes it takes domain knowledge to be able to figure out the search queries
to get the correct results for your specific applications. People with the required domain knowledge
can define the search queries once to share them with co-workers, managers, or even sales and marketing departments.

In comparision with saved searches, dashboards have a range of additional features included.
The main difference is the possibility to define different search criteria like the query or the time range for every widget.
Dashboards also support creating multiple tabs for different use cases, displaying the result in a full screen mode and as described sharing with other people.

This guide will take you through the process of creating dashboards and storing information on them.
At the end you will have a dashboard with automatically updating information that you can share with
anybody or just a subset of people based on permissions.

.. image:: /images/dashboard/dashboard_example.png
   :align: center

How to use dashboards
=====================

Creating an empty dashboard
---------------------------

Navigate to the *Dashboards* section using the link in the top menu bar of your Graylog web interface.
The page is listing all dashboards that you are allowed to view. (More on permissions later.) Hit the
*Create dashboard* button to create a new empty dashboard.

.. image:: /images/dashboard/dashboard_create.png
   :align: center

You should now see your new dashboard. Hit the *Save as* button on the right side of the search bar to save the dashboard. 

.. image:: /images/dashboard/dashboard_save.png
   :align: center

This will open a modal where you can define a title, summary and description.

.. image:: /images/dashboard/dashboard_save_dialog.png
   :align: center

The only required information is the *title* of the new dashboard. Use a specific
but not too long title so people can easily see what to expect on the dashboard. The description can be
a bit longer and could contain more detailed information about the displayed data or how it is collected.

Next, we will be adding widgets to the dashboard we have just created.

Adding widgets
--------------

You should have your empty dashboard in front of you. Let's add some widgets! You can add search result
information to dashboards with a couple of clicks. The following search result types can be added to
dashboards:

  * Message counts
  * Message table
  * Area chart
  * Bar chart
  * Data table
  * Heatmap
  * Line chart
  * Pie chart
  * Scatter possibility
  * Single number
  * World map

You can learn more about the different widget types in :ref:`widget_types`.

Once you can see the results of your search, you will see buttons with the "Add to dashboard" text, that
will allow you to select the dashboard where the widget will be displayed, and configure the widget.

Examples
========

It is strongly recommended to read the getting started guide on basic searches and analysis first. This
will make the following examples more obvious for you.

  * **Top log sources today**

    * Example search: ``*``, timeframe: Last 24 hours
    * Expand the ``source`` field in the sidebar and hit *Quick values*
    * Add quick values to dashboard

  * **Number of exceptions in a given app today**

    * Example search: ``source:myapp AND Exception``, timeframe: Last 24 hours
    * Add search result count to dashboard

  * **Response time chart of a given app**

    * Example search: ``source:myapp2``, any timeframe you want
    * Expand a field representing the response time of requests in the sidebar and hit *Generate chart*
    * Add chart to dashboard

Result
======

You should now see widgets on your dashboard. You will learn how to modify the dashboard, and edit widgets
in the next chapter.

.. image:: /images/dashboard/dashboard_example.png
   :align: center

.. _widget_types:

Widget cache times
==================

Widget values are cached in ``graylog-server`` by default. **This means that the cost of value computation
does not grow with every new device or even browser tab displaying a dashboard.** Some widgets might need
to show real-time information (set cache time to 1 second) and some widgets might be updated way less often
(like *Top SSH users this month*, cache time 10 minutes) to save expensive computation resources.

Dashboard permissions
=====================

Graylog users in the *Admin* role are always allowed to view and edit all dashboards. Users in the *Reader* role
are by default not allowed to view or edit **any** dashboard.

.. image:: /images/dashboard/dashboard_permissions.png

Navigate to *System* -> *Roles* and create a new role that grant the permissions you wish. You can then assign
that new role to any users you wish to give dashboard permissions in the *System* -> *Users* page.

You can read more about :doc:`user permissions and roles <users_and_roles>`.

That's it!
----------

Congratulations, you have just gone through the basic principles of Graylog dashboards. Now think about which dashboards
to create. We suggest:

 * Create dashboards for yourself and your team members
 * Create dashboards to share with your manager
 * Create dashboards to share with the CIO of your company

Think about which information you need access to frequently. What information could your manager or CIO be interested in?
Maybe they want to see how the number of exceptions went down or how your team utilized existing hardware better. The
sales team could be interested to see signup rates in realtime and the marketing team will love you for providing
insights into low level KPIs that is just a click away.
