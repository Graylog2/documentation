************************************
Configuring and tuning Elasticsearch
************************************

Configuration: graylog.conf
---------------------------

The most important settings to make a successful connection are the cluster name and the discovery mode. Graylog2 is able
to discover the Elasticsearch nodes using multicast. This is great for development but we recommend to use classic unicast
in production.

Cluster Name
------------

You need to tell graylog-server which Elasticsearch cluster to join. The Elasticsearch cluster default name is *elasticsearch*
and configured for every Elasticsearch node in its ``elasticsearch.yml`` configuration file as ``cluster.name``. Configure the same
name in every ``graylog2.conf`` as ``elasticsearch_cluster_name``. We recommend to call the cluster ``graylog2-production``, not
``elasticsearch``.

Discovery mode
--------------

The default discovery mode is multicast. Graylog2 will try to find other Elasticsearch nodes automatically. This usually works fine
when everything is running on the same hosts but quickly gets problematic when running in a bigger network topology. We recommend
to use unicast for production setups. Configure it like this::

  # Disable multicast
  elasticsearch_discovery_zen_ping_multicast_enabled = false
  # List of Elasticsearch nodes to connect to
  elasticsearch_discovery_zen_ping_unicast_hosts = es-node-1.example.org:9300,es-node-2.example.org:9300

The default Elasticsearch communication port is 9300 (not to confuse with 9200 as standard for HTTP communication) and configured
as ``transport.tcp.port`` in ``elasticsearch.yml``. Make sure that Elasticsearch binds to an interface that Graylog2 can connect to.
(see ``network.host``)

Configuration of Elasticsearch
------------------------------

Disable dynamic scripting
^^^^^^^^^^^^^^^^^^^^^^^^^

Elasticsearch prior to version 1.2 had an insecure default configuration which could lead to a remote code execution.
(see `here <http://bouk.co/blog/elasticsearch-rce/>`_ and `here <https://groups.google.com/forum/#!msg/graylog2/-icrS0rIA-Q/cCTJaNjVrQAJ>`_
 for details)

Make sure to add ``script.disable_dynamic: true`` to the ``elasticsearch.yml`` file to disable the dynamic scripting feature and
prevent possible remote code executions.

Control access to Elasticsearch ports
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Since Elasticsearch has no authentication mechanism at time of this writing, make sure to restrict access to the Elasticsearch
ports (default: 9200 and 9300). Otherwise the data is readable by anyone who can reach the machine.

Open file limits
^^^^^^^^^^^^^^^^

Because Elasticsearch has to keep a lot of files open simultaneously it requires a higher open file limit that the usual operating
system defaults allow. **Set it to at least 64000.**

Graylog2 will show a notification in the web interface when there is a node in the Elasticsearch cluster that has a too low open file limit.

Read about how to raise the open file limit in the corresponding `Elasticsearch documentation page <http://www.elasticsearch.org/tutorials/too-many-open-files/>`_.

Heap size
^^^^^^^^^

It is strongly recommended to raise the standard size of heap memory allocated to Elasticsearch. Just set the ``ES_HEAP_SIZE`` environment
variable to for example ``24g`` to allocate 24GB. We recommend to use around 50% of the available system memory for Elasticsearch (when
running on a dedicated host) to leave enough space for the system caches that Elasticsearch uses a lot.

Tuning Elasticsearch
^^^^^^^^^^^^^^^^^^^^

Graylog2 is already setting specific configuration per index it creates. This is enough tuning for a lot of use cases and setups. A more
detailed guide on deeper tuning of Elasticsearch is following.
