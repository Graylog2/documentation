.. _es_rolling_upgrade:

***********************************
Elasticsearch Rolling Upgrade Notes
***********************************

This page contains a few notes and a recommended procedure to perform a rolling upgrade for a Elasticsearch cluster utilized by Graylog.

Elasticsearch supports rolling upgrades to avoid downtimes during upgrades. Detailed information about the procedures and limitations are provided `here <https://www.elastic.co/guide/en/elasticsearch/reference/master/rolling-upgrades.html>`__.

Graylog supports rolling upgrades without restarting any Graylog node for Elasticsearch upgrades *between minor versions*. While Elasticsearch supports upgrading from e.g. 6.8 to 7.0, Graylog requires a restart when the major version of the Elasticsearch cluster is changed.

To avoid message loss in case of a rolling Elasticsearch upgrade which requires the restart of Graylog nodes, please follow this procedure:

1. Temporarily disable ES :ref:`automatic node discovery <automatic_node_discovery>`_ if it is used.
2. Mentally split up the Elasticsearch cluster in two groups by designating each Elasticsearch node to group A or B.
3. Mentally split up the Graylog cluster in two groups by designating each Graylog node to group A or B.
4. Temporarily configure each Graylog node from group A to use only Elasticsearch nodes from group A and vice versa for group B.
5. :ref:`Pause message processing <pause_message_processing>`_ on each Graylog node from group B _or_ shut down Graylog nodes from group B.
6. Upgrade all Elasticsearch nodes from group B.
7. Restart each Graylog node from Group B for which you have paused message processing in step 5 _or_ start all Graylog nodes from group B which you have shut down in step 5.
8. :ref:`Pause message processing <pause message_processing>`_ on each Graylog node from group A _or_ shut down Graylog nodes from group A.
9. Upgrade all Elasticsearch nodes from group A.
10. Restart each Graylog node from Group A for which you have paused message processing in stept 8 _or_ start all Graylog nodes from group A which you have shut down in step 8.
11. Revert all changes performed in steps 1 and 4.

Before performing this procedure, please make sure that:

1. You have at least 2 nodes in each of your Graylog and Elasticsearch clusters.
2. Temporarily splitting up your clusters still allows you to handle the incoming message load.

If performed correctly, this procedure allow you to perform a rolling Elasticsearch upgrade between two major versions without any message loss and a minimal amount of time where a subset of your Graylog nodes is down because of a restart.

.. _pause_message_processing:

Pausing Message Processing on Graylog Nodes
-------------------------------------------

Instead of shutting down individual Graylog nodes, message processing can be paused instead. This has the benefit that all Graylog nodes will continue to accept messages, those nodes on which message processing is disabled will keep in their journal instead of indexing them on Elasticsearch and continue indexing after a restart.

In order to do this, you can pause message processing by going to the web interface of any node, navigate to ``System`` -> ``Nodes``, click on the ``More Actions`` dropdown next to the node you want to pause message processing and click ``Pause message processing``.

