.. _configuring_backup:

******
Backup 
******

When it comes to Backup in a Graylog Setup it is not easy to answer. You need to consider what type of Backup will suite your needs.

Your Graylog Server Setup and Settings are easy to Backup with a `MongoDB dump <https://docs.mongodb.com/manual/reference/program/mongodump/#bin.mongodump>`_ and a filesystem Backup of all configuration files.

The data within your Elasticsearch Cluster can take the advantage of the `Snapshot an Restore <https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html>`_ function that are offered by Elasticsearch.

