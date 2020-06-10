*********
Changelog
*********

Graylog Enterprise 3.2.6
========================

Released: 2020-06-10

No changes since 3.2.5.

Graylog Enterprise 3.2.5
========================

Released: 2020-05-19

No changes since 3.2.4.

Graylog Enterprise 3.2.4
========================

Released: 2020-03-19

**Fixed**

- Fix issue with search parameter input fields.
- Fix error exporting a correlation event definition in content packs.

Graylog Enterprise 3.2.3
========================

Released: 2020-03-11

**Fixed**

- Fix issue with custom fields and correlation event definitions.

Graylog Enterprise 3.2.2
========================

Released: 2020-02-20

**Fixed**

- Fix missing rows in message table widget in reports. `Graylog2/graylog2-server#7349 <https://github.com/Graylog2/graylog2-server/issues/7349>`_ `Graylog2/graylog2-server#7492 <https://github.com/Graylog2/graylog2-server/issues/7492>`_
- Don't try to archive indices which have already been archived.

Graylog Enterprise 3.2.1
========================

Released: 2020-02-04

**Fixed**

- Gracefully handle missing dashboards and widgets when collecting parameters for reports. `Graylog2/graylog2-server#7347 <https://github.com/Graylog2/graylog2-server/issues/7347>`_

Graylog Enterprise 3.2.0
========================

Released: 2020-01-14

**Added**

- Dynamic list support for events and alert definition queries.
- Search parameter support for reports.
- MongoDB lookup data adapter.

**Fixed**

- Remove incomplete archive directory when archiving process fails.
- Fix race condition with archive catalog writing.

Graylog Enterprise 3.1.4
========================

Released: 2020-01-14

**Fixed**

- Only write archive metadata if the archiving process succeeded.
- Improve resiliency of widgets in reports.

Graylog Enterprise 3.1.3
========================

Released: 2019-11-06


**Fixed**

- Fix problem with correlating events created by aggregation event definitions.
- Remove incomplete archive directory when archive job fails or is stopped.

Graylog Enterprise 3.1.2
========================

Released: 2019-09-12

No changes since 3.1.1.

Graylog Enterprise 3.1.1
========================

Released: 2019-09-04

No changes since 3.1.0.

Graylog Enterprise 3.1.0
========================

Released: 2019-08-16

**Added**

- Add correlation engine and UI for new alerts and events system.
- Add Enterprise job scheduler implementation.

**Removed**

- Moved views feature to open-source. (except parameter support)

**Fixed**

- Fix report service memory leak.
- Fix auto-completion in drop-down fields.
- Fix rendering of archive configuration page

Graylog Enterprise 3.0.2
========================

Released: 2019-05-03

**Integrations Plugin**

- Improve Graylog Forwarder configuration defaults.
- Improve Graylog Forwarder error handling.
- Update Graylog Forwarder dependencies.

Graylog Enterprise 3.0.1
========================

Released: 2019-04-01

- Fix missing authorization checks in the license management.
- Fix view sharing issue for regular users.
- Fix memory leak in the reporting system.

**Integrations Plugin**

- Add Graylog Forwarder feature.

Graylog Enterprise 3.0.0
========================

Released: 2019-02-14

- Announcement blog post: https://www.graylog.org/post/announcing-graylog-v3-0-ga
- Upgrade notes: :doc:`/pages/upgrade/graylog-3.0`

A detailed changelog is following soon!

**Integrations Plugin**

* Add Script Alert Notification

Graylog Enterprise 2.5.2
========================

Released: 2019-03-15

Plugin: License
---------------

- Add missing permissions to license HTTP API resources.
- Only show upcoming license expiration warning to admin users.

Graylog Enterprise 2.5.1
========================

Released: 2018-12-19

No changes since 2.5.0.

Graylog Enterprise 2.5.0
========================

Released: 2018-11-30

No changes since 2.4.6.

Graylog Enterprise 2.4.7
========================

