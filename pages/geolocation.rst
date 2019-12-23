.. _geolocation:

***********
Geolocation
***********

Graylog lets you extract and visualize geolocation information from IP addresses in your logs.
Here we will explain how to configure the geolocation resolution, and how to create a
map with the extracted geo-information.

.. _configure_geolocation:

Setup
=====
Graylog ships with geolocation capabilities by default but **some configuration is still required on your
side**. This section explains how to configure the functionality in detail.


On Graylog 3.0, the preferred way of configuring geolocation is by using
:doc:`Lookup Tables </pages/lookuptables>`, as it provides more flexibility
and is compatible with more database types. If you would rather use the old
Message Processor, please check the
`2.5 documentation </en/2.5/pages/geolocation.html#configure-the-database>`_.

.. note:: Before you get started, we recommend taking a look at some Lookup
   Table concepts in :ref:`the documentation <lookuptables>`.


Download the database
---------------------

In the first place, you need to download a geolocation database. The Lookup Table
Geo IP Data Adapter supports both **MaxMind City and Country databases** in
the **MaxMind DB format**, as the
`GeoIP2 Databases <https://www.maxmind.com/en/geoip2-databases>`_ or
`GeoLite2 Databases <https://dev.maxmind.com/geoip/geoip2/geolite2/>`_ that MaxMind provides.

The next step is to store the geolocation database on all servers running
Graylog. Make sure you grant the right permissions to the file so the user
running Graylog can read the database.

Note: As-of December 30, 2019, you will need to create an account to obtain a license key to download the database(s).
More information is available on `MaxMind's blog post <https://blog.maxmind.com/2019/12/18/significant-changes-to-accessing-and-using-geolite2-databases/>`_.


Configure Lookup Table
----------------------

The next step is to configure a Graylog Lookup Table that is able to use the
geolocation database. Follow the
:ref:`Lookup Tables setup documentation <lookuptables_setup>` to see what you
need to do. In most common cases you need to:

#. Create a Geo IP Data Adapter and point it to the location where you store
   the database. You can additionally test the Data Adapter to ensure it all
   works as expected.
#. Create a Cache (if needed) to make your lookups faster.
#. Create a Lookup Table that uses the Data Adapter and Cache you created in
   previous steps.


Use the Lookup Table
--------------------

Now you are almost ready to extract geolocation information from IP addresses.
All you need to do is to use the Lookup Table you created in the previous step
in a Extractor, Converter, Decorator or Pipeline Rule. Take a look at the
:ref:`Lookup Tables usage documentation <lookuptables_usage>` for more information.

.. note:: Make sure to read :ref:`message_processor_ordering`, specially if
   you will use the Lookup Table with a Pipeline, in order to better understand
   how Graylog will process messages.


Visualize geolocations in a map
===============================

Graylog can display maps from geolocation stored in any field, as long as the geo-points are using the
``latitude,longitude`` format. The default return value of the Geo IP Data Adapter
returns the coordinates in the right format, so you most likely don't need to do
anything special if you are using a Lookup Table for extracting geolocation
information.


Display a map in the search results page
----------------------------------------

On any search result page, you can expand the field you want to use to draw a map in the search sidebar, and 
click on the *World Map* link. That will show a map with all different points stored in that field.

.. image:: /images/geolocation_7.png


Add map to a dashboard
----------------------

You can add the map visualization into any dashboards as you do with other widgets. Once you displayed a map
in the search result page, click on *Add to dashboard*, and select the dashboard where you want to add the map.

.. image:: /images/geolocation_8.png
.. image:: /images/geolocation_9.png


FAQs
====

Will Graylog extract IPs from all fields?
-----------------------------------------
No, you can configure which fields you want to extract data from in the Pipeline
Rule or Extractor using the Lookup Table configured in the :ref:`setup section <configure_geolocation>`.

What geo-information is extracted from IPs?
-------------------------------------------
Depending on the database you use, the extracted information will be different.
By using a Pipeline Rule alongside a Lookup Table, you can extract any information
returned by the MaxMind Database for the IP in your logs.

Where is the extracted geo-information stored?
----------------------------------------------
Extracted geo-information is stored in message fields, which you can name as
you wish.

Which geo-points format does Graylog use to store coordinates?
--------------------------------------------------------------
Graylog returns the geolocation information in the ``latitude,longitude`` format.
The Map visualization also requires that format to be able to draw the coordinates
on a map.

I have a field in my messages with coordinates information already, can I use it in Graylog?
--------------------------------------------------------------------------------------------
Yes, you can display a map for coordinates as long as they are in the
``latitude,longitude`` format.

Not all fields containing IP addresses are resolved. Why does this happen?
--------------------------------------------------------------------------
Most likely it is a misconfiguration issue. It is easier to extract information
if **IP addresses are in their own field**. You should also make sure your
**Message Processors are in the right order** in the *Message Processors
Configuration*, as explained in :ref:`message_processor_ordering`.
