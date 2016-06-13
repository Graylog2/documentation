************************************
Configuring and tuning Elasticsearch
************************************

We strongly recommend to use a dedicated Elasticsearch cluster for your Graylog setup.
If you are using a shared Elasticsearch setup, a problem with indices unrelated to Graylog might turn the cluster status to yellow or red
and impact the availability and performance of your Graylog setup.

.. important:: Graylog currently does not work with Elasticsearch clusters using the License or `Shield <https://www.elastic.co/guide/en/shield/current/index.html>`__ plugin.


Elasticsearch versions
======================

Graylog hosts an embedded Elasticsearch node which is joining the Elasticsearch cluster as a client node.

The following table provides an overview over the Elasticsearch version in Graylog:

===============  =====================
Graylog version  Elasticsearch version
===============  =====================
1.2.0            1.7.1
1.2.1            1.7.1
1.3.0            1.7.3
1.3.1            1.7.3
1.3.2            1.7.3
1.3.3            1.7.3
1.3.4            1.7.5
2.0.0            2.3.1
2.0.1            2.3.2
2.0.2            2.3.2
===============  =====================


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

Make sure to add the following settings to the ``elasticsearch.yml`` file to disable the dynamic scripting feature and
prevent possible remote code executions::

  script.inline: false
  script.indexed: false
  script.file: false

Details about dynamic scripting can be found in `the reference documentation of Elasticsearch <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/modules-scripting.html>`__.

Control access to Elasticsearch ports
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Since Elasticsearch has no authentication mechanism at time of this writing, make sure to restrict access to the Elasticsearch
ports (default: 9200/tcp and 9300/tcp). Otherwise the data is readable by anyone who has access to the machine over network.

Open file limits
^^^^^^^^^^^^^^^^

Because Elasticsearch has to keep a lot of files open simultaneously it requires a higher open file limit that the usual operating
system defaults allow. **Set it to at least 64000 open file descriptors.**

Graylog will show a notification in the web interface when there is a node in the Elasticsearch cluster which has a too low open file limit.

Read about how to raise the open file limit in the corresponding `Elasticsearch documentation page <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/setup-configuration.html#file-descriptors>`__.

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


Custom index mappings
=====================

Sometimes it's useful to not rely on Elasticsearch's `dynamic mapping <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/dynamic-mapping.html>`__ but to define a stricter schema for messages.

Graylog itself is using a default mapping which includes settings for the ``timestamp``, ``message``, ``full_message``, and ``source`` fields of indexed messages::

  $ curl -X GET 'http://localhost:9200/_template/graylog-internal?pretty'
  {
    "graylog-internal" : {
      "order" : -2147483648,
      "template" : "graylog_*",
      "settings" : { },
      "mappings" : {
        "message" : {
          "_ttl" : {
            "enabled" : true
          },
          "_source" : {
            "enabled" : true
          },
          "dynamic_templates" : [ {
            "internal_fields" : {
              "mapping" : {
                "index" : "not_analyzed",
                "type" : "string"
              },
              "match" : "gl2_*"
            }
          }, {
            "store_generic" : {
              "mapping" : {
                "index" : "not_analyzed"
              },
              "match" : "*"
            }
          } ],
          "properties" : {
            "full_message" : {
              "analyzer" : "standard",
              "index" : "analyzed",
              "type" : "string"
            },
            "streams" : {
              "index" : "not_analyzed",
              "type" : "string"
            },
            "source" : {
              "analyzer" : "analyzer_keyword",
              "index" : "analyzed",
              "type" : "string"
            },
            "message" : {
              "analyzer" : "standard",
              "index" : "analyzed",
              "type" : "string"
            },
            "timestamp" : {
              "format" : "yyyy-MM-dd HH:mm:ss.SSS",
              "type" : "date"
            }
          }
        }
      },
      "aliases" : { }
    }
  }

In order to extend the default mapping of Elasticsearch and Graylog, you can create one or more custom index mappings and add them as index templates to Elasticsearch.

Let's say we have a schema for our data like the following:

======================  ==========  ========================
Field Name              Field Type  Example
======================  ==========  ========================
``http_method``         string      GET
``http_response_code``  long        200
``ingest_time``         date        2016-06-13T15:00:51.927Z
``took_ms``             long        56
======================  ==========  ========================

This would translate to the following additional index mapping in Elasticsearch::

  "mappings" : {
    "message" : {
      "properties" : {
        "http_method" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "http_response_code" : {
          "type" : "long"
        },
        "ingest_time" : {
          "type" : "date",
          "format": "strict_date_time"
        },
        "took_ms" : {
          "type" : "long"
        }
      }
    }
  }

