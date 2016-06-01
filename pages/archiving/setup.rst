*****
Setup
*****

The archive plugin is a commercial Graylog feature that can be installed in
addition to the Graylog open source server.

Installation
============

Please see the :doc:`Graylog Enterprise setup page </pages/enterprise/setup>` for details on how to install
the Archive plugin.

Configuration
=============

The archive plugin can be configured via the Graylog web interface and does
not need any changes in the Graylog server configuration file.

In the web interface menu navigate to "System/Archives" for the configuration.

.. image:: /images/archiving-setup-config.png

The "Configuration" section on the page shows the current configuration values. You can change the configuration by pressing "Update configuration".

.. image:: /images/archiving-setup-config-dialog.png

Archive Options
---------------

There are several configuration options to configure the archive plugin.

.. list-table:: Configuration Options
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - Archive Path
      - Directory on the **master** node where the archive files will be stored.
    * - Max Segment Size
      - Maximum size (in *bytes*) of archive segment files.
    * - Compression Type
      - Compression type that will be used to compress the archives.
    * - Restore index batch size
      - Elasticsearch batch size when restoring archive files.

.. _archive-config-option-archive-path:

Archive Path
^^^^^^^^^^^^

The archived indices will be stored in the *Archive Path* directory. This
directory **needs to be writable for the Graylog server process** so the files
can be stored.

.. note:: Only the **master** node needs access to the *Archive Path* directory because the archiving process runs on the master node.

We recommend to put the *Archive Path* directory onto a **separate disk or partition** to avoid
any negative impact on the message processing should the archiving fill up
the disk.

Max Segment Size
^^^^^^^^^^^^^^^^^

When archiving an index, the archive job writes the data into segments.
The *Max Segment Size* setting sets the size limit for each of these data
segments.

This allows control over the file size of the segment files to make it
possible to process them with tools which have a size limit for files.

Once the size limit is reached, a new segment file will be started.

Example::

   /path/to/archive/
     graylog_201/
       archive-metadata.json
       archive-segment-0.gz
       archive-segment-1.gz
       archive-segment-2.gz

.. _archive-config-option-compression-type:

Compression Type
^^^^^^^^^^^^^^^^

Archives will be compressed with gzip by default. This option can be changed to use a different compression type.

The selected compression type has a big impact on the time it takes to archive an index. Gzip for example is pretty
slow but has a great compression rate. Snappy and LZ4 are way faster but the archives will be bigger.

Here is a comparison between the available compression algorithms with test data.

.. list-table:: Compression Type Comparison
    :header-rows: 1
    :widths: 7 5 5 15

    * - Type
      - Index Size
      - Archive Size
      - Duration
    * - gzip
      - 1 GB
      - 134 MB
      - 15 minutes, 23 seconds
    * - Snappy
      - 1 GB
      - 291 MB
      - 2 minutes, 31 seconds
    * - LZ4
      - 1 GB
      - 266 MB
      - 2 minutes, 25 seconds

.. note:: Results with your data may vary! Make sure to test the different compression types
          to find the one that is best for your data.

.. _archive-config-option-restore-batch-size:

Restore Index Batch Size
^^^^^^^^^^^^^^^^^^^^^^^^

This setting controls the batch size for re-indexing archive data into
Elasticsearch. When set to ``1000``, the restore job will re-index the
archived data in document batches of 1000.

You can use this setting to control the speed of the restore process and also
how much load it will generate on the Elasticsearch cluster. The **higher**
the batch size, the **faster** the restore will progress and the **more** load
will be put on your Elasticsearch cluster in addition to the normal message
processing.

Make sure to tune this **carefully** to avoid any negative impact on your
message indexing throughput and search speed!

.. _archive-config-index-retention:

Index Retention
---------------

Graylog is using configurable index retention strategies to delete old
indices. By default indices can be *closed* or *deleted* if you have more
than the configured limit.

The archive plugin offers a new index retention strategy that you can configure
to automatically archive an index before closing or deleting it.

Index retention strategies can be configured in the system menu under
"System/Indices". Click "Update configuration" to change the index rotation
and retention strategies.

.. image:: /images/archiving-setup-index-retention-config.png

As with the regular index retention strategies, you can configure a max
number of Elasticsearch indices. Once there are more indices than the
configured limit, the oldest ones will be archived to the *Archive Path* and
then closed or deleted. You can also decide to not do anything (*NONE*) after
archiving an index. In that case **no cleanup of old indices will happen**
and you have to take care of that yourself!
