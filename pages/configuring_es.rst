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

Discovery mode
^^^^^^^^^^^^^^

The default discovery mode is multicast. Graylog will try to find other Elasticsearch nodes automatically. This usually works fine
when everything is running on the same system but gets problematic quickly when running in a bigger network topology. We recommend
to use unicast for production setups. Configure Zen unicast discovery in Graylog with the following lines in your configuration file::

  # Disable multicast
  elasticsearch_discovery_zen_ping_multicast_enabled = false
  # List of Elasticsearch nodes to connect to
  elasticsearch_discovery_zen_ping_unicast_hosts = es-node-1.example.org:9300,es-node-2.example.org:9300

Also make sure to configure `Zen unicast discovery <http://www.elastic.co/guide/en/elasticsearch/reference/1.3/modules-discovery-zen.html#unicast>`_ in
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
(see `here <http://bouk.co/blog/elasticsearch-rce/>`_ and `here <https://groups.google.com/forum/#!msg/graylog2/-icrS0rIA-Q/cCTJaNjVrQAJ>`_ for details)

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

Read about how to raise the open file limit in the corresponding `Elasticsearch documentation page <http://www.elasticsearch.org/tutorials/too-many-open-files/>`_.

Heap size
^^^^^^^^^

It is strongly recommended to raise the standard size of heap memory allocated to Elasticsearch. Just set the ``ES_HEAP_SIZE`` environment
variable to for example ``24g`` to allocate 24GB. We recommend to use around 50% of the available system memory for Elasticsearch (when
running on a dedicated host) to leave enough space for the system caches that Elasticsearch uses a lot.

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
