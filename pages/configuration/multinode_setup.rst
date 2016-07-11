.. _configure_multinode:

****************
Multi node Setup
****************

This guide will not cover one specific multi node setup of Graylog, but i should give some advice during the setup.

.. important:: This will not include how you can run a multi node setup over unsecure wires, the assumption is that you thrust the connection between the hosts

Prerequisites
=============

Every server that is part of this setup should have the requirements installed, find them defined in the installation manual. Additional we highly recommend that you have the time in sync on all servers. Needless to say working DNS.

MongoDB
=======

Our recommendation is that you `deploy a Replica Set <https://docs.mongodb.com/manual/tutorial/deploy-replica-set/>`__. You did not need dedicated servers for your MongoDB but you should follow the recommendations that are given in the documentation about architecture.

In most setups each Graylog server will also have a MongoDB running that is part of the same Replica Set and share the data with all other nodes in the cluster. 

.. note:: To avoid that your database can be screwed by someone else your `Replica Set should be setup with authentication <https://docs.mongodb.com/v2.6/tutorial/deploy-replica-set-with-auth/>`__.

.. important:: Understand the `connection string <http://docs.mongodb.org/manual/reference/connection-string/>`__ is important to succeed with user and *Replica Set* authentication.

Elasticsearch
=============

The ressources `provided by elastic <https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-configuration.html>`__ should help you to install a robust configuration. Important to name is, that your cluster should not simple named *Elasticsearch*. Just choose anything else, because this is the default name and any Elasticsearch instance that is started in the same network will connect to the cluster.

.. note:: Graylog does not work with Elasticsearch clusters that run with `Shield <https://www.elastic.co/products/shield>`__ at the current version. Your cluster need to be secured by design and not additional software.

Graylog
=======

After the installation you should take care that only one Graylog server has the setting ``is_master`` set to ``true``. The ``rest_listen_uri`` should be accessable on all nodes from withing all nodes. 

The Graylog server need to know about the MongoDB `Replica Set` in the configuration with the ``mongodb_uri`` where you should enter all nodes that contain data. Additional the configured user and Replica Set need to be placed in the connection string.

To avoid issues with the connection to the `Elasticsearch` cluster you should set ``elasticsearch_discovery_zen_ping_unicast_hosts`` to some of the `Elasticsearch` servers in your setup. Additional ``elasticsearch_network_host`` should be set, that the `Elasticsearch` cluster can communicate with the Graylog Elasticsearch clients. 
