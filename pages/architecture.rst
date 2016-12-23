****************************
Architectural considerations
****************************

There are a few rules of thumb when scaling resources for Graylog:

* Graylog nodes should have a focus on CPU power. These also serve the user interface to the browser.
* Elasticsearch nodes should have as much RAM as possible and the fastest disks you can get.
  Everything depends on I/O speed here.
* MongoDB is storing meta information and configuration data and doesn't need many resources.

Also keep in mind that ingested messages are **only** stored in Elasticsearch. If you have data loss
in the Elasticsearch cluster, the messages are gone - except if you have created backups of the indices.


Minimum setup
-------------

This is a minimum Graylog setup that can be used for smaller, non-critical, or test setups.
None of the components is redundant but it is easy and quick to setup.

.. image:: /images/architec_small_setup.png

Our :ref:`Virtual Machine Appliances <virtual-machine-appliances>` are using this design by default, deploying nginx as :ref:`frontend proxy <configuring_webif_nginx>`.


.. _big_production_setup:

Bigger production setup
-----------------------

This is a setup for bigger production environments. It has several Graylog nodes behind a load balancer distributing the processing load.

The load balancer can ping the Graylog nodes via HTTP on the Graylog REST API to check if they are alive and take dead nodes out of the cluster.

.. image:: /images/architec_bigger_setup.png

How to plan and configure such a setup is covered in our :ref:`Multi-node Setup guide <configure_multinode>`.

Some guides on the `Graylog Marketplace <https://marketplace.graylog.org/>`__ also offer some ideas how you can use `RabbitMQ (AMQP) <https://marketplace.graylog.org/addons/246dc332-7da7-4016-b2f9-b00f722a8e79>`__ or `Apache Kafka <https://marketplace.graylog.org/addons/113fd1cb-f7d2-4176-b427-32831bd554ee>`__ to add some queueing to your setup.


Graylog Architecture Deep Dive
------------------------------

If you are really interested in the Graylog architecture at a more detailed level - whether you want to understand more for planning your architecture design, performance tuning, or just because you love stuff like that, our cheeky engineering team has put together this `deep architecture guide <http://www.slideshare.net/Graylog/graylog-engineering-design-your-architecture>`_.  It's not for the faint at heart, but we hope you love it.
