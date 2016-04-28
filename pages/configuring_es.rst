************************************
Configuring and tuning Elasticsearch
************************************

We strongly recommend to use a dedicated Elasticsearch cluster for your Graylog setup.
If you are using a shared Elasticsearch setup, a problem with indices unrelated to Graylog might turn the cluster status to yellow or red
and impact the availability and performance of your Graylog setup.

Configuration
=============

Configuration of graylog-server nodes
-------------------------------------

The most important settings to make a successful connection are the Elasticsearch cluster name and the discovery mode. Graylog is able
to discover the Elasticsearch nodes using multicast. This is great for development and proof of concepts but we recommend to use
classic unicast discovery in production.

Cluster Name
^^^^^^^^^^^^

You need to tell ``graylog-server`` which Elasticsearch cluster to join. The Elasticsearch cluster default name is *elasticsearch*
and configured for every Elasticsearch node in its ``elasticsearch.yml`` configuration file with the setting ``cluster.name``.
Configure the same name in every ``graylog.conf`` as ``elasticsearch_cluster_name``.
We recommend to call the cluster ``graylog-production`` and not ``elasticsearch``.

The ``elasticsearch.yml`` file is typically located in ``/etc/elasticsearch/``.

Discovery mode
^^^^^^^^^^^^^^

The default discovery mode is multicast. Graylog will try to find other Elasticsearch nodes automatically. This usually works fine
when everything is running on the same system but gets problematic quickly when running in a bigger network topology. We recommend
to use unicast for production setups. Configure Zen unicast discovery in Graylog with the following lines in your configuration file::

  # Disable multicast
  elasticsearch_discovery_zen_ping_multicast_enabled = false
  # List of Elasticsearch nodes to connect to
  elasticsearch_discovery_zen_ping_unicast_hosts = es-node-1.example.org:9300,es-node-2.example.org:9300

Also make sure to configure `Zen unicast discovery <http://www.elastic.co/guide/en/elasticsearch/reference/2.3/modules-discovery-zen.html#unicast>`__ in
the Elasticsearch configuration file by adding the ``discovery.zen.ping.multicast.enabled`` and ``discovery.zen.ping.unicast.hosts`` setting with the
list of Elasticsearch nodes to ``elasticsearch.yml``::

  discovery.zen.ping.multicast.enabled: false
  discovery.zen.ping.unicast.hosts: ["es-node-1.example.org:9300" , "es-node-2.example.org:9300"]

The Elasticsearch default communication port is *9300/tcp* (not to be confused with the HTTP interface running on port *9200/tcp* by default).
The communication port can be changed in the Elasticsearch configuration file (``elasticsearch.yml``) with the configuration setting ``transport.tcp.port``.
Make sure that Elasticsearch binds to a network interface that Graylog can connect to (see ``network.host``).

Configuration of Elasticsearch nodes
------------------------------------

Disable dynamic scripting
^^^^^^^^^^^^^^^^^^^^^^^^^

Elasticsearch prior to version 1.2 had an insecure default configuration which could lead to a remote code execution.
(see `here <http://bouk.co/blog/elasticsearch-rce/>`__ and `here <https://groups.google.com/forum/#!msg/graylog2/-icrS0rIA-Q/cCTJaNjVrQAJ>`__ for details)

Make sure to add ``script.disable_dynamic: true`` to the ``elasticsearch.yml`` file to disable the dynamic scripting feature and
prevent possible remote code executions.

Control access to Elasticsearch ports
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Since Elasticsearch has no authentication mechanism at time of this writing, make sure to restrict access to the Elasticsearch
ports (default: 9200/tcp and 9300/tcp). Otherwise the data is readable by anyone who has access to the machine over network.

Open file limits
^^^^^^^^^^^^^^^^

Because Elasticsearch has to keep a lot of files open simultaneously it requires a higher open file limit that the usual operating
system defaults allow. **Set it to at least 64000 open file descriptors.**

Graylog will show a notification in the web interface when there is a node in the Elasticsearch cluster which has a too low open file limit.

Read about how to raise the open file limit in the corresponding `Elasticsearch documentation page <http://www.elasticsearch.org/tutorials/too-many-open-files/>`__.

Heap size
^^^^^^^^^

It is strongly recommended to raise the standard size of heap memory allocated to Elasticsearch. Just set the ``ES_HEAP_SIZE`` environment
variable to for example ``24g`` to allocate 24GB. We recommend to use around 50% of the available system memory for Elasticsearch (when
running on a dedicated host) to leave enough space for the system caches that Elasticsearch uses a lot. But please take care that you `don't cross 32 GB! <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/heap-sizing.html#compressed_oops>`__

Merge throttling
^^^^^^^^^^^^^^^^

Elasticsearch is throttling the merging of Lucene segments to allow extremely fast searches. This throttling however has default values
that are very conservative and can lead to slow ingestion rates when used with Graylog. You would see the message journal growing without
a real indication of CPU or memory stress on the Elasticsearch nodes. It usually goes along with Elasticsearch INFO log messages like this::

  now throttling indexing

When running on fast IO like SSDs or a SAN we recommend to increase the value of the ``indices.store.throttle.max_bytes_per_sec`` in your
``elasticsearch.yml`` to 150MB::

  indices.store.throttle.max_bytes_per_sec: 150mb

