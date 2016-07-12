.. _configure_multinode:

****************
Multi node Setup
****************

This guide will not cover one specific multi node setup of Graylog, but i should give some advice during the setup. Important for such a project is that you understand each step and do some planing. Without a roadmap you will be lost.

Graylog should always be the last component you install in the setup, MongoDB and Elasticsearch need to be up and running at first. 

.. important:: This will not include how you can run a multi node setup over untrusted networks, the assumption is that you trust the connection between the hosts.

Prerequisites
=============

Every server that is part of this setup should have the software equirements installed to run the targeted software. All software requirements can be found in the installation manual. 

We highly recommend that you have the time in sync on all servers. Needless to say working DNS. To easy up the installation, a working internet connection for the servers should be present.

MongoDB replica set
===================

Our recommendation is that you `deploy a replica set <https://docs.mongodb.com/manual/tutorial/deploy-replica-set/>`__. You did not need dedicated servers for your MongoDB but you should follow the recommendations that are given in the documentation about architecture. Most important is that you have an odd number of MongoDB servers.

In most setups each Graylog server will also have a MongoDB running that is part of the same replica set and share the data with all other nodes in the cluster. 

.. note:: To avoid that your database can be screwed by someone else your `replica set should be setup with authentication <https://docs.mongodb.com/v2.6/tutorial/deploy-replica-set-with-auth/>`__.

The right order of working steps should be, create the replica set (*rs01*), add database (*graylog*), create user for this database. The created user should have the following roles ``readWrite`` and ``dbAdmin`` within MongoDB.


Elasticsearch cluster
=====================

The ressources `provided by elastic <https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-configuration.html>`__ should help you to install a robust configuration. Important to name is, that your cluster should not simple named *elasticsearch*. Just choose anything else, because this is the default name and any Elasticsearch instance that is started in the same network will connect to the cluster.

.. note:: Graylog does not work with Elasticsearch clusters that run with `Shield <https://www.elastic.co/products/shield>`__ at the current version. Your cluster need to be secured by design and not additional software.

Graylog Multinode
=================

After the installation you should take care that only one Graylog server has the setting ``is_master`` set to ``true``. The ``rest_listen_uri`` should be accessable on all nodes from withing all nodes. 

Graylog to MongoDB connection 
-----------------------------

The Graylog server need to know about the MongoDB `Replica Set` in the configuration with the ``mongodb_uri`` where you should enter all nodes that contain data. Additional the configured user and the name of the replica set must be part of the MongoDB connection string.

Finally your connection string for MongoDB in your Graylog `server.conf` look like this::

  mongodb_uri = mongodb://USERNAME:PASSWORD@multinode01:27017,multinode02:27017,multinode03:27017/graylog?replicaSet=rs01

Graylog to Elasticsearch connection
-----------------------------------

To avoid issues with the connection to the `Elasticsearch` cluster you should set ``elasticsearch_discovery_zen_ping_unicast_hosts`` to some of the `Elasticsearch` servers in your setup. Additional ``elasticsearch_network_host`` must be set to a network interface which can be accessed by the other nodes in the `Elasticsearch` cluster.
Graylog will connect as `client node <https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#client-node>`__ to the `Elasticsearch` Cluster.

Graylog webinterface
--------------------

The webinterface can be used on every instance of Graylog that has not the option ``web_enable = false`` set in the `server.conf`. As per default the webinterface is enabled. It is possible to use :ref:`a loadbalancer <loadbalancer_integration>` for all running servers, but for the :ref:`webinterface some additional settings <configuring_webif_nginx>` need to be set. 

Depending on your setup it is possible to use the loadbalancer to do TLS/HTTPS termination, a :ref:`webserver <configuring_webif_nginx>` or to enable it :ref:`native in the Graylog <ssl_setup>` server.


Troubleshoot
============

- On every configuration change and service restart, watch the logfile of the application you had worked on. Sometime even other logfiles can give you information what is wrong. For example if you configure Graylog and look why the connection to the MongoDB is not working, the MongoDB logfile could also help to itentify the problem.