The format of the ``ingest_time`` field is described in the Elasticsearch documentation about the `format mapping parameter <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/mapping-date-format.html>`_. Also make sure to check the Elasticsearch documentation about `Field datatypes <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/mapping-types.html>`_.

In order to apply the additional index mapping when Graylog creates a new index in Elasticsearch, it has to be added to an `index template <https://www.elastic.co/guide/en/elasticsearch/reference/2.3/indices-templates.html>`_. The Graylog default template (``graylog-internal``) has the lowest priority and will be merged with the custom index template by Elasticsearch.

.. warning:: If the default index mapping and the custom index mapping cannot be merged (e. g. because of conflicting field datatypes), Elasticsearch will throw an exception and won't create the index. So be extremeley cautious and conservative about the custom index mappings!

Creating a new index template
-----------------------------

Save the following index template for the custom index mapping into a file named ``graylog-custom-mapping.json``::

  {
    "template": "graylog_*",
    "mappings" : {
      "message" : {
        "properties" : {
          "http_method" : {
            "type" : "string",
            "index" : "not_analyzed"
          },
          "http_response_code" : {
            "type" : "long"
          },
          "ingest_time" : {
            "type" : "date",
            "format": "strict_date_time"
          },
          "took_ms" : {
            "type" : "long"
          }
        }
      }
    }
  }


Finally, load the index mapping into Elasticsearch with the following command::

  $ curl -X PUT -d @'graylog-custom-mapping.json' 'http://localhost:9200/_template/graylog-custom-mapping?pretty'
  {
    "acknowledged" : true
  }


Every Elasticsearch index created from that time on, will have an index mapping consisting of the original ``graylog-internal`` index template and the new ``graylog-custom-mapping`` template::

  $ curl -X GET 'http://localhost:9200/graylog_deflector/_mapping?pretty'
  {
    "graylog_2" : {
      "mappings" : {
        "message" : {
          "_ttl" : {
            "enabled" : true
          },
          "dynamic_templates" : [ {
            "internal_fields" : {
              "mapping" : {
                "index" : "not_analyzed",
                "type" : "string"
              },
              "match" : "gl2_*"
            }
          }, {
            "store_generic" : {
              "mapping" : {
                "index" : "not_analyzed"
              },
              "match" : "*"
            }
          } ],
          "properties" : {
            "full_message" : {
              "type" : "string",
              "analyzer" : "standard"
            },
            "http_method" : {
              "type" : "string",
              "index" : "not_analyzed"
            },
            "http_response_code" : {
              "type" : "long"
            },
            "ingest_time" : {
              "type" : "date",
              "format" : "strict_date_time"
            },
            "message" : {
              "type" : "string",
              "analyzer" : "standard"
            },
            "source" : {
              "type" : "string",
              "analyzer" : "analyzer_keyword"
            },
            "streams" : {
              "type" : "string",
              "index" : "not_analyzed"
            },
            "timestamp" : {
              "type" : "date",
              "format" : "yyyy-MM-dd HH:mm:ss.SSS"
            },
            "took_ms" : {
              "type" : "long"
            }
          }
        }
      }
    }
  }

Deleting custom index templates
-------------------------------

If you want to remove an existing index template from Elasticsearch, simply issue a ``DELETE`` request to Elasticsearch::

  $ curl -X DELETE 'http://localhost:9200/_template/graylog-custom-mapping?pretty'
  {
    "acknowledged" : true
  }


After you've removed the index template, new indices will only have the original index mapping::

  $ curl -X GET 'http://localhost:9200/graylog_deflector/_mapping?pretty'
  {
    "graylog_3" : {
      "mappings" : {
        "message" : {
          "_ttl" : {
            "enabled" : true
          },
          "dynamic_templates" : [ {
            "internal_fields" : {
              "mapping" : {
                "index" : "not_analyzed",
                "type" : "string"
              },
              "match" : "gl2_*"
            }
          }, {
            "store_generic" : {
              "mapping" : {
                "index" : "not_analyzed"
              },
              "match" : "*"
            }
          } ],
          "properties" : {
            "full_message" : {
              "type" : "string",
              "analyzer" : "standard"
            },
            "message" : {
              "type" : "string",
              "analyzer" : "standard"
            },
            "source" : {
              "type" : "string",
              "analyzer" : "analyzer_keyword"
            },
            "streams" : {
              "type" : "string",
              "index" : "not_analyzed"
            },
            "timestamp" : {
              "type" : "date",
              "format" : "yyyy-MM-dd HH:mm:ss.SSS"
            }
          }
        }
      }
    }
  }

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
