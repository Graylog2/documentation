****************************
Architectural considerations
****************************

There are a few rules of thumb when scaling resources for Graylog:

* ``graylog-server`` nodes should have a focus on CPU power. These also serve the user interface to the browser.
* Elasticsearch nodes should have as much RAM as possible and the fastest disks you can get.
  Everything depends on I/O speed here.
* MongoDB is only being used to store configuration and indexer failures, and can be
  sized fairly small.

Also keep in mind that messages are **only** stored in Elasticsearch. If you have data loss on
Elasticsearch, the messages are gone - except if you have created backups of the indices.

MongoDB is only storing meta information and configuration data.

Minimum setup
-------------

This is a minimum Graylog setup that can be used for smaller, non-critical, or test setups.
None of the components is redundant but it is easy and quick to setup.

.. image:: /images/simple_setup.png

Bigger production setup
-----------------------

This is a setup for bigger production environments. It has several ``graylog-server`` nodes behind
a load balancer that share the processing load. The load balancer can ping the ``graylog-server``
nodes via REST/HTTP to check if they are alive and take dead nodes out of the cluster.
This setup requires that one server is marked as the master via the ``is_master = true`` configuration. All nodes must also point to the same MongoDB instance via ``mongodb_uri``, which is usually the same as the master.

.. image:: /images/extended_setup.png

Graylog Architecture Deep Dive
------------------------------
If you are really interested in the Graylog architecture at a more detailed level - whether you want to understand more for planning your architecture design, performance tuning, or just because you love stuff like that, our cheeky engineering team has put together this `deep architecture guide <http://www.slideshare.net/Graylog/graylog-engineering-design-your-architecture>`_.  It's not for the faint at heart, but we hope you love it.
