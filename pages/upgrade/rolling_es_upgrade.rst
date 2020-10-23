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
5. Pause message processing on each Graylog node from group B _or_ shut down Graylog nodes from group B.
6. Upgrade all Elasticsearch nodes from group B.
7. Resume message processing on each Graylog node from Group B _or_ start all Graylog nodes from group B.
8. Pause message processing on each Graylog node from group A _or_ shut down Graylog nodes from group A.
9. Upgrade all Elasticsearch nodes from group A.
10. Revert all changes performed in steps 1, 4 and 8.

Before performing this procedure, please make sure that:

1. You have at least 2 nodes in each of your Graylog and Elasticsearch clusters.
2. Temporarily splitting up your clusters still allow you to handle the incoming message load.

If performed correctly, this procedure allow you to perform a rolling Elasticsearch upgrade between two major versions without any message loss and a minimal amount of time where a subset of your Graylog nodes is down because of a restart.

