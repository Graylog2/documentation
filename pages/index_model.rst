*********************************
The Graylog index model explained
*********************************

Overview
========

Graylog is transparently managing a set of indices to optimise search and analysis operations
for speed and low resource utilisation. The system is maintaining an index alias called
*graylog_deflector* that is always pointing to the current write-active index. We always have
exactly one index to which new messages are appended until the configured maximum size
(``elasticsearch_max_docs_per_index`` in your ``graylog.conf``) is reached.

A background task is running every minute and checks if the maximum size is reached. A new
index is created and prepared when that happens. Once the index is considered to be ready
to be written to, the ``graylog_deflector`` is atomically switched to the it. That means that
all writing nodes can always write to the deflector alias without even knowing what the
currently active write-active index is.

**Note that there are also time based retention settings since v1.0 of Graylog**.
This allows you to instruct Graylog to keep messages based on their age and not the total
amount. You can find the corresponding configuration settings in your ``graylog.conf``.

.. image:: /images/index_model_writes.png

.. image:: /images/index_model_reads.png

Almost every read operation is performed with a given time range. Because Graylog is only
writing sequentially it can keep a cached collection of information about which index starts
at what point in time. It selects a lists of indices to query when having a time range provided.
If no time range is provided it will search in all indices it knows.

Eviction of indices and messages
================================

You have configured the maximum number of indices in your ``graylog.conf``
(``elasticsearch_max_number_of_indices``). When that number is reached the oldest indices will
automatically be deleted. The deleting is performed by the `graylog-server` master node in a
background process that is continuously comparing the actual number of indices with the configured
maximum::

    elasticsearch_max_docs_per_index * elasticsearch_max_number_of_indices
      = maximum number of messages stored

Keeping the metadata in synchronisation
=======================================

Graylog will on notify you when the stored metadata about index time ranges has run out of sync.
This can for example happen when you delete indices by hand. The system will offer you to just
re-generate all time range informations. This may take a few seconds but is an easy task for Graylog.

You can easily re-build the information yourself after manually deleting indices or doing other
changes that might cause synchronisation problems::

  $ curl -XPOST http://127.0.0.1:12900/system/indices/ranges/rebuild

This will trigger a systemjob::

  INFO : org.graylog2.system.jobs.SystemJobManager - Submitted SystemJob <ef7057c0-5ae3-11e3-b935-4c8d79f2b596> [org.graylog2.indexer.ranges.RebuildIndexRangesJob]
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Re-calculating index ranges.
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Calculated range of [graylog2_56] in [640ms].
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Calculated range of [graylog2_18] in [66ms].
  ...
  INFO : org.graylog2.indexer.ranges.RebuildIndexRangesJob - Done calculating index ranges for 88 indices. Took 4744ms.
  INFO : org.graylog2.system.jobs.SystemJobManager - SystemJob <ef7057c0-5ae3-11e3-b935-4c8d79f2b596> [org.graylog2.indexer.ranges.RebuildIndexRangesJob] finished in 4758ms.

Manually cycling the deflector
==============================

Sometimes you might want to cycle the deflector manually and not wait until the configured maximum
number of messages in the newest index is reached. You can do this either via a REST call against
the `graylog-server` master node or via the web interface::

  $ curl -XPOST http://127.0.0.1:12900/system/deflector/cycle

.. image:: /images/recalculate_index_ranges.png

This triggers the following log output::

  INFO : org.graylog2.rest.resources.system.DeflectorResource - Cycling deflector. Reason: REST request.
  INFO : org.graylog2.indexer.Deflector - Cycling deflector to next index now.
  INFO : org.graylog2.indexer.Deflector - Cycling from <graylog2_90> to <graylog2_91>
  INFO : org.graylog2.indexer.Deflector - Creating index target <graylog2_91>...
  INFO : org.graylog2.indexer.Deflector - Done!
  INFO : org.graylog2.indexer.Deflector - Pointing deflector to new target index....
  INFO : org.graylog2.indexer.Deflector - Flushing old index <graylog2_90>.
  INFO : org.graylog2.indexer.Deflector - Setting old index <graylog2_90> to read-only.
  INFO : org.graylog2.system.jobs.SystemJobManager - Submitted SystemJob <a05e0d60-5c34-11e3-8df7-4c8d79f2b596> [org.graylog2.indexer.indices.jobs.OptimizeIndexJob]
  INFO : org.graylog2.indexer.Deflector - Done!
  INFO : org.graylog2.indexer.indices.jobs.OptimizeIndexJob - Optimizing index <graylog2_90>.
  INFO : org.graylog2.system.jobs.SystemJobManager - SystemJob <a05e0d60-5c34-11e3-8df7-4c8d79f2b596> [org.graylog2.indexer.indices.jobs.OptimizeIndexJob] finished in 334ms.
