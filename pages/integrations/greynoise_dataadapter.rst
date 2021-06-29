.. _greynoise_dataadapter:

**********************
GreyNoise Data Adapter
**********************

The Greynoise Data adapter gets information about a given IP address. Returns time ranges, IP metadata
(network owner, ASN, reverse DNS pointer, country), associated actors, activity tags, and raw port scan and web
request information.

GreyNoise Open Source
---------------------

.. image:: /images/integrations/greynoise_dropdown.png
 :width: 600


The Greynoise open source version does an IP Quick Context lookup. For additional information on this, see the
`Greynoise IP Quick Context <https://developer.greynoise.io/reference/ip-lookup-1#quickcheck-1>`_  lookup page.

.. image:: /images/integrations/greynoise_config.png
 :width: 500


.. image:: /images/integrations/greynoise_result.png
 :width: 400


.. _greynoise__ent_dataadapter:

GreyNoise Lookup [Enterprise]
-----------------------------

.. attention:: This is a Graylog Enterprise feature and is only available since Graylog version 4.1. A valid Graylog Enterprise license is required.


The Greynoise enterprise version does a IP Context lookup. For additional information on this, see the
`Greynoise IP Context <https://developer.greynoise.io/reference/ip-lookup-1#noisecontextip-1>`_  lookup page.

.. image:: /images/integrations/greynoise_ent_config.png
 :width: 500

.. image:: /images/integrations/greynoise_ent_result.png
 :width: 400