Play around with this setting until you reach the best performance.

Tuning Elasticsearch
^^^^^^^^^^^^^^^^^^^^

Graylog is already setting specific configuration per index it creates. This is enough tuning for a lot of use cases and setups. A more
detailed guide on deeper tuning of Elasticsearch is following.

Avoiding split-brain and shard shuffling
========================================

Split-brain events
------------------

Elasticsearch sacrifices consistency in order to ensure availability, and partition tolerance. The reasoning behind that is that short periods of misbehaviour are less problematic than short periods of unavailability. In other words, when Elasticsearch nodes in a cluster are unable to replicate changes to data, they will keep serving applications such as Graylog. When the nodes are able to replicate their data, they will attempt to converge the replicas and to achieve *eventual consistency*.

Elasticsearch tackles the previous by electing master nodes, which are in charge of database operations such as creating new indices, moving shards around the cluster nodes, and so forth. Master nodes coordinate their actions actively with others, ensuring that the data can be converged by non-masters. The cluster nodes that are not master nodes are not allowed to make changes that would break the cluster.

The previous mechanism can in some circumstances fail, causing a **split-brain event**. When an Elasticsearch cluster is split into two sides, both thinking they are the master, data consistency is lost as the masters work independently on the data. As a result the nodes will respond differently to same queries. This is considered a catastrophic event, because the data from two masters can not be rejoined automatically, and it takes quite a bit of manual work to remedy the situation.

Avoiding split-brain events
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Elasticsearch nodes take a simple majority vote over who is master. If the majority agrees that they are the master, then most likely the disconnected minority has also come to conclusion that they can not be the master, and everything is just fine. This mechanism requires at least 3 nodes to work reliably however, because one or two nodes can not form a majority. 

The minimum amount of master nodes required to elect a master must be configured manually in ``elasticsearch.yml``::

  # At least NODES/2+1 on clusters with NODES > 2, where NODES is the number of master nodes in the cluster
  discovery.zen.minimum_master_nodes: 2

The configuration values should typically for example:

+--------------+------------------------+----------------------------------------------------------------------+
| Master nodes | minimum_master_nodes   | Comments                                                             |
+==============+========================+======================================================================+
| 1            | 1                      |                                                                      |
+--------------+------------------------+----------------------------------------------------------------------+
| 2            | 1                      | With 2 the other node going down would stop the cluster from working!|
+--------------+------------------------+----------------------------------------------------------------------+
| 3            | 2                      |                                                                      |
+--------------+------------------------+----------------------------------------------------------------------+
| 4            | 3                      |                                                                      |
+--------------+------------------------+----------------------------------------------------------------------+
| 5            | 3                      |                                                                      |
+--------------+------------------------+----------------------------------------------------------------------+
| 6            | 4                      |                                                                      |
+--------------+------------------------+----------------------------------------------------------------------+

Some of the master nodes may be *dedicated master nodes*, meaning they are configured just to handle lightweight operational (cluster management) responsibilities. They will not handle or store any of the cluster's data. The function of such nodes is similar to so called *witness servers* on other database products, and setting them up on dedicated witness sites will greatly reduce the chance of Elasticsearch cluster instability. 

A dedicated master node has the following configuration in ``elasticsearch.yml``::

 node.data: false
 node.master: true

Shard shuffling
---------------

When cluster status changes, for example because of node restarts or availability issues, Elasticsearch will start automatically rebalancing the data in the cluster. The cluster works on making sure that the amount of shards and replicas will conform to the cluster configuration. This is a problem if the status changes are just temporary. Moving shards and replicas around in the cluster takes considerable amount of resources, and should be done only when necessary.

Avoiding unnecessary shuffling
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Elasticsearch has couple configuration options, which are designed to allow short times of unavailability before starting the recovery process with shard shuffling. There are 3 settings that may be configured in ``elasticsearch.yml``::

  # Recover only after the given number of nodes have joined the cluster. Can be seen as "minimum number of nodes to attempt recovery at all".
  gateway.recover_after_nodes: 8
  # Time to wait for additional nodes after recover_after_nodes is met.
  gateway.recover_after_time: 5m
  # Inform ElasticSearch how many nodes form a full cluster. If this number is met, start up immediately.
  gateway.expected_nodes: 10

The configuration options should be set up so that only *minimal* node unavailability is tolerated. For example server restarts are common, and should be done in managed manner. The logic is that if you lose large part of your cluster, you probably should start re-shuffling the shards and replicas without tolerating the situation. 

Cluster Status explained
========================

Elasticsearch provides a classification for the cluster health:

RED
---

The red status indicates that some or all of the primary shards are not
available. In this state, no searches can be performed until all primary shards
are restored.

YELLOW
------

The yellow status means that all of the primary shards are available but some
or all shard replicas are not.

With only one Elasticsearch node, the cluster state cannot become green because
shard replicas cannot be assigned. This can be solved by adding another
Elasticsearch node to the cluster.

If the cluster is supposed to have only one node it is okay to be in the
yellow state.

GREEN
-----

The cluster is fully operational. All primary and replica shards are available.
