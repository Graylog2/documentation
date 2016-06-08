*********
Changelog
*********

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