Released: 2019-03-01

Plugin: License
---------------

* Add missing authorization checks to license resources.

Graylog Enterprise 2.4.6
========================

Released: 2018-07-16

No changes since 2.4.5.

Graylog Enterprise 2.4.5
========================

Released: 2018-05-28

No changes since 2.4.4.

Graylog Enterprise 2.4.4
========================

Released: 2018-05-02

No changes since 2.4.3.

Graylog Enterprise 2.4.3
========================

Released: 2018-01-24

No changes since 2.4.2.

Graylog Enterprise 2.4.2
========================

Released: 2018-01-24

No changes since 2.4.1.

Graylog Enterprise 2.4.1
========================

Released: 2018-01-19

No changes since 2.4.0.

Graylog Enterprise 2.4.0
========================

Released: 2017-12-22

No changes since 2.4.0-rc.2.

Graylog Enterprise 2.4.0-rc.2
=============================

Released: 2017-12-20

No changes since 2.4.0-rc.1.

Graylog Enterprise 2.4.0-rc.1
=============================

Released: 2017-12-19

No changes since 2.4.0-beta.4.

Graylog Enterprise 2.4.0-beta.4
===============================

Released: 2017-12-15

Plugin: License
---------------

* The license page now shows more details about the installed licenses.

Graylog Enterprise 2.4.0-beta.3
===============================

Released: 2017-12-04

No changes since 2.4.0-beta.2.

Graylog Enterprise 2.4.0-beta.2
===============================

Released: 2017-11-07

No changes since 2.4.0-beta.1.

Graylog Enterprise 2.4.0-beta.1
===============================

Released: 2017-10-20

Plugin: Archive
---------------

* Add support for Zstandard compression codec.

Graylog Enterprise 2.3.2
========================

Released: 2017-10-19

Plugin: Archive
---------------

* Fix archive creation for indices with lots of shards.

Graylog Enterprise 2.3.1
========================

Released: 2017-08-25

Plugin: Archive
---------------

* Lots of performance improvements (up to 7 times faster)
* Do not delete an index if not all of its documents have been archived

Graylog Enterprise 2.3.0
========================

Released: 2017-07-26

Plugin: Archive
---------------

* Record checksums for archive segment files
* Add two archive permission roles "admin" and "viewer"
* Allow export of filenames from catalog search

Graylog Enterprise 2.2.3
========================

Released: 2017-04-04

Plugin: Archive
---------------

* Metadata is now stored in MongoDB
* Preparation for storage backend support

Graylog Enterprise 2.2.2
========================

Released: 2017-03-02

Plugin: Audit Log
-----------------

* Extend integration with the Archive plugin

Graylog Enterprise 2.2.1
========================

Released: 2017-02-20

Plugin: Archive
---------------

* Improve stability and smaller UI fixes

Graylog Enterprise 2.2.0
========================

Released: 2017-02-09

Plugin: Archive
---------------

* Improve index set support

Graylog Enterprise 1.2.1
========================

Released: 2017-01-26

Plugin: Archive
---------------

* Prepare the plugin to be compatible with the new default stream.

Plugin: Audit Log
-----------------

* Add support for index sets and fix potential NPEs.
* Smaller UI improvements.

Graylog Enterprise 1.2.0
========================

Released: 2016-09-14

https://www.graylog.org/blog/70-announcing-graylog-enterprise-v1-2


Plugin: Archive
---------------

* Add support for selecting which streams should be included in your archives.


Plugin: Audit Log
-----------------

New plugin to keep track of changes made by users to a Graylog system by automatically saving them in MongoDB.


Graylog Enterprise 1.1
======================

Released: 2016-09-01

* Added support for Graylog 2.1.0.


Graylog Enterprise 1.0.1
========================

Released: 2016-06-08

Bugfix release for the archive plugin.

Plugin: Archive
---------------

Fixed problem when writing multiple archive segments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There was a problem when exceeding the max segment size so that multiple archive
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
