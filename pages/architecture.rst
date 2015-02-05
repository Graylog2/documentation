****************************
Architectural considerations
****************************

There are a few rules of thumb when scaling resources for Graylog:

* ``graylog-server`` nodes should have a focus on CPU power
* Elasticsearch nodes should have as much RAM as possible and the fastest disks you can get.
  Everything depends on IO speed here.
* MongoDB nodes will never experience much load and can be sized fairly small
* ``graylog-web-interface`` nodes are mostly waiting for HTTP answers of the rest of the system
  and can also be rather small
* ``graylog-radio`` nodes act as workers. They don't know each other and you can shut them down
  at any point in time without changing the cluster state at all.

Also keep in mind that messages are **only** stored in Elasticsearch. If you have data loss on
Elasticsearch, the messages are gone. (except if you have backups of course)

MongoDB is only storing meta information and will be abstracted with a general database layer
in future versions. This will allow you to use other databases like MySQL instead.

Minimum setup
-------------

This is a minimum Graylog setup that can be used for smaller, non-critical or test setups.
Nothing is redundant but it is easy and quick to setup.

.. image:: /images/simple_setup.png

Bigger production setup
-----------------------

This is a setup for bigger production environments. It has several ``graylog-server`` nodes behind
a load balancer that share the load. The load balancer can ping the ``graylog-server`` nodes via
REST/HTTP to check if they are alive and take dead nodes out of the cluster.

.. image:: /images/extended_setup.png

Highly available setup with Graylog Radio
------------------------------------------

This is a big setup that allows to shut down or lose big parts of the system without losing
messages. The messages are written to ``graylog-radio`` nodes behind a load balancer. Radio
nodes are configured from the web interface and write the received messages to a Kafka
cluster (AMQP is supported, too).

.. image:: /images/big_radio_setup.png

The ``graylog-server`` nodes read messages from the Kafka cluster and distribute the load
automatically and very even. Messages just queue up on the Kafka broker disks until they
are read if no ``graylog-server`` node is running or message processing is stopped on all
of them. This way you can even shut down the whole Elasticsearch cluster if you want and
never lose any messages.
