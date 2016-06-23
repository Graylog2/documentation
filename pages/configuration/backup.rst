.. _configuring_backup:

******
Backup 
******

When it comes to backup in a Graylog setup it is not easy to answer. You need to consider what type of backup will suite your needs.

Your Graylog Server setup and settings are easy to backup with a `MongoDB dump <https://docs.mongodb.com/manual/reference/program/mongodump/#bin.mongodump>`_ and a filesystem backup of all configuration files.

The data within your Elasticsearch Cluster can take the advantage of the `Snapshot and Restore <https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html>`_ function that are offered by Elasticsearch.

