*********
Changelog
*********

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
