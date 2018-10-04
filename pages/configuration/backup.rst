.. _configuring_backup:

******
Backup 
******

When it comes to backup in a Graylog setup it is not easy to answer. You need to consider what type of backup will suit your needs.

Your Graylog Server setup and settings are easy to backup with a `MongoDB dump <https://docs.mongodb.com/manual/reference/program/mongodump/#bin.mongodump>`_ and a filesystem backup of all configuration files.

The data within your Elasticsearch Cluster can take the advantage of the `Snapshot and Restore <https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html>`_ function that are offered by Elasticsearch.

Disaster recovery
=================

To be able to restore Graylog after a total System crash you need the Graylog ``server.conf``file - to be exact you need the key you used for ``password_secret`` in the configuration. The second important part is the MongoDB. This database contains all configuration. Possible options how-to `backup MongoDB can be found at the MongoDB documentation <https://docs.mongodb.com/manual/core/backups/#back-up-by-copying-underlying-data-files>`_.

If you need to restore log data, you can do this using the archiving feature of Graylog enterprise or any other elasticsearch backup and restore option. It is not enough to copy the data directories of your Elasticsearch nodes, you might not be able to restore from that.

Elasticsearch and MongoDB are databases, for both you should implement the ability to make a data dump and restore that - if you need want to be able to restore the current state. 
