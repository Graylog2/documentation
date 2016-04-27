.. _geolocation:

***********
Geolocation
***********

Graylog lets you extract and visualize geolocation information from IP addresses in your logs.
Here we will explain how to install and configure the geolocation resolution, and how to create a
map with those geolocation.

Setup
=====
The `Graylog Map Widget <https://github.com/Graylog2/graylog-plugin-map-widget>`_ is the plugin
providing geolocation capabilities to Graylog. The plugin is compatible with Graylog 2.0.0 and
higher, and it is installed by default, although **some configuration is still required on your
side**. This section explains how to configure the plugin in detail.

In case you need to reinstall the plugin for some reason, you can find it inside the Graylog
tarball in our `downloads page <https://www.graylog.org/download/>`_. Follow the instructions in
:ref:`installing_and_loading_plugins` to install it.


.. _configure_geolocation:

Configure the database
----------------------

In first place, you need to download a geolocation database. We currently support **MaxMind City
databases** in the **MaxMind DB format**, as the
`GeoIP2 City Database <https://www.maxmind.com/en/geoip2-city>`_ or
`GeoLite2 City Database <https://dev.maxmind.com/geoip/geoip2/geolite2/>`_ that MaxMind provides.

The next step is to store the geolocation database in all servers running Graylog. As an example, if you
were using the Graylog OVA, you could save the database in the ``/var/opt/graylog/data`` folder, along
with other data used by Graylog. Make sure you grant the right permissions so the user running Graylog
can read the file.

Then you need to configure Graylog to start using the geolocation database to resolve IPs in your logs.
To do that, open Graylog web interface in your favourite browser, and go to *System -> Configurations*.
You can find the geolocation configuration under the *Plugins / Geo-Location Processor* section, as seen
in the screenshot.

.. image:: /images/geolocation_1.png

In the configuration modal, you need to check the `Enable geolocation processor`, and enter the path to
the geolocation database you use. Once you are all set, click on save to store the configuration changes.

.. image:: /images/geolocation_2.png


.. _configure_message_processor:

Configure the message processor
-------------------------------

The last step before being able to resolve locations from IPs in your logs, is to activate the GeoIP Resolver
processor. In the same *System -> Configurations* page, update the configuration in the *Message Processors
Configuration* section.

.. image:: /images/geolocation_3.png

In that screen, you need to **enable the GeoIP Resolver**, and you must also **set the GeopIP Resolver as
the last message processor to run**, if you want to be able to resolve geolocation from fields coming from
extractors.

.. image:: /images/geolocation_4.png


That's it, at this point Graylog will start looking for fields **containing exclusively** an IPv4 or IPv6
address, and extracting their geolocation into a ``<field>_geolocation`` field.

**Note**: In case you are not sending structured logs to Graylog, you can use extractors to store the IPs
in your messages into their own fields. Check out the :ref:`extractors` documentation for more information.


Verify the geolocation configuration (Optional)
-----------------------------------------------

To ensure the geolocation resolution is working as expected, you can do the following:

1. Create a TCP Raw/Plaintext input:

.. image:: /images/geolocation_5.png

2. Send a message only containing an IP to the newly created input. As an example, we will be using the `nc` command:
``nc -w0 <graylog_host> 5555 <<< '8.8.8.8'``

3. Verify that the message contains a ``message_geolocation`` field:

.. image:: /images/geolocation_6.png

4. Delete the input if you don't need it any more

In case the message does not contain a ``message_geolocation`` field, please check your Graylog server logs, and
ensure you followed the steps in the :ref:`configure_geolocation` section.


Visualize geolocations in a map
===============================

Graylog can display maps from geolocation stored in any field, as long as the geo-points are using the
``latitude,longitude`` format.


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
Yes, as long as they contain exclusively an IP address.

Where are the extracted geolocations stored?
--------------------------------------------
Extracted geolocations are stored in a new field, named as the original field, with ``_geolocation``
appended to it. That is, if the original field was called ``ip_address``, the extracted geolocation will be
stored in the ``ip_address_geolocation`` field.

Which geo-points format does Graylog use to store geolocation information?
--------------------------------------------------------------------------
Graylog stores the geolocation information in the ``latitude,longitude`` format.

I have a field in my messages with geolocation information already, can I use it in Graylog?
--------------------------------------------------------------------------------------------
Yes, as long as it contains geolocation information in the ``latitude,longitude`` format.

Not all fields containing IP addresses are resolved. Why does this happen?
--------------------------------------------------------------------------
Most likely it is a misconfiguration issue. Please ensure that **the IPs you want to get geolocation
information from are in their own fields**, and also ensure that **the GeoIP Resolver is enabled, and in the
right order** in the *Message Processors Configuration*, as explained in :ref:`configure_message_processor`.
