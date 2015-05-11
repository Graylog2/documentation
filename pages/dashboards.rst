**********
Dashboards
**********

Why dashboards matter
=====================

Using dashboards allows you to build pre-defined views on your data to always have everything important
just one click away.

Sometimes it takes domain knowledge to be able to figure out the search queries
to get the correct results for your specific applications. People with the required domain knowledge
can define the search query once and then display the results on a dashboard to share them with co-workers,
managers, or even sales and marketing departments.

This guide will take you through the process of creating dashboards and storing information on them.
At the end you will have a dashboard with automatically updating information that you can share with
anybody or just a subset of people based on permissions.

.. image:: /images/dashboards_1.png

How to use dashboards
=====================

Creating an empty dashboard
---------------------------

Navigate to the *Dashboards* section using the link in the top menu bar of your Graylog web interface.
The page is listing all dashboards that you are allowed to view. (More on permissions later.) Hit the
*Create dashboard* button to create a new empty dashboard.

The only required information is a *title* and a *description* of the new dashboard. Use a specific
but not too long title so people can easily see what to expect on the dashboard. The description can be
a bit longer and could contain more detailed information about the displayed data or how it is collected.

Hit the *Create* button to create the dashboard. You should now see your new dashboard on the dashboards
overview page. Click on the title of your new dashboard to see it. Next, we will be adding widgets to the
dashboard we have just created.

.. image:: /images/dashboards_2.jpg

Adding widgets
--------------

You should have your empty dashboard in front of you. Let's add some widgets! You can add search result
information to dashboards with just one click. The following search result types can be added to
dashboards:

  * Search result counts
  * Search result histogram charts
  * Field value charts
  * Quickvalue results
  
  Once you can see the results of your search, you will see a small blue icon next to the right of the 
  result count and histogram title. Hovering over this will show "Add to dashboard" and clicking the icon
  will prompt you with a list of dashboards you've created. Select a dashboard to add the widget to it.

Examples
========

It is strongly recommended to read the getting started guide on basic searches and analysis first. This
will make the following examples more obvious for you.

  * **Top log sources today**

    * Example search: ``*``, timeframe: Last 24 hours
    * Expand the ``source`` field in the the sidebar and hit *Quick values*
    * Add quick values to dashboard

  * **Number of exceptions in a given app today**

    * Example search: ``source:myapp AND Exception``, timeframe: Last 24 hours
    * Add search result count to dashboard

  * **Response time chart of a given app**

    * Example search: ``source:myapp2``, any timeframe you want
    * Expand a field representing the response time of requests in the sidebar and hit *Generate chart*
    * Add chart to dahsboard

Widgets from streams
====================

You can of course also add widgets from stream search results. Every widget added this way will always
be bound to streams. If you have a stream that contains every SSH login you can just search for everything
(``*``) in that stream and store the result count as *SSH logins* on a dashboard.

Result
------

You should now see widgets on your dashboard. You will learn how to modify the dashboard, change cache
times and widget positioning in the next chapter.

Modifying dashboards
====================

You need to *unlock* dashboards to make any changes to them. Hit the lock icon in the top right corner of a
dashboard to unlock it. You should now see new icons in the widget appearing.

Unlocked dashboard widgets explained
------------------------------------

Unlocked dashboard widgets have three buttons that should be pretty self-explanatory.

  * Delete widget
  * Change cache time of widget
  * Change title of widget

Widget cache times
------------------

Widget values are cached in ``graylog-server`` by default. **This means that the cost of value computation
does not grow with every new device or even browser tab displaying a dashboard.** Some widgets might need
to show real-time information (set cache time to 1 second) and some widgets might be updated way less often
(like *Top SSH users this month*, cache time 10 minutes) to save expensive computation resources.

Repositioning widgets
---------------------

Just grab a widget with your mouse in unlocked dashboard mode and move it around. Other widgets should
adopt and re-position intelligently to make place for the widget you are moving. The positions are
automatically saved when dropping a widget.

.. image:: /images/dashboards_6.jpg

Dashboard permissions
=====================

Graylog users with administrator permissions are always allowed to view and edit all dashboards. Users with *reader* permissions
are by default not allowed to view or edit **any** dashboard.

.. image:: /images/dashboards_8.png

Navigate to *System* -> *Users* and select a *reader* user you wish to give dashboard permissions. Hit the *edit* button
and assign dashboard *view* and *edit* permissions in the edit user dialogue. Don't forget to save the user!

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
