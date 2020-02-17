.. _index_model:

***********
Index model
***********

Overview
========

Graylog is transparently managing one or more sets of Elasticsearch indices to optimize search and analysis operations for speed and low resource consumption.

.. at the time of writing this guide has not been updated for elasticsearch 5 - we need to check from time to time.

To enable managing indices with different `mappings <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/mapping.html>`_, `analyzers <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/configuring-analyzers.html>`_, and `replication settings <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/_index_settings.html>`_ Graylog is using so-called index sets which are an abstraction of all these settings.

.. image:: /images/index_sets/index_set_overview.png

Each index set contains the necessary settings for Graylog to create, manage, and fill Elasticsearch indices and handle index rotation and data retention for specific requirements.

.. image:: /images/index_sets/index_set_details.png

Graylog is maintaining an `index alias <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/index-aliases.html>`_ per index set which is always pointing to the current write-active index from that index set.
There is always exactly one index to which new messages are written until the configured rotation criterion (number of documents, index size, or index age) has been met.

A background task continuously checks if the rotation criterion of an index set has been met and a new index is created and prepared when that happens.
Once the index is ready, the index alias is atomically switched to it.
That means that all Graylog nodes can write messages into the alias without even knowing what the currently write-active index of the index set is.

.. image:: /images/index_sets/index_model_write.png

Almost every read operation is performed with a given time range.
Because Graylog is writing messages sequentially into Elasticsearch it can keep information about the time range each index covers.
It selects a lists of indices to query when having a time range provided. If no time range was provided, it will search in all indices it knows.

.. image:: /images/index_sets/index_model_read.png


Eviction of indices and messages
--------------------------------

There are configuration settings for the maximum number of indices Graylog is managing in a given index set.

Depending on the configured retention strategy, the oldest indices of an index set will automatically be closed, deleted, or exported when the configured maximum number of indices has been reached.

The deletion is performed by the Graylog master node in a background thread which is continuously comparing the number of indices with the configured maximum::

  INFO : org.graylog2.indexer.rotation.strategies.AbstractRotationStrategy - Deflector index <graylog_95> should be rotated, Pointing deflector to new index now!
  INFO : org.graylog2.indexer.MongoIndexSet - Cycling from <graylog_95> to <graylog_96>.
  INFO : org.graylog2.indexer.MongoIndexSet - Creating target index <graylog_96>.
  INFO : org.graylog2.indexer.indices.Indices - Created Graylog index template "graylog-internal" in Elasticsearch.
  INFO : org.graylog2.indexer.MongoIndexSet - Waiting for allocation of index <graylog_96>.
  INFO : org.graylog2.indexer.MongoIndexSet - Index <graylog_96> has been successfully allocated.
  INFO : org.graylog2.indexer.MongoIndexSet - Pointing index alias <graylog_deflector> to new index <graylog_96>.
  INFO : org.graylog2.system.jobs.SystemJobManager - Submitted SystemJob <f1018ae0-dcaa-11e6-97c3-6c4008b8fc28> [org.graylog2.indexer.indices.jobs.SetIndexReadOnlyAndCalculateRangeJob]
  INFO : org.graylog2.indexer.MongoIndexSet - Successfully pointed index alias <graylog_deflector> to index <graylog_96>.


Index Set Configuration
=======================

Index sets have a variety of different settings related to how Graylog will store messages into the Elasticsearch cluster.

.. image:: /images/index_sets/index_set_create.png

* **Title**: A descriptive name of the index set.
* **Description**: A description of the index set for human consumption.
* **Index prefix**: A unique prefix used for Elasticsearch indices managed by the index set. The prefix must start with a letter or number, and can only contain letters, numbers, ``_``, ``-`` and ``+``. The index alias will be named accordingly, e. g. ``graylog_deflector`` if the index prefix was ``graylog``.
* **Analyzer**: (default: ``standard``) The Elasticsearch `analyzer <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/configuring-analyzers.html>`_ for the index set.
* **Index shards**: (default: 4) The number of Elasticsearch shards used per index.
* **Index replicas**: (default: 0) The number of Elasticsearch replicas used per index.
* **Max. number of segments**: (default: 1) The maximum number of segments per Elasticsearch index after `index optimization (force merge) <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/indices-forcemerge.html>`_, see `Segment Merging <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/merge-process.html>`_ for details.
* **Disable index optimization after rotation**: Disable Elasticsearch `index optimization (force merge) <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/indices-forcemerge.html>`_ after index rotation. Only activate this if you have serious problems with the performance of your Elasticsearch cluster during the optimization process.


.. _index_rotation:

Index rotation
--------------

* **Message count**: Rotates the index after a specific number of messages have been written.
* **Index size**: Rotates the index after an approximate size on disk (before optimization) has been reached.
* **Index time**: Rotates the index after a specific time (e. g. 1 hour or 1 week).

