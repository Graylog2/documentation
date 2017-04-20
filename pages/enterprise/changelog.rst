*********
Changelog
*********

Graylog Enterprise 2.2.3
========================

Released: 2017-04-04

Plugin: Archive
---------------

Metadata is now stored in MongoDB
Preparation for storage backend support

Graylog Enterprise 2.2.2
========================

Released: 2017-03-02

Plugin: Audit Log
-----------------

Extend intergation with the Archive plugin

Graylog Enterprise 2.2.1
========================

Released: 2017-02-20

Plugin: Archive
---------------

Improve stability and smaller UI fixes

Graylog Enterprise 2.2.0
========================

Released: 2017-02-09

Plugin: Archive
---------------

Improve index set support

Graylog Enterprise 1.2.1
========================

Released: 2017-01-26

Plugin: Archive
---------------

Prepare for the plugin to be compatible with the new default stream.

Plugin: Audit Log
-----------------

Add support for index sets and fix potential NPEs.
Smaller UI imprevements.

Graylog Enterprise 1.2.0
========================

Released: 2016-09-14

https://www.graylog.org/blog/70-announcing-graylog-enterprise-v1-2


Plugin: Archive
---------------

Add support for selecting which streams should be included in your archives.


Plugin: Audit Log
-----------------

New plugin to keep track of changes made by users to a Graylog system by automatically saving them in MongoDB.


Graylog Enterprise 1.1
======================

Released: 2016-09-01

Added support for Graylog 2.1.0.


Graylog Enterprise 1.0.1
========================

Released: 2016-06-08

Bugfix release for the archive plugin.

Plugin: Archive
---------------

Fixed problem when writing multiple archive segments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There was a problem when exceeding the max segement size so that multiple archive
segments are written. The problem has been fixed and wrongly written segments
can be read again.

Graylog Enterprise 1.0.0
========================

Released: 2016-05-27

Initial Release including the Archive plugin.

Plugin: Archive
---------------

New features since the last beta plugin:

* Support for multiple compression strategies. (Snappy, LZ4, Gzip, None)