.. image:: /images/index_sets/index_set_create_rotation.png

.. _index_retention:

Index retention
---------------

* **Delete**: `Delete indices <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/indices-delete-index.html>`_ in Elasticsearch to minimize resource consumption.
* **Close**: `Close indices <https://www.elastic.co/guide/en/elasticsearch/reference/2.4/indices-open-close.html>`_ in Elasticsearch to reduce resource consumption.
* **Do nothing**
* **Archive**: Commercial feature, see :doc:`../archiving`.

.. image:: /images/index_sets/index_set_create_retention.png


Maintenance
===========

Keeping the index ranges in sync
--------------------------------

Graylog will take care of calculating index ranges automatically as soon as a new index has been created.

In case the stored metadata about index time ranges has run out of sync, Graylog will notify you in the web interface.
This can happen if an index was deleted manually or messages from already "closed" indices were removed.

The system will offer you to just re-generate all time range information.
This may take a few seconds but is an easy task for Graylog.

You can easily re-build the information yourself after manually deleting indices or doing other changes that might cause synchronization problems::

  $ curl -XPOST http://127.0.0.1:9000/api/system/indices/ranges/rebuild

This will trigger a system job::

  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Recalculating index ranges.
  INFO : org.graylog2.system.jobs.SystemJobManager - Submitted SystemJob <9b64a9d0-dcac-11e6-97c3-6c4008b8fc28> [org.graylog2.indexer.ranges.RebuildIndexRangesJob]
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Recalculating index ranges for index set Default index set (graylog2_*): 5 indices affected.
  INFO : org.graylog2.indexer.ranges.MongoIndexRangeService - Calculated range of [graylog_96] in [7ms].
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Created ranges for index graylog_96: MongoIndexRange{id=null, indexName=graylog_96, begin=2017-01-17T11:49:02.529Z, end=2017-01-17T12:00:01.492Z, calculatedAt=2017-01-17T12:00:58.097Z, calculationDuration=7, streamIds=[000000000000000000000001]}
  [...]
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Done calculating index ranges for 5 indices. Took 44ms.
  INFO : org.graylog2.system.jobs.SystemJobManager - SystemJob <9b64a9d0-dcac-11e6-97c3-6c4008b8fc28> [org.graylog2.indexer.ranges.RebuildIndexRangesJob] finished in 46ms.


Manually rotating the active write index
----------------------------------------

Sometimes you might want to rotate the active write index manually and not wait until the configured rotation criterion for in the latest index has been met, for example if you've changed the index mapping or the number of shards per index.

You can do this either via an HTTP request against the REST API of the Graylog master node or via the web interface::

  $ curl -XPOST http://127.0.0.1:9000/api/system/deflector/cycle

.. image:: /images/index_sets/index_set_maintenance.png

Triggering this job produces log output similar to the following lines::

  INFO : org.graylog2.rest.resources.system.DeflectorResource - Cycling deflector for index set <58501f0b4a133077ecd134d9>. Reason: REST request.
  INFO : org.graylog2.indexer.MongoIndexSet - Cycling from <graylog_97> to <graylog_98>.
  INFO : org.graylog2.indexer.MongoIndexSet - Creating target index <graylog_98>.
  INFO : org.graylog2.indexer.indices.Indices - Created Graylog index template "graylog-internal" in Elasticsearch.
  INFO : org.graylog2.indexer.MongoIndexSet - Waiting for allocation of index <graylog_98>.
  INFO : org.graylog2.indexer.MongoIndexSet - Index <graylog_98> has been successfully allocated.
  INFO : org.graylog2.indexer.MongoIndexSet - Pointing index alias <graylog_deflector> to new index <graylog_98>.
  INFO : org.graylog2.system.jobs.SystemJobManager - Submitted SystemJob <024aac80-dcad-11e6-97c3-6c4008b8fc28> [org.graylog2.indexer.indices.jobs.SetIndexReadOnlyAndCalculateRangeJob]
  INFO : org.graylog2.indexer.MongoIndexSet - Successfully pointed index alias <graylog_deflector> to index <graylog_98>.
  INFO : org.graylog2.indexer.retention.strategies.AbstractIndexCountBasedRetentionStrategy - Number of indices (5) higher than limit (4). Running retention for 1 index.
  INFO : org.graylog2.indexer.retention.strategies.AbstractIndexCountBasedRetentionStrategy - Running retention strategy [org.graylog2.indexer.retention.strategies.DeletionRetentionStrategy] for index <graylog_94>
  INFO : org.graylog2.indexer.retention.strategies.DeletionRetentionStrategy - Finished index retention strategy [delete] for index <graylog_94> in 23ms.
