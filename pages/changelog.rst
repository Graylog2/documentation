*********
Changelog
*********

Graylog 1.2.2
=============

Released: 2015-10-27

https://www.graylog.org/graylog-1-2-2-is-now-available/

* Fixed a whitespace issue in the extractor UI. `Graylog2/graylog2-web-interface#1650 <https://github.com/Graylog2/graylog2-web-interface/issues/1650>`_
* Fixed the index description on the indices page. `Graylog2/graylog2-web-interface#1653 <https://github.com/Graylog2/graylog2-web-interface/issues/1653>`_
* Fixed a memory leak in the GELF UDP handler code. (Analysis and fix contributed by @lightpriest and @onyxmaster on GitHub. Thank you!) `Graylog2/graylog2-server#1462 <https://github.com/Graylog2/graylog2-server/issues/1462>`_, `Graylog2/graylog2-server#1488 <https://github.com/Graylog2/graylog2-server/issues/1488>`_
* Improved the LDAP group handling code to handle more LDAP setups. `Graylog2/graylog2-server#1433 <https://github.com/Graylog2/graylog2-server/issues/1433>`_, `Graylog2/graylog2-server#1453 <https://github.com/Graylog2/graylog2-server/issues/1453>`_, `Graylog2/graylog2-server#1491 <https://github.com/Graylog2/graylog2-server/issues/1491>`_, `Graylog2/graylog2-server#1494 <https://github.com/Graylog2/graylog2-server/issues/1494>`_
* Fixed email alerts for users with multiple email addresses. (LDAP setups) `Graylog2/graylog2-server#1439 <https://github.com/Graylog2/graylog2-server/issues/1439>`_, `Graylog2/graylog2-server#1492 <https://github.com/Graylog2/graylog2-server/issues/1492>`_
* Improve index range handling performance. `Graylog2/graylog2-server#1465 <https://github.com/Graylog2/graylog2-server/issues/1465>`_, `Graylog2/graylog2-server#1493 <https://github.com/Graylog2/graylog2-server/issues/1493>`_
* Fixed JSON extractor with null values. `Graylog2/graylog2-server#1475 <https://github.com/Graylog2/graylog2-server/issues/1475>`_, `Graylog2/graylog2-server#1505 <https://github.com/Graylog2/graylog2-server/issues/1505>`_
* Fixed role assignment when updating user via REST API. `Graylog2/graylog2-server#1456 <https://github.com/Graylog2/graylog2-server/issues/1456>`, `Graylog2/graylog2-server#1507 <https://github.com/Graylog2/graylog2-server/issues/1507>`_


Graylog 1.2.1
=============

Released: 2015-09-22

https://www.graylog.org/graylog-1-2-1-is-now-available/

* Fixed various issues around importing and applying content packs `Graylog2/graylog2-server#1423 <https://github.com/Graylog2/graylog2-server/issues/1423>`_, `Graylog2/graylog2-server#1434 <https://github.com/Graylog2/graylog2-server/issues/1434>`_, `Graylog2/graylog2-web-interface#1605 <https://github.com/Graylog2/graylog2-web-interface/issues/1605>`_, `Graylog2/graylog2-web-interface#1614 <https://github.com/Graylog2/graylog2-web-interface/pull/1614>`_
* Fixed loading existing alarm callbacks that had been created with Graylog 1.0.x or earlier `Graylog2/graylog2-server#1428 <https://github.com/Graylog2/graylog2-server/issues/1428>`_
* Fixed compatibility problem with Elasticsearch 1.5.x and earlier `Graylog2/graylog2-server#1426 <https://github.com/Graylog2/graylog2-server/issues/1426>`_
* Fixed handling of statistical functions in field graphs `Graylog2/graylog2-web-interface#1604 <https://github.com/Graylog2/graylog2-web-interface/issues/1604>`_
* Use correct title when adding quick values to a dashboard `Graylog2/graylog2-web-interface#1603 <https://github.com/Graylog2/graylog2-web-interface/issues/1603>`_


Graylog 1.2.0
=============

Released: 2015-09-14

https://www.graylog.org/announcing-graylog-1-2-ga-release-includes-30-new-features/

* Make sure existing role assignments survive on LDAP account sync. `Graylog2/graylog2-server#1405 <https://github.com/Graylog2/graylog2-server/issues/1405>`_ | `Graylog2/graylog2-server#1406 <https://github.com/Graylog2/graylog2-server/pull/1406>`_
* Use memberOf query for ActiveDirectory to speed up LDAP queries. `Graylog2/graylog2-server#1407 <https://github.com/Graylog2/graylog2-server/pull/1407>`_
* Removed disable_index_range_calculation configuration option. `Graylog2/graylog2-server#1411 <https://github.com/Graylog2/graylog2-server/pull/1411>`_
* Avoid potentially long-running Elasticsearch cluster-level operations by only saving an index range if it actually changed. `Graylog2/graylog2-server#1412 <https://github.com/Graylog2/graylog2-server/pull/1412>`_
* Allow editing the roles of LDAP users. `Graylog2/graylog2-web-interface#1598 <https://github.com/Graylog2/graylog2-web-interface/pull/1598>`_
* Improved quick values widget. `Graylog2/graylog2-web-interface#1487 <https://github.com/Graylog2/graylog2-web-interface/issues/1487>`_


Graylog 1.2.0-rc.4
==================

Released: 2015-09-08

https://www.graylog.org/announcing-graylog-1-2-rc-4/

* Deprecated MongoDB storage of internal metrics feature.
* Added customizable LDAP filter for user groups lookup. `Graylog2/graylog2-server#951 <https://github.com/Graylog2/graylog2-server/issues/951>`_
* Allow usage of count and cardinality statistical functions in dashboard widgets. `Graylog2/graylog2-server#1376 <https://github.com/Graylog2/graylog2-server/issues/1376>`_
* Disabled index range recalculation on every index rotation. `Graylog2/graylog2-server#1388 <https://github.com/Graylog2/graylog2-server/pull/1388>`_
* Added automatic migration of user permissions to admin or reader roles. `Graylog2/graylog2-server#1389 <https://github.com/Graylog2/graylog2-server/pull/1389>`_
* Fixed widget problem with invalid timestamps. `Graylog2/graylog2-web-interface#1390 <https://github.com/Graylog2/graylog2-web-interface/issues/1390>`_
* Added config option to enable TLS certificate validation in REST client. `Graylog2/graylog2-server#1393 <https://github.com/Graylog2/graylog2-server/pull/1393>`_
* Fixed rule matching issue in stream routing engine. `Graylog2/graylog2-server#1397 <https://github.com/Graylog2/graylog2-server/pull/1397>`_
* Changed default titles for stream widgets. `Graylog2/graylog2-web-interface#1476 <https://github.com/Graylog2/graylog2-web-interface/issues/1476>`_
* Changed data filters to be case insensitive. `Graylog2/graylog2-web-interface#1585 <https://github.com/Graylog2/graylog2-web-interface/issues/1585>`_
* Improved padding for stack charts. `Graylog2/graylog2-web-interface#1568 <https://github.com/Graylog2/graylog2-web-interface/issues/1568>`_
* Improved resiliency when Elasticsearch is not available. `Graylog2/graylog2-web-interface#1518 <https://github.com/Graylog2/graylog2-web-interface/issues/1518>`_
* Redirect to user edit form after updating a user. `Graylog2/graylog2-web-interface#1588 <https://github.com/Graylog2/graylog2-web-interface/issues/1588>`_
* Improved dashboard widgets error handling. `Graylog2/graylog2-web-interface#1590 <https://github.com/Graylog2/graylog2-web-interface/pull/1590>`_
* Fixed timing issue in streams UI. `Graylog2/graylog2-web-interface#1490 <https://github.com/Graylog2/graylog2-web-interface/issues/1490>`_
* Improved indices overview page. `Graylog2/graylog2-web-interface#1593 <https://github.com/Graylog2/graylog2-web-interface/pull/1593>`_
* Fixed browser back button behavior. `Graylog2/graylog2-web-interface#1594 <https://github.com/Graylog2/graylog2-web-interface/pull/1594>`_
* Fixed accidental type conversion for number configuration fields in alarmcallback plugins. `Graylog2/graylog2-web-interface#1596 <https://github.com/Graylog2/graylog2-web-interface/issues/1596>`_
* Fixed data type problem for extracted timestamps via grok. `Graylog2/graylog2-server#1403 <https://github.com/Graylog2/graylog2-server/pull/1403>`_


Graylog 1.2.0-rc.2
==================

Released: 2015-08-31

https://www.graylog.org/announcing-graylog-1-2-rc/

* Implement global Elasticsearch timeout and add ``elasticsearch_request_timeout`` configuration setting. `Graylog2/graylog2-server#1220 <https://github.com/Graylog2/graylog2-server/issues/1220>`_
* Fixed lots of documentation links. `Graylog2/graylog2-server#1238 <https://github.com/Graylog2/graylog2-server/pull/1238>`_
* Groovy shell server removed. `Graylog2/graylog2-server#1266 <https://github.com/Graylog2/graylog2-server/pull/1266>`_
* Lots of index range calculation fixes. `Graylog2/graylog2-server#1274 <https://github.com/Graylog2/graylog2-server/pull/1274>`_
* New Raw AMQP input. `Graylog2/graylog2-server#1280 <https://github.com/Graylog2/graylog2-server/pull/1280>`_
* New Syslog AMQP input. `Graylog2/graylog2-server#1280 <https://github.com/Graylog2/graylog2-server/pull/1280>`_
* Updated bundled Elasticsearch to 1.7.1.
* The fields in configuration dialogs for inputs and outputs are now ordered. `Graylog2/graylog2-server#1282 <https://github.com/Graylog2/graylog2-server/issues/1282>`_
* Allow server startup without working Elasticsearch cluster. `Graylog2/graylog2-server#1136 <https://github.com/Graylog2/graylog2-server/issues/1136>`_, `Graylog2/graylog2-server#1289 <https://github.com/Graylog2/graylog2-server/pull/1289>`_
* Added OR operator to stream matching. `Graylog2/graylog2-server#1292 <https://github.com/Graylog2/graylog2-server/pull/1292>`_, `Graylog2/graylog2-web#1552 <https://github.com/Graylog2/graylog2-web-interface/pull/1552>`_
* New stream router engine with better stream matching performance. `Graylog2/graylog2-server#1305 <https://github.com/Graylog2/graylog2-server/pull/1305>`_, `Graylog2/graylog2-server#1309 <https://github.com/Graylog2/graylog2-server/pull/1309>`_
* Grok pattern import/export support for content packs. `Graylog2/graylog2-server#1300 <https://github.com/Graylog2/graylog2-server/pull/1300>`_, `Graylog2/graylog2-web#1527 <https://github.com/Graylog2/graylog2-web-interface/pull/1527>`_
* Added MessageListCodec interface for codec implementations that can decode multiple messages from one raw message. `Graylog2/graylog2-server#1307 <https://github.com/Graylog2/graylog2-server/pull/1307>`_
* Added keepalive configuration option for all TCP transports. `Graylog2/graylog2-server#1287 <https://github.com/Graylog2/graylog2-server/issues/1287>`_, `Graylog2/graylog2-server#1318 <https://github.com/Graylog2/graylog2-server/pull/1318>`_
* Support for roles and LDAP groups. `Graylog2/graylog2-server#1321 <https://github.com/Graylog2/graylog2-server/issues/1321>`_, `Graylog2/graylog2-server#951 <https://github.com/Graylog2/graylog2-server/issues/951>`_
* Added timezone configuration option to date converter. `Graylog2/graylog2-server#1320 <https://github.com/Graylog2/graylog2-server/issues/1320>`_, `Graylog2/graylog2-server#1324 <https://github.com/Graylog2/graylog2-server/pull/1324>`_
* Added alarmcallback history feature. `Graylog2/graylog2-server#1313 <https://github.com/Graylog2/graylog2-server/pull/1313>`_, `Graylog2/graylog2-web#1537 <https://github.com/Graylog2/graylog2-web-interface/pull/1537>`_
* Added more configuration options to GELF output. (TCP settings, TLS support) `Graylog2/graylog2-server#1337 <https://github.com/Graylog2/graylog2-server/pull/1337>`_, `Graylog2/graylog2-server#979 <https://github.com/Graylog2/graylog2-server/issues/979>`_
* Store timestamp and some other internal fields in Elasticsearch as doc values. Removed "elasticsearch_store_timestamps_as_doc_values" option from configuration file. `Graylog2/graylog2-server#1335 <https://github.com/Graylog2/graylog2-server/issues/1335>`_, `Graylog2/graylog2-server#1342 <https://github.com/Graylog2/graylog2-server/pull/1342>`_
* Added TLS support for GELF HTTP input. `Graylog2/graylog2-server#1348 <https://github.com/Graylog2/graylog2-server/pull/1348>`_
* Added JSON extractor. `Graylog2/graylog2-server#632 <https://github.com/Graylog2/graylog2-server/issues/632>`_, `Graylog2/graylog2-server#1355 <https://github.com/Graylog2/graylog2-server/pull/1355>`_, `Graylog2/graylog2-web#1555 <https://github.com/Graylog2/graylog2-web-interface/pull/1555>`_
* Added support for TLS client certificate authentication to all TCP based inputs. `Graylog2/graylog2-server#1357 <https://github.com/Graylog2/graylog2-server/pull/1357>`_, `Graylog2/graylog2-server#1363 <https://github.com/Graylog2/graylog2-server/pull/1363>`_
* Added stacked chart widget. `Graylog2/graylog2-server#1284 <https://github.com/Graylog2/graylog2-server/pull/1284>`_, `Graylog2/graylog2-web#1513 <https://github.com/Graylog2/graylog2-web-interface/pull/1513>`_
* Added cardinality option to field histograms. `Graylog2/graylog2-web#1529 <https://github.com/Graylog2/graylog2-web-interface/pull/1529>`_, `Graylog2/graylog2-server#1303 <https://github.com/Graylog2/graylog2-server/pull/1303>`_
* Lots of dashboard improvements. `Graylog2/graylog2-web#1550 <https://github.com/Graylog2/graylog2-web-interface/pull/1550>`_
* Replaced Gulp with Webpack. `Graylog2/graylog2-web#1548 <https://github.com/Graylog2/graylog2-web-interface/pull/1548>`_
* Updated to Play 2.3.10.



Graylog 1.1.6
=============

Released: 2015-08-06

https://www.graylog.org/graylog-1-1-6-released/

* Fix edge case in ``SyslogOctetCountFrameDecoder`` which caused the Syslog TCP input to reset connections (`Graylog2/graylog2-server#1105 <https://github.com/Graylog2/graylog2-server/issues/1105>`_, `Graylog2/graylog2-server#1339 <https://github.com/Graylog2/graylog2-server/issues/1339>`_)
* Properly log errors in the Netty channel pipeline (`Graylog2/graylog2-server#1340 <https://github.com/Graylog2/graylog2-server/issues/1340>`_)
* Prevent creation of invalid alert conditions (`Graylog2/graylog2-server#1332 <https://github.com/Graylog2/graylog2-server/issues/1332>`_)
* Upgrade to `Elasticsearch 1.6.2 <https://www.elastic.co/blog/elasticsearch-1-7-1-and-1-6-2-released>`_


Graylog 1.1.5
=============

Released: 2015-07-27

https://www.graylog.org/graylog-1-1-5-released/

* Improve handling of exceptions in the JournallingMessageHandler (`Graylog2/graylog2-server#1286 <https://github.com/Graylog2/graylog2-server/pull/1286>`_)
* Upgrade to Elasticsearch 1.6.1 (`Graylog2/graylog2-server#1312 <https://github.com/Graylog2/graylog2-server/pull/1312>`_)
* Remove hard-coded limit for UDP receive buffer size (`Graylog2/graylog2-server#1290 <https://github.com/Graylog2/graylog2-server/pull/1290>`_)
* Ensure that ``elasticsearch_index_prefix`` is lowercase (`commit 2173225 <https://github.com/Graylog2/graylog2-server/commit/21732256ac36f9567be1605f533ebbba7f363468>`_ )
* Add configuration option for time zone to ``Date`` converter (`Graylog2/graylog2-server#1320 <https://github.com/Graylog2/graylog2-server/issues/1320>`_)
* Fix NPE if the disk journal is disabled on a node (`Graylog2/graylog2-web-interface#1520 <https://github.com/Graylog2/graylog2-web-interface/pull/1520>`_)
* Statistic and Chart error: Adding time zone offset caused overflow (`Graylog2/graylog2-server#1257 <https://github.com/Graylog2/graylog2-server/issues/1257>`_)
* Ignore stream alerts and throughput on serialize (`Graylog2/graylog2-server#1309 <https://github.com/Graylog2/graylog2-server/pull/1309>`_)
* Fix dynamic keyword time-ranges for dashboard widgets created from content packs (`Graylog2/graylog2-server#1308 <https://github.com/Graylog2/graylog2-server/pull/1308>`_)
* Upgraded Anonymous Usage Statistics plugin to version 1.1.1


Graylog 1.1.4
=============

Released: 2015-06-30

https://www.graylog.org/graylog-v1-1-4-is-now-available/

* Make heartbeat timeout option for AmqpTransport optional. `Graylog2/graylog2-server#1010 <https://github.com/Graylog2/graylog2-server/issues/1010>`_
* Export as CSV on stream fails with "Invalid range type provided." `Graylog2/graylog2-web-interface#1504 <https://github.com/Graylog2/graylog2-web-interface/issues/1504>`_


Graylog 1.1.3
=============

Released: 2015-06-19

https://www.graylog.org/graylog-v1-1-3-is-now-available/

* Log error message early if there is a MongoDB connection error. `Graylog2/graylog2-server#1249 <https://github.com/Graylog2/graylog2-server/issues/1249>`_
* Fixed field content value alert condition. `Graylog2/graylog2-server#1245 <https://github.com/Graylog2/graylog2-server/issues/1245>`_
* Extend warning about SO_RCVBUF size to UDP inputs. `Graylog2/graylog2-server#1243 <https://github.com/Graylog2/graylog2-server/issues/1243>`_
* Scroll on button dropdowns. `Graylog2/graylog2-web-interface#1477 <https://github.com/Graylog2/graylog2-web-interface/issues/1477>`_
* Normalize graph widget numbers before drawing them. `Graylog2/graylog2-web-interface#1479 <https://github.com/Graylog2/graylog2-web-interface/issues/1479>`_
* Fix highlight result checkbox position on old Firefox. `Graylog2/graylog2-web-interface#1440 <https://github.com/Graylog2/graylog2-web-interface/issues/1440>`_
* Unescape terms added to search bar. `Graylog2/graylog2-web-interface#1484 <https://github.com/Graylog2/graylog2-web-interface/issues/1484>`_
* Load another message in edit extractor page not working. `Graylog2/graylog2-web-interface#1488 <https://github.com/Graylog2/graylog2-web-interface/issues/1488>`_
* Reader users aren't able to export search results as CSV. `Graylog2/graylog2-web-interface#1492 <https://github.com/Graylog2/graylog2-web-interface/issues/1492>`_
* List of streams not loaded on message details page. `Graylog2/graylog2-web-interface#1496 <https://github.com/Graylog2/graylog2-web-interface/issues/1496>`_


Graylog 1.1.2
=============

Released: 2015-06-10

https://www.graylog.org/graylog-v1-1-2-is-now-available/

* Get rid of NoSuchElementException if index alias doesn't exist. `Graylog2/graylog2-server#1218 <https://github.com/Graylog2/graylog2-server/issues/1218>`_
* Make Alarm Callbacks API compatible to Graylog 1.0.x again. `Graylog2/graylog2-server#1221 <https://github.com/Graylog2/graylog2-server/issues/1221>`_, `Graylog2/graylog2-server#1222 <https://github.com/Graylog2/graylog2-server/issues/1222>`_, `Graylog2/graylog2-server#1224 <https://github.com/Graylog2/graylog2-server/issues/1224>`_
* Fixed issues with natural language parser for keyword time range. `Graylog2/graylog2-server#1226 <https://github.com/Graylog2/graylog2-server/issues/1226>`_
* Unable to write Graylog metrics to MongoDB `Graylog2/graylog2-server#1228 <https://github.com/Graylog2/graylog2-server/issues/1228>`_
* Unable to delete user. `Graylog2/graylog2-server#1209 <https://github.com/Graylog2/graylog2-server/issues/1209>`_
* Unable to unpause streams, dispite editing permissions. `Graylog2/graylog2-web-interface#1456 <https://github.com/Graylog2/graylog2-web-interface/issues/1456>`_
* Choose quick values widget size dynamically. `Graylog2/graylog2-web-interface#1422 <https://github.com/Graylog2/graylog2-web-interface/issues/1422>`_
* Default field sort order is not guaranteed after reload. `Graylog2/graylog2-web-interface#1436 <https://github.com/Graylog2/graylog2-web-interface/issues/1436>`_
* Toggling all fields in search list throws error and breaks pagination. `Graylog2/graylog2-web-interface#1434 <https://github.com/Graylog2/graylog2-web-interface/issues/1434>`_
* Improve multi-line log messages support. `Graylog2/graylog2-web-interface#612 <https://github.com/Graylog2/graylog2-web-interface/issues/612>`_
* NPE when clicking a message from a deleted input on a stopped node. `Graylog2/graylog2-web-interface#1444 <https://github.com/Graylog2/graylog2-web-interface/issues/1444>`_
* Auto created search syntax must use quotes for values with whitespaces in them. `Graylog2/graylog2-web-interface#1448 <https://github.com/Graylog2/graylog2-web-interface/issues/1448>`_
* Quick Values doesn't update for new field. `Graylog2/graylog2-web-interface#1438 <https://github.com/Graylog2/graylog2-web-interface/issues/1438>`_
* New Quick Values list too large. `Graylog2/graylog2-web-interface#1442 <https://github.com/Graylog2/graylog2-web-interface/issues/1442>`_
* Unloading referenced alarm callback plugin breaks alarm callback listing. `Graylog2/graylog2-web-interface#1450 <https://github.com/Graylog2/graylog2-web-interface/issues/1450>`_
* Add to search button doesn't work as expected for "level" field. `Graylog2/graylog2-web-interface#1453 <https://github.com/Graylog2/graylog2-web-interface/issues/1453>`_
* Treat "*" query as empty query. `Graylog2/graylog2-web-interface#1420 <https://github.com/Graylog2/graylog2-web-interface/issues/1420>`_
* Improve title overflow on widgets. `Graylog2/graylog2-web-interface#1430 <https://github.com/Graylog2/graylog2-web-interface/issues/1430>`_
* Convert NaN to 0 on histograms. `Graylog2/graylog2-web-interface#1417 <https://github.com/Graylog2/graylog2-web-interface/issues/1417>`_
* "&lt;&gt;" values in fields are unescaped and don't display in Quick Values. `Graylog2/graylog2-web-interface#1455 <https://github.com/Graylog2/graylog2-web-interface/issues/1455>`_
* New quickvalues are not showing number of terms. `Graylog2/graylog2-web-interface#1411 <https://github.com/Graylog2/graylog2-web-interface/issues/1411>`_
* Default index for split &amp; index extractor results in an error. `Graylog2/graylog2-web-interface#1464 <https://github.com/Graylog2/graylog2-web-interface/issues/1464>`_
* Improve behaviour when field graph fails to load. `Graylog2/graylog2-web-interface#1276 <https://github.com/Graylog2/graylog2-web-interface/issues/1276>`_
* Unable to unpause streams, dispite editing permissions. `Graylog2/graylog2-web-interface#1456 <https://github.com/Graylog2/graylog2-web-interface/issues/1456>`_
* Wrong initial size of quick values pie chart. `Graylog2/graylog2-web-interface#1469 <https://github.com/Graylog2/graylog2-web-interface/issues/1469>`_
* Problems refreshing data on quick values pie chart. `Graylog2/graylog2-web-interface#1470 <https://github.com/Graylog2/graylog2-web-interface/issues/1470>`_
* Ignore streams with no permissions on message details. `Graylog2/graylog2-web-interface#1472 <https://github.com/Graylog2/graylog2-web-interface/issues/1472>`_


Graylog 1.1.1
=============

Released: 2015-06-05

https://www.graylog.org/graylog-v1-1-1-is-now-available/

* Fix problem with missing alarmcallbacks. `Graylog2/graylog2-server#1214 <https://github.com/Graylog2/graylog2-server/issues/1214>`_
* Add additional newline between messages to alert email. `Graylog2/graylog2-server#1216 <https://github.com/Graylog2/graylog2-server/issues/1216>`_
* Fix incorrect index range calculation. `Graylog2/graylog2-server#1217 <https://github.com/Graylog2/graylog2-server/issues/1217>`_, `Graylog2/graylog2-web-interface#1266 <https://github.com/Graylog2/graylog2-web-interface/issues/1266>`_
* Fix sidebar auto-height on old Firefox versions. `Graylog2/graylog2-web-interface#1410 <https://github.com/Graylog2/graylog2-web-interface/issues/1410>`_
* Fix "create one now" link on stream list page. `Graylog2/graylog2-web-interface#1424 <https://github.com/Graylog2/graylog2-web-interface/issues/1424>`_
* Do not update StreamThroughput when unmounted. `Graylog2/graylog2-web-interface#1428 <https://github.com/Graylog2/graylog2-web-interface/issues/1428>`_
* Fix position of alert annotations in search result histogram. `Graylog2/graylog2-web-interface#1421 <https://github.com/Graylog2/graylog2-web-interface/issues/1421>`_
* Fix NPE when searching. `Graylog2/graylog2-web-interface#1212 <https://github.com/Graylog2/graylog2-web-interface/issues/1212>`_
* Hide unlock dashboard link for reader users. `Graylog2/graylog2-web-interface#1429 <https://github.com/Graylog2/graylog2-web-interface/issues/1429>`_
* Open radio documentation link on a new window. `Graylog2/graylog2-web-interface#1427 <https://github.com/Graylog2/graylog2-web-interface/issues/1427>`_
* Use radio node page on message details. `Graylog2/graylog2-web-interface#1423 <https://github.com/Graylog2/graylog2-web-interface/issues/1423>`_


Graylog 1.1.0
=============

Released: 2015-06-04

https://www.graylog.org/graylog-1-1-is-now-generally-available/

* Properly set ``node_id`` on message input `Graylog2/graylog2-server#1210 <https://github.com/Graylog2/graylog2-server/issues/1210>`_
* Fixed handling of booleans in configuration forms in the web interface
* Various design fixes in the web interface


Graylog 1.1.0-rc.3
==================

Released: 2015-06-02

https://www.graylog.org/graylog-v1-1-rc3-is-now-available/

* Unbreak server startup with collector thresholds set. `Graylog2/graylog2-server#1194 <https://github.com/Graylog2/graylog2-server/issues/1194>`_
* Adding verbal alert description to alert email templates and subject line defaults. `Graylog2/graylog2-server#1158 <https://github.com/Graylog2/graylog2-server/issues/1158>`_
* Fix message backlog in default body template in FormattedEmailAlertSender. `Graylog2/graylog2-server#1163 <https://github.com/Graylog2/graylog2-server/issues/1163>`_
* Make RawMessageEvent's fields volatile to guard against cross-cpu visibility issues. `Graylog2/graylog2-server#1207 <https://github.com/Graylog2/graylog2-server/issues/1207>`_
* Set default for "disable_index_range_calculation" to "true".
* Passing in value to text area fields in configuration forms. `Graylog2/graylog2-web-interface#1340 <https://github.com/Graylog2/graylog2-web-interface/issues/1340>`_
* Stream list has no loading spinner. `Graylog2/graylog2-web-interface#1309 <https://github.com/Graylog2/graylog2-web-interface/issues/1309>`_
* Showing a helpful notification when there are no active/inactive collectors. `Graylog2/graylog2-web-interface#1302 <https://github.com/Graylog2/graylog2-web-interface/issues/1302>`_
* Improve behavior when field graphs are stacked. `Graylog2/graylog2-web-interface#1348 <https://github.com/Graylog2/graylog2-web-interface/issues/1348>`_
* Keep new lines added by users on alert callbacks. `Graylog2/graylog2-web-interface#1270 <https://github.com/Graylog2/graylog2-web-interface/issues/1270>`_
* Fix duplicate metrics reporting if two components subscribed to the same metric on the same page. `Graylog2/graylog2-server#1199 <https://github.com/Graylog2/graylog2-server/issues/1199>`_
* Make sidebar visible on small screens. `Graylog2/graylog2-web-interface#1390 <https://github.com/Graylog2/graylog2-web-interface/issues/1390>`_
* Showing warning and disabling edit button for output if plugin is missing. `Graylog2/graylog2-web-interface#1185 <https://github.com/Graylog2/graylog2-web-interface/issues/1185>`_
* Using formatted fields in old message loader. `Graylog2/graylog2-web-interface#1393 <https://github.com/Graylog2/graylog2-web-interface/issues/1393>`_
* Several styling and UX improvements


Graylog 1.1.0-rc.1
==================

Released: 2015-05-27

https://www.graylog.org/graylog-v1-1-rc1-is-now-available/

* Unable to send email alerts. `Graylog2/graylog2-web-interface#1346 <https://github.com/Graylog2/graylog2-web-interface/issues/1346>`_
* "Show messages from this collector view" displays no messages. `Graylog2/graylog2-web-interface#1334 <https://github.com/Graylog2/graylog2-web-interface/issues/1334>`_
* Exception error in search page when using escaped characters. `Graylog2/graylog2-web-interface#1356 <https://github.com/Graylog2/graylog2-web-interface/issues/1356>`_
* Wrong timestamp on stream rule editor. `Graylog2/graylog2-web-interface#1328 <https://github.com/Graylog2/graylog2-web-interface/issues/1328>`_
* Quickvalue values are not linked to update search query. `Graylog2/graylog2-web-interface#1296 <https://github.com/Graylog2/graylog2-web-interface/issues/1296>`_
* Stream list has no loading spinner. `Graylog2/graylog2-web-interface#1309 <https://github.com/Graylog2/graylog2-web-interface/issues/1309>`_
* Collector list with only inactive collectors is confusing. `Graylog2/graylog2-web-interface#1302 <https://github.com/Graylog2/graylog2-web-interface/issues/1302>`_
* Update sockjs-client to 1.0.0. `Graylog2/graylog2-web-interface#1344 <https://github.com/Graylog2/graylog2-web-interface/issues/1344>`_
* Scroll to search bar when new query term is added. `Graylog2/graylog2-web-interface#1284 <https://github.com/Graylog2/graylog2-web-interface/issues/1284>`_
* Scroll to quick values if not visible. `Graylog2/graylog2-web-interface#1284 <https://github.com/Graylog2/graylog2-web-interface/issues/1284>`_
* Scroll to newly created field graphs. `Graylog2/graylog2-web-interface#1284 <https://github.com/Graylog2/graylog2-web-interface/issues/1284>`_
* Problems with websockets and even xhr streaming. `Graylog2/graylog2-web-interface#1344 <https://github.com/Graylog2/graylog2-web-interface/issues/1344>`_, `Graylog2/graylog2-web-interface#1353 <https://github.com/Graylog2/graylog2-web-interface/issues/1353>`_, `Graylog2/graylog2-web-interface#1338 <https://github.com/Graylog2/graylog2-web-interface/issues/1338>`_, `Graylog2/graylog2-web-interface#1322 <https://github.com/Graylog2/graylog2-web-interface/issues/1322>`_
* Add to search bar not working on sources tab. `Graylog2/graylog2-web-interface#1350 <https://github.com/Graylog2/graylog2-web-interface/issues/1350>`_
* Make field graphs work with streams. `Graylog2/graylog2-web-interface#1352 <https://github.com/Graylog2/graylog2-web-interface/issues/1352>`_
* Improved page design on outputs page. `Graylog2/graylog2-web-interface#1236 <https://github.com/Graylog2/graylog2-web-interface/issues/1236>`_
* Set startpage button missing for dashboards. `Graylog2/graylog2-web-interface#1345 <https://github.com/Graylog2/graylog2-web-interface/issues/1345>`_
* Generating chart for http response code is broken. `Graylog2/graylog2-web-interface#1358 <https://github.com/Graylog2/graylog2-web-interface/issues/1358>`_


Graylog 1.1.0-beta.3
====================

Released: 2015-05-27

https://www.graylog.org/graylog-1-1-beta-3-is-now-available/

* Kafka inputs now support syslog, GELF and raw messages `Graylog2/graylog2-server#322 <https://github.com/Graylog2/graylog2-server/issues/322>`_
* Configurable timezone for the flexdate converter in extractors. `Graylog2/graylog2-server#1166 <https://github.com/Graylog2/graylog2-server/issues/1166>`_
* Allow decimal values for greater/smaller stream rules. `Graylog2/graylog2-server#1101 <https://github.com/Graylog2/graylog2-server/issues/1101>`_
* New configuration file option to control the default widget cache time. `Graylog2/graylog2-server#1170 <https://github.com/Graylog2/graylog2-server/issues/1170>`_
* Expose heartbeat configuration for AMQP inputs. `Graylog2/graylog2-server#1010 <https://github.com/Graylog2/graylog2-server/issues/1010>`_
* New alert condition to alert on field content. `Graylog2/graylog2-server#537 <https://github.com/Graylog2/graylog2-server/issues/537>`_
* Add <code>-Dwebsockets.enabled=false</code> option for the web interface to disable websockets. `Graylog2/graylog2-web-interface#1322 <https://github.com/Graylog2/graylog2-web-interface/issues/1322>`_
* Clicking the Graylog logo redirects to the custom startpage now. `Graylog2/graylog2-web-interface#1315 <https://github.com/Graylog2/graylog2-web-interface/issues/1315>`_
* Improved reset and filter feature in sources tab. `Graylog2/graylog2-web-interface#1337 <https://github.com/Graylog2/graylog2-web-interface/issues/1337>`_
* Fixed issue with stopping Kafka based inputs. `Graylog2/graylog2-server#1171 <https://github.com/Graylog2/graylog2-server/issues/1171>`_
* System throughput resource was always returning 0. `Graylog2/graylog2-web-interface#1313 <https://github.com/Graylog2/graylog2-web-interface/issues/1313>`_
* MongoDB configuration problem with replica sets. `Graylog2/graylog2-server#1173 <https://github.com/Graylog2/graylog2-server/issues/1173>`_
* Syslog parser did not strip empty structured data fields. `Graylog2/graylog2-server#1161 <https://github.com/Graylog2/graylog2-server/issues/1161>`_
* Input metrics did not update after input has been stopped and started again. `Graylog2/graylog2-server#1187 <https://github.com/Graylog2/graylog2-server/issues/1187>`_
* NullPointerException with existing inputs in database fixed. `Graylog2/graylog2-web-interface#1312 <https://github.com/Graylog2/graylog2-web-interface/issues/1312>`_
* Improved browser input validation for several browsers. `Graylog2/graylog2-web-interface#1318 <https://github.com/Graylog2/graylog2-web-interface/issues/1318>`_
* Grok pattern upload did not work correctly. `Graylog2/graylog2-web-interface#1321 <https://github.com/Graylog2/graylog2-web-interface/issues/1321>`_
* Internet Explorer 9 fixes. `Graylog2/graylog2-web-interface#1319 <https://github.com/Graylog2/graylog2-web-interface/issues/1319>`_, `Graylog2/graylog2-web-interface#1320 <https://github.com/Graylog2/graylog2-web-interface/issues/1320>`_
* Quick values feature did not work with reader users. `Graylog2/graylog2-server#1169 <https://github.com/Graylog2/graylog2-server/issues/1169>`_
* Replay link for keyword widgets was broken. `Graylog2/graylog2-web-interface#1323 <https://github.com/Graylog2/graylog2-web-interface/issues/1323>`_
* Provide visual feedback when expanding message details. `Graylog2/graylog2-web-interface#1283 <https://github.com/Graylog2/graylog2-web-interface/issues/1283>`_
* Allow filtering of saved searches again. `Graylog2/graylog2-web-interface#1277 <https://github.com/Graylog2/graylog2-web-interface/issues/1277>`_
* Add back “Show details” link for global input metrics. `Graylog2/graylog2-server#1168 <https://github.com/Graylog2/graylog2-server/issues/1168>`_
* Provide visual feedback when dashboard widgets are loading. `Graylog2/graylog2-web-interface#1324 <https://github.com/Graylog2/graylog2-web-interface/issues/1324>`_
* Restore preview for keyword time range selector. `Graylog2/graylog2-web-interface#1280 <https://github.com/Graylog2/graylog2-web-interface/issues/1280>`_
* Fixed issue where widgets loading data looked empty. `Graylog2/graylog2-web-interface#1324 <https://github.com/Graylog2/graylog2-web-interface/issues/1324>`_


Graylog 1.1.0-beta.2
====================

Released: 2015-05-20

https://www.graylog.org/graylog-1-1-beta-is-now-available/

* CSV output streaming support including full text message
* Simplified MongoDB configuration with URI support
* Improved tokenizer for extractors
* Configurable UDP buffer size for incoming messages
* Enhanced Grok support with type conversions (integers, doubles and dates)
* Elasticsearch 1.5.2 support
* Added support for integrated Log Collector
* Search auto-complete
* Manual widget resize
* Auto resize of widgets based on screen size
* Faster search results
* Moved search filter for usability
* Updated several icons to text boxes for usability
* Search highlight toggle
* Pie charts (Stacked charts are coming too!)
* Improved stream management
* Output plugin and Alarm callback edit support
* Dashboard widget search edit
* Dashboard widget direct search button
* Dashboard background update support for better performance
* Log collector status UI


Graylog 1.0.2
=============

Released: 2015-04-28

https://www.graylog.org/graylog-v1-0-2-has-been-released/

* Regular expression and Grok test failed when example message is a JSON document or contains special characters (`Graylog2/graylog2-web-interface#1190 <https://github.com/Graylog2/graylog2-web-interface/issues/1190>`_, `Graylog2/graylog2-web-interface#1195 <https://github.com/Graylog2/graylog2-web-interface/issues/1195>`_)
* "Show message terms" was broken (`Graylog2/graylog2-web-interface#1168 <https://github.com/Graylog2/graylog2-web-interface/issues/1168>`_)
* Showing message indices was broken (`Graylog2/graylog2-web-interface#1211 <https://github.com/Graylog2/graylog2-web-interface/issues/1211>`_)
* Fixed typo in SetIndexReadOnlyJob (`Graylog2/graylog2-web-interface#1206 <https://github.com/Graylog2/graylog2-web-interface/issues/1206>`_)
* Consistent error messages when trying to create graphs from non-numeric values (`Graylog2/graylog2-web-interface#1210 <https://github.com/Graylog2/graylog2-web-interface/issues/1210>`_)
* Fix message about too few file descriptors for Elasticsearch when number of file descriptors is unlimited (`Graylog2/graylog2-web-interface#1220 <https://github.com/Graylog2/graylog2-web-interface/issues/1220>`_)
* Deleting output globally which was assigned to multiple streams left stale references (`Graylog2/graylog2-server#1113 <https://github.com/Graylog2/graylog2-server/issues/1113>`_)
* Fixed problem with sending alert emails (`Graylog2/graylog2-server#1086 <https://github.com/Graylog2/graylog2-server/issues/1086>`_)
* TokenizerConverter can now handle mixed quoted and un-quoted k/v pairs (`Graylog2/graylog2-server#1083 <https://github.com/Graylog2/graylog2-server/issues/1083>`_)


Graylog 1.0.1
=============

Released: 2015-03-16

https://www.graylog.org/graylog-v1-0-1-has-been-released/

* Properly log stack traces (`Graylog2/graylog2-server#970 <https://github.com/Graylog2/graylog2-server/issues/970>`_)
* Update REST API browser to new Graylog logo
* Avoid spamming the logs if the original input of a message in the disk journal can't be loaded (`Graylog2/graylog2-server#1005 <https://github.com/Graylog2/graylog2-server/issues/1005>`_)
* Allows reader users to see the journal status (`Graylog2/graylog2-server#1009 <https://github.com/Graylog2/graylog2-server/issues/1009>`_)
* Compatibility with MongoDB 3.0 and Wired Tiger storage engine (`Graylog2/graylog2-server#1024 <https://github.com/Graylog2/graylog2-server/issues/1024>`_)
* Respect ``rest_transport_uri`` when generating entity URLs in REST API (`Graylog2/graylog2-server#1020 <https://github.com/Graylog2/graylog2-server/issues/1020>`_)
* Properly map ``NodeNotFoundException`` (`Graylog2/graylog2-web-interface#1137 <https://github.com/Graylog2/graylog2-web-interface/issues/1137>`_)
* Allow replacing all existing Grok patterns on bulk import (`Graylog2/graylog2-web-interface#1150 <https://github.com/Graylog2/graylog2-web-interface/pull/1150>`_)
* Configuration option for discarding messages on error in AMQP inputs (`Graylog2/graylog2-server#1018 <https://github.com/Graylog2/graylog2-server/issues/1018>`_)
* Configuration option of maximum HTTP chunk size for HTTP-based inputs (`Graylog2/graylog2-server#1011 <https://github.com/Graylog2/graylog2-server/issues/1011>`_)
* Clone alarm callbacks when cloning a stream (`Graylog2/graylog2-server#990 <https://github.com/Graylog2/graylog2-server/issues/990>`_)
* Add ``hasField()`` and ``getField()`` methods to ``MessageSummary`` class (`Graylog2/graylog2-server#923 <https://github.com/Graylog2/graylog2-server/issues/923>`_)
* Add per input parse time metrics (`Graylog2/graylog2-web-interface#1106 <https://github.com/Graylog2/graylog2-web-interface/issues/1106>`_)
* Allow the use of https://logging.apache.org/log4j/extras/ log4j-extras classes in log4j configuration (`Graylog2/graylog2-server#1042 <https://github.com/Graylog2/graylog2-server/issues/1042>`_)
* Fix updating of input statistics for Radio nodes (`Graylog2/graylog2-web-interface#1022 <https://github.com/Graylog2/graylog2-web-interface/issues/1122>`_)
* Emit proper error message when a regular expression in an Extractor doesn't match example message (`Graylog2/graylog2-web-interface#1157 <https://github.com/Graylog2/graylog2-web-interface/issues/1157>`_)
* Add additional information to system jobs (`Graylog2/graylog2-server#920 <https://github.com/Graylog2/graylog2-server/issues/920>`_)
* Fix false positive message on LDAP login test (`Graylog2/graylog2-web-interface#1138 <https://github.com/Graylog2/graylog2-web-interface/issues/1138>`_)
* Calculate saved search resolution dynamically (`Graylog2/graylog2-web-interface#943 <https://github.com/Graylog2/graylog2-web-interface/issues/943>`_)
* Only enable LDAP test buttons when data is present (`Graylog2/graylog2-web-interface#1097 <https://github.com/Graylog2/graylog2-web-interface/issues/1097>`_)
* Load more than 1 message on Extractor form (`Graylog2/graylog2-web-interface#1105 <https://github.com/Graylog2/graylog2-web-interface/issues/1105>`_)
* Fix NPE when listing alarm callback using non-existent plugin (`Graylog2/graylog2-web-interface#1152 <https://github.com/Graylog2/graylog2-web-interface/issues/1152>`_)
* Redirect to nodes overview when node is not found (`Graylog2/graylog2-web-interface#1137 <https://github.com/Graylog2/graylog2-web-interface/issues/1137>`_)
* Fix documentation links to integrations and data sources (`Graylog2/graylog2-web-interface#1136 <https://github.com/Graylog2/graylog2-web-interface/issues/1136>`_)
* Prevent accidental indexing of web interface by web crawlers (`Graylog2/graylog2-web-interface#1151 <https://github.com/Graylog2/graylog2-web-interface/issues/1151>`_)
* Validate grok pattern name on the client to avoid duplicate names (`Graylog2/graylog2-server#937 <https://github.com/Graylog2/graylog2-server/issues/937>`_)
* Add message journal usage to nodes overview page (`Graylog2/graylog2-web-interface#1083 <https://github.com/Graylog2/graylog2-web-interface/issues/1083>`_)
* Properly format numbers according to locale (`Graylog2/graylog2-web-interface#1128 <https://github.com/Graylog2/graylog2-web-interface/issues/1128>`_,  `Graylog2/graylog2-web-interface#1129 <https://github.com/Graylog2/graylog2-web-interface/issues/1129>`_)


Graylog 1.0.0
=============

Released: 2015-02-19

https://www.graylog.org/announcing-graylog-v1-0-ga/

* No changes since Graylog 1.0.0-rc.4


Graylog 1.0.0-rc.4
==================

Released: 2015-02-13

https://www.graylog.org/graylog-v1-0-rc-4-has-been-released/

* Default configuration file locations have changed. `Graylog2/graylog2-server#950 <https://github.com/Graylog2/graylog2-server/pull/950>`_
* Improved error handling on search errors. `Graylog2/graylog2-server#954 <https://github.com/Graylog2/graylog2-server/pull/954>`_
* Dynamically update dashboard widgets with keyword range. `Graylog2/graylog2-server#956 <https://github.com/Graylog2/graylog2-server/pull/956>`_, `Graylog2/graylog2-web-interface#958 <https://github.com/Graylog2/graylog2-web-interface/issues/958>`_
* Prevent duplicate loading of plugins. `Graylog2/graylog2-server#948 <https://github.com/Graylog2/graylog2-server/pull/948>`_
* Fixed password handling when editing inputs. `Graylog2/graylog2-web-interface#1103 <https://github.com/Graylog2/graylog2-web-interface/issues/1103>`_
* Fixed issues getting Elasticsearch cluster health. `Graylog2/graylog2-server#953 <https://github.com/Graylog2/graylog2-server/issues/953>`_
* Better error handling for extractor imports. `Graylog2/graylog2-server#942 <https://github.com/Graylog2/graylog2-server/issues/942>`_
* Fixed structured syslog parsing of keys containing special characters. `Graylog2/graylog2-server#845 <https://github.com/Graylog2/graylog2-server/issues/845>`_
* Improved layout on Grok patterns page. `Graylog2/graylog2-web-interface#1109 <https://github.com/Graylog2/graylog2-web-interface/issues/1109>`_
* Improved formatting large numbers. `Graylog2/graylog2-web-interface#1111 <https://github.com/Graylog2/graylog2-web-interface/issues/1111>`_
* New Graylog logo.


Graylog 1.0.0-rc.3
==================

Released: 2015-02-05

https://www.graylog.org/graylog-v1-0-rc-3-has-been-released/

* Fixed compatibility with MongoDB version 2.2. `Graylog2/graylog2-server#941 <https://github.com/Graylog2/graylog2-server/issues/941>`_
* Fixed performance regression in process buffer handling. `Graylog2/graylog2-server#944 <https://github.com/Graylog2/graylog2-server/issues/944>`_
* Fixed data type for the ``max_size_per_index`` config option value. `Graylog2/graylog2-web-interface#1100 <https://github.com/Graylog2/graylog2-web-interface/issues/1100>`_
* Fixed problem with indexer error page. `Graylog2/graylog2-web-interface#1102 <https://github.com/Graylog2/graylog2-web-interface/issues/1102>`_


Graylog 1.0.0-rc.2
==================

Released: 2015-02-04

https://www.graylog.org/graylog-v1-0-rc-2-has-been-released/

* Better Windows compatibility. `Graylog2/graylog2-server#930 <https://github.com/Graylog2/graylog2-server/issues/930>`_
* Added helper methods for the plugin API to simplify plugin development.
* Fixed problem with input removal on radio nodes. `Graylog2/graylog2-server#932 <https://github.com/Graylog2/graylog2-server/issues/932>`_
* Improved buffer information for input, process and output buffers. `Graylog2/graylog2-web-interface#1096 <https://github.com/Graylog2/graylog2-web-interface/issues/1096>`_
* Fixed API return value incompatibility regarding node objects. `Graylog2/graylog2-server#933 <https://github.com/Graylog2/graylog2-server/issues/933>`_
* Fixed reloading of LDAP settings. `Graylog2/graylog2-server#934 <https://github.com/Graylog2/graylog2-server/issues/934>`_
* Fixed ordering of message input state labels. `Graylog2/graylog2-web-interface#1094 <https://github.com/Graylog2/graylog2-web-interface/issues/1094>`_
* Improved error messages for journal related errors. `Graylog2/graylog2-server#931 <https://github.com/Graylog2/graylog2-server/issues/931>`_
* Fixed browser compatibility for stream rules form. `Graylog2/graylog2-web-interface#1095 <https://github.com/Graylog2/graylog2-web-interface/issues/1095>`_
* Improved grok pattern management. `Graylog2/graylog2-web-interface#1099 <https://github.com/Graylog2/graylog2-web-interface/issues/1099>`_, `Graylog2/graylog2-web-interface#1098 <https://github.com/Graylog2/graylog2-web-interface/issues/1098>`_


Graylog 1.0.0-rc.1
==================

Released: 2015-01-28

https://www.graylog.org/graylog-v1-0-rc-1-has-been-released/

* Cleaned up internal metrics when input is terminating. `Graylog2/graylog2-server#915 <https://github.com/Graylog2/graylog2-server/issues/915>`_
* Added Telemetry plugin options to example graylog.conf. `Graylog2/graylog2-server#914 <https://github.com/Graylog2/graylog2-server/issues/914>`_
* Fixed problems with user permissions on streams. `Graylog2/graylog2-web-interface#1058 <https://github.com/Graylog2/graylog2-web-interface/issues/1058>`_
* Added information about different rotation strategies to REST API. `Graylog2/graylog2-server#913 <https://github.com/Graylog2/graylog2-server/issues/913>`_
* Added better error messages for failing inputs. `Graylog2/graylog2-web-interface#1056 <https://github.com/Graylog2/graylog2-web-interface/issues/1056>`_
* Fixed problem with JVM options in ``bin/radioctl`` script. `Graylog2/graylog2-server#918 <https://github.com/Graylog2/graylog2-server/issues/918>`_
* Fixed issue with updating input configuration. `Graylog2/graylog2-server#919 <https://github.com/Graylog2/graylog2-server/issues/919>`_
* Fixed password updating for reader users by the admin. `Graylog2/graylog2-web-interface#1075 <https://github.com/Graylog2/graylog2-web-interface/issues/1075>`_
* Enabled the ``message_journal_enabled`` config option by default. `Graylog2/graylog2-server#924 <https://github.com/Graylog2/graylog2-server/issues/924>`_
* Add REST API endpoint to list reopened indices. `Graylog2/graylog2-web-interface#1072 <https://github.com/Graylog2/graylog2-web-interface/issues/1072>`_
* Fixed problem with GELF stream output. `Graylog2/graylog2-server#921 <https://github.com/Graylog2/graylog2-server/issues/921>`_
* Show an error message on the indices page if the Elasticsearch cluster is not available. `Graylog2/graylog2-web-interface#1070 <https://github.com/Graylog2/graylog2-web-interface/issues/1070>`_
* Fixed a problem with stopping inputs. `Graylog2/graylog2-server#926 <https://github.com/Graylog2/graylog2-server/issues/926>`_
* Changed output configuration display to mask passwords. `Graylog2/graylog2-web-interface#1066 <https://github.com/Graylog2/graylog2-web-interface/issues/1066>`_
* Disabled message journal on radio nodes. `Graylog2/graylog2-server#927 <https://github.com/Graylog2/graylog2-server/issues/927>`_
* Create new message representation format for search results in alarm callback messages. `Graylog2/graylog2-server#923 <https://github.com/Graylog2/graylog2-server/issues/923>`_
* Fixed stream router to update the stream engine if a stream has been changed. `Graylog2/graylog2-server#922 <https://github.com/Graylog2/graylog2-server/issues/922>`_
* Fixed focus problem in stream rule modal windows. `Graylog2/graylog2-web-interface#1063 <https://github.com/Graylog2/graylog2-web-interface/issues/1063>`_
* Do not show new dashboard link for reader users. `Graylog2/graylog2-web-interface#1057 <https://github.com/Graylog2/graylog2-web-interface/issues/1057>`_
* Do not show stream output menu for reader users. `Graylog2/graylog2-web-interface#1059 <https://github.com/Graylog2/graylog2-web-interface/issues/1059>`_
* Do not show user forms of other users for reader users. `Graylog2/graylog2-web-interface#1064 <https://github.com/Graylog2/graylog2-web-interface/issues/1064>`_
* Do not show permission settings in the user profile for reader users. `Graylog2/graylog2-web-interface#1055 <https://github.com/Graylog2/graylog2-web-interface/issues/1055>`_
* Fixed extractor edit form with no messages available. `Graylog2/graylog2-web-interface#1061 <https://github.com/Graylog2/graylog2-web-interface/issues/1061>`_
* Fixed problem with node details page and JVM locale settings. `Graylog2/graylog2-web-interface#1062 <https://github.com/Graylog2/graylog2-web-interface/issues/1062>`_
* Improved page layout for Grok patterns.
* Improved layout for the message journal information. `Graylog2/graylog2-web-interface#1084 <https://github.com/Graylog2/graylog2-web-interface/issues/1084>`_, `Graylog2/graylog2-web-interface#1085 <https://github.com/Graylog2/graylog2-web-interface/issues/1085>`_
* Fixed wording on radio inputs page. `Graylog2/graylog2-web-interface#1077 <https://github.com/Graylog2/graylog2-web-interface/issues/1077>`_
* Fixed formatting on indices page. `Graylog2/graylog2-web-interface#1086 <https://github.com/Graylog2/graylog2-web-interface/issues/1086>`_
* Improved error handling in stream rule form. `Graylog2/graylog2-web-interface#1076 <https://github.com/Graylog2/graylog2-web-interface/issues/1076>`_
* Fixed time range selection problem for the sources page. `Graylog2/graylog2-web-interface#1080 <https://github.com/Graylog2/graylog2-web-interface/issues/1080>`_
* Several improvements regarding permission checks for user creation. `Graylog2/graylog2-web-interface#1088 <https://github.com/Graylog2/graylog2-web-interface/issues/1088>`_
* Do not show stream alert test button for reader users. `Graylog2/graylog2-web-interface#1089 <https://github.com/Graylog2/graylog2-web-interface/issues/1089>`_
* Fixed node processing status not updating on the nodes page. `Graylog2/graylog2-web-interface#1090 <https://github.com/Graylog2/graylog2-web-interface/issues/1090>`_
* Fixed filename handling on Windows. `Graylog2/graylog2-server#928 <https://github.com/Graylog2/graylog2-server/issues/928>`_, `Graylog2/graylog2-server#732 <https://github.com/Graylog2/graylog2-server/issues/732>`_


Graylog 1.0.0-beta.2
====================

Released: 2015-01-21

https://www.graylog.org/graylog-v1-0-beta-3-has-been-released/

* Fixed stream alert creation. `Graylog2/graylog2-server#891 <https://github.com/Graylog2/graylog2-server/issues/891>`_
* Suppress warning message when PID file doesn't exist. `Graylog2/graylog2-server#889 <https://github.com/Graylog2/graylog2-server/issues/889>`_
* Fixed an error on outputs page with missing output plugin. `Graylog2/graylog2-server#894 <https://github.com/Graylog2/graylog2-server/issues/894>`_
* Change default heap and garbage collector settings in scripts.
* Add extractor information to log message about failing extractor.
* Fixed problem in SplitAndIndexExtractor. `Graylog2/graylog2-server#896 <https://github.com/Graylog2/graylog2-server/issues/896>`_
* Improved rendering time for indices page. `Graylog2/graylog2-web-interface#1060 <https://github.com/Graylog2/graylog2-web-interface/issues/1060>`_
* Allow user to edit its own preferences. `Graylog2/graylog2-web-interface#1049 <https://github.com/Graylog2/graylog2-web-interface/issues/1049>`_
* Fixed updating stream attributes. `Graylog2/graylog2-server#902 <https://github.com/Graylog2/graylog2-server/issues/902>`_
* Stream throughput now shows combined value over all nodes. `Graylog2/graylog2-web-interface#1047 <https://github.com/Graylog2/graylog2-web-interface/issues/1047>`_
* Fixed resource leak in JVM PermGen memory. `Graylog2/graylog2-server#907 <https://github.com/Graylog2/graylog2-server/issues/907>`_
* Update to gelfclient-1.1.0 to fix DNS resolving issue. `Graylog2/graylog2-server#882 <https://github.com/Graylog2/graylog2-server/issues/882>`_
* Allow arbitrary characters in user names (in fact in any resource url). `Graylog2/graylog2-web-interface#1005 <https://github.com/Graylog2/graylog2-web-interface/issues/1005>`_, `Graylog2/graylog2-web-interface#1006 <https://github.com/Graylog2/graylog2-web-interface/issues/1006>`_
* Fixed search result CSV export. `Graylog2/graylog2-server#901 <https://github.com/Graylog2/graylog2-server/issues/901>`_
* Skip GC collection notifications for parallel collector. `Graylog2/graylog2-server#899 <https://github.com/Graylog2/graylog2-server/issues/899>`_
* Shorter reconnect timeout for Radio AMQP connections. `Graylog2/graylog2-server#900 <https://github.com/Graylog2/graylog2-server/issues/900>`_
* Fixed random startup error in Radio. `Graylog2/graylog2-server#911 <https://github.com/Graylog2/graylog2-server/issues/911>`_
* Fixed updating an alert condition. `Graylog2/graylog2-server#912 <https://github.com/Graylog2/graylog2-server/issues/912>`_
* Add system notifications for journal related warnings. `Graylog2/graylog2-server#897 <https://github.com/Graylog2/graylog2-server/issues/897>`_
* Add system notifications for failing outputs. `Graylog2/graylog2-server#741 <https://github.com/Graylog2/graylog2-server/issues/741>`_
* Improve search result pagination. `Graylog2/graylog2-web-interface#834 <https://github.com/Graylog2/graylog2-web-interface/issues/834>`_
* Improved regex error handling in extractor testing. `Graylog2/graylog2-web-interface#1044 <https://github.com/Graylog2/graylog2-web-interface/issues/1044>`_
* Wrap long names for node metrics. `Graylog2/graylog2-web-interface#1028 <https://github.com/Graylog2/graylog2-web-interface/issues/1028>`_
* Fixed node information progress bars. `Graylog2/graylog2-web-interface#1046 <https://github.com/Graylog2/graylog2-web-interface/issues/1046>`_
* Improve node buffer utilization readability. `Graylog2/graylog2-web-interface#1046 <https://github.com/Graylog2/graylog2-web-interface/issues/1046>`_
* Fixed username alert receiver form field. `Graylog2/graylog2-web-interface#1050 <https://github.com/Graylog2/graylog2-web-interface/pull/1050>`_
* Wrap long messages without break characters. `Graylog2/graylog2-web-interface#1052 <https://github.com/Graylog2/graylog2-web-interface/issues/1052>`_
* Hide list of node plugins if there aren't any plugins installed.
* Warn user before leaving page with unpinned graphs. `Graylog2/graylog2-web-interface#808 <https://github.com/Graylog2/graylog2-web-interface/issues/808>`_


Graylog 1.0.0-beta.2
====================

Released: 2015-01-16

https://www.graylog.org/graylog-v1-0-0-beta2/

* SIGAR native libraries are now found correctly (for getting system information)
* plugins can now state if they want to run in server or radio
* Fixed LDAP settings testing. `Graylog2/graylog2-web-interface#1026 <https://github.com/Graylog2/graylog2-web-interface/issues/1026>`_
* Improved RFC5425 syslog message parsing. `Graylog2/graylog2-server#845 <https://github.com/Graylog2/graylog2-server/issues/845>`_
* JVM arguments are now being logged on start. `Graylog2/graylog2-server#875 <https://github.com/Graylog2/graylog2-server/issues/875>`_
* Improvements to log messages when Elasticsearch connection fails during start.
* Fixed an issue with AMQP transport shutdown. `Graylog2/graylog2-server#874 <https://github.com/Graylog2/graylog2-server/issues/874>`_
* After index cycling the System overview page could be broken. `Graylog2/graylog2-server#880 <https://github.com/Graylog2/graylog2-server/issues/880>`_
* Extractors can now be edited. `Graylog2/graylog2-web-interface#549 <https://github.com/Graylog2/graylog2-web-interface/issues/549>`_
* Fixed saving user preferences. `Graylog2/graylog2-web-interface#1027 <https://github.com/Graylog2/graylog2-web-interface/issues/1027>`_
* Scripts now return proper exit codes. `Graylog2/graylog2-server#886 <https://github.com/Graylog2/graylog2-server/pull/886>`_
* Grok patterns can now be uploaded in bulk. `Graylog2/graylog2-server#377 <https://github.com/Graylog2/graylog2-server/issues/377>`_
* During extractor creation the test display could be offset. `Graylog2/graylog2-server#804 <https://github.com/Graylog2/graylog2-server/issues/804>`_
* Performance fix for the System/Indices page. `Graylog2/graylog2-web-interface#1035 <https://github.com/Graylog2/graylog2-web-interface/issues/1035>`_
* A create dashboard link was shown to reader users, leading to an error when followed. `Graylog2/graylog2-web-interface#1032 <https://github.com/Graylog2/graylog2-web-interface/issues/1032>`_
* Content pack section was shown to reader users, leading to an error when followed. `Graylog2/graylog2-web-interface#1033 <https://github.com/Graylog2/graylog2-web-interface/issues/1033>`_
* Failing stream outputs were being restarted constantly. `Graylog2/graylog2-server#741 <https://github.com/Graylog2/graylog2-server/issues/741>`_


Graylog2 0.92.4
===============

Released: 2015-01-14

https://www.graylog.org/graylog2-v0-92-4/

* [SERVER] Ensure that Radio inputs can only be started on server nodes (`Graylog2/graylog2-server#843 <https://github.com/Graylog2/graylog2-server/issues/843>`_)
* [SERVER] Avoid division by zero when finding rotation anchor in the time-based rotation strategy (`Graylog2/graylog2-server#836 <https://github.com/Graylog2/graylog2-server/issues/836>`_)
* [SERVER] Use username as fallback if display name in LDAP is empty (`Graylog2/graylog2-server#837 <https://github.com/Graylog2/graylog2-server/issues/837>`_)


Graylog 1.0.0-beta.1
====================

Released: 2015-01-12

https://www.graylog.org/graylog-v1-0-0-beta1/

* Message Journaling
* New Widgets
* Grok Extractor Support
* Overall stability and resource efficiency improvements
* Single binary for ``graylog2-server`` and ``graylog2-radio``
* Inputs are now editable
* Order of field charts rendered inside the search results page is now maintained.
* Improvements in focus and keyboard behaviour on modal windows and forms.
* You can now define whether to disable expensive, frequent real-time updates of the UI in the settings of each user. (For example the updating of total messages in the system)
* Experimental search query auto-completion that can be enabled in the user preferences.
* The API browser now documents server response payloads in a better way so you know what to expect as an answer to your call.
* Now using the standard Java ServiceLoader for plugins.


Graylog2 0.92.3
===============

Released: 2014-12-23

https://www.graylog.org/graylog2-v0-92-3/

* [SERVER] Removed unnecessary instrumentation in certain places to reduce GC pressure caused by many short living objects (`Graylog2/graylog2-server#800 <https://github.com/Graylog2/graylog2-server/issues/800>`_)
* [SERVER] Limit Netty worker thread pool to 16 threads by default (see ``rest_worker_threads_max_pool_size`` in `graylog2.conf <https://github.com/Graylog2/graylog2-server/blob/0.92.3/misc/graylog2.conf#L71-L72>`_
* [WEB] Fixed upload of content packs when a URI path prefix (``application.context`` in `graylog2-web-interface.conf <https://github.com/Graylog2/graylog2-web-interface/blob/0.92.3/misc/graylog2-web-interface.conf.example#L25-L26>`_) is being used (`Graylog2/graylog2-web-interface#1009 <https://github.com/Graylog2/graylog2-web-interface/issues/1009>`_)
* [WEB] Fixed display of metrics of type Counter (`Graylog2/graylog2-server#795 <https://github.com/Graylog2/graylog2-server/issues/795>`_)


Graylog2 0.92.1
===============

Released: 2014-12-11

https://www.graylog.org/graylog2-v0-92-1/

* [SERVER] Fixed name resolution and overriding sources for network inputs.
* [SERVER] Fixed wrong delimiter in GELF TCP input.
* [SERVER] Disabled the output cache by default. The output cache is the source of all sorts of interesting problems. If you want to keep using it, please read the upgrade notes.
* [SERVER] Fixed message timestamps in GELF output.
* [SERVER] Fixed connection counter for network inputs.
* [SERVER] Added warning message if the receive buffer size (SO_RECV) couldn’t be set for network inputs.
* [WEB] Improved keyboard shortcuts with most modal dialogs (e. g. hitting Enter submits the form instead of just closing the dialogs).
* [WEB] Upgraded to play2-graylog2 1.2.1 (compatible with Play 2.3.x and Java 7).


Graylog2 0.92.0
===============

Released: 2014-12-01

https://www.graylog.org/graylog2-v0-92/

* [SERVER] IMPORTANT SECURITY FIX: It was possible to perform LDAP logins with crafted wildcards. (A big thank you to Jose Tozo who discovered this issue and disclosed it very responsibly.)
* [SERVER] Generate a system notification if garbage collection takes longer than a configurable threshold.
* [SERVER] Added several JVM-related metrics.
* [SERVER] Added support for Elasticsearch 1.4.x which brings a lot of stability and resilience features to Elasticsearch clusters.
* [SERVER] Made version check of Elasticsearch version optional. Disabling this check is not recommended.
* [SERVER] Added an option to disable optimizing Elasticsearch indices on index cycling.
* [SERVER] Added an option to disable time-range calculation for indices on index cycling.
* [SERVER] Lots of other performance enhancements for large setups (i.e. involving several Radio nodes and multiple Graylog2 Servers).
* [SERVER] Support for Syslog Octet Counting, as used by syslog-ng for syslog via TCP (#743)
* [SERVER] Improved support for structured syslog messages (#744)
* [SERVER] Bug fixes regarding IPv6 literals in mongodb_replica_set and elasticsearch_discovery_zen_ping_unicast_hosts
* [WEB] Added additional details to system notification about Elasticsearch max. open file descriptors.
* [WEB] Fixed several bugs and inconsistencies regarding time zones.
* [WEB] Improved graphs and diagrams
* [WEB] Allow to update dashboards when browser window is not on focus (#738)
* [WEB] Bug fixes regarding timezone handling
* Numerous internal bug fixes


Graylog2 0.92.0-rc.1
====================

Released: 2014-11-21

https://www.graylog.org/graylog2-v0-92-rc-1/

* [SERVER] Generate a system notification if garbage collection takes longer than a configurable threshold.
* [SERVER] Added several JVM-related metrics.
* [SERVER] Added support for Elasticsearch 1.4.x which brings a lot of stability and resilience features to Elasticsearch clusters.
* [SERVER] Made version check of Elasticsearch version optional. Disabling this check is not recommended.
* [SERVER] Added an option to disable optimizing Elasticsearch indices on index cycling.
* [SERVER] Added an option to disable time-range calculation for indices on index cycling.
* [SERVER] Lots of other performance enhancements for large setups (i. e. involving several Radio nodes and multiple Graylog2 Servers).
* [WEB] Upgraded to Play 2.3.6.
* [WEB] Added additional details to system notification about Elasticsearch max. open file descriptors.
* [WEB] Fixed several bugs and inconsistencies regarding time zones.
* Numerous internal bug fixes


Graylog2 0.91.3
===============

Released: 2014-11-05

https://www.graylog.org/graylog2-v0-90-3-and-v0-91-3-has-been-released/

* Fixed date and time issues related to DST changes
* Requires Elasticsearch 1.3.4; Elasticsearch 1.3.2 had a bug that can cause index corruptions.
* The ``mongodb_replica_set`` configuration variable now supports IPv6
* Messages read from the on-disk caches could be stored with missing fields


Graylog2 0.91.3
===============

Released: 2014-11-05

https://www.graylog.org/graylog2-v0-90-3-and-v0-91-3-has-been-released/

* Fixed date and time issues related to DST changes
* The ``mongodb_replica_set`` configuration variable now supports IPv6
* Messages read from the on-disk caches could be stored with missing fields


Graylog2 0.92.0-beta.1
======================

Released: 2014-11-05

https://www.graylog.org/graylog2-v0-92-beta-1/

* Content packs
* [SERVER] SSL/TLS support for Graylog2 REST API
* [SERVER] Support for time based retention cleaning of your messages. The old message count based approach is still the default.
* [SERVER] Support for Syslog Octet Counting, as used by syslog-ng for syslog via TCP (`Graylog2/graylog2-server#743 <https://github.com/Graylog2/graylog2-server/pull/743>`_)
* [SERVER] Improved support for structured syslog messages (`Graylog2/graylog2-server#744 <https://github.com/Graylog2/graylog2-server/pull/744>`_)
* [SERVER] Bug fixes regarding IPv6 literals in ``mongodb_replica_set`` and ``elasticsearch_discovery_zen_ping_unicast_hosts``
* [WEB] Revamped "Sources" page in the web interface
* [WEB] Improved graphs and diagrams
* [WEB] Allow to update dashboards when browser window is not on focus (`Graylog2/graylog2-web-interface#738 <https://github.com/Graylog2/graylog2-web-interface/issues/738>`_)
* [WEB] Bug fixes regarding timezone handling
* Numerous internal bug fixes


Graylog2 0.91.1
===============

Released: 2014-10-17

https://www.graylog.org/two-new-graylog2-releases/

* Messages written to the persisted master caches were written to the system with unreadable timestamps, leading to
* errors when trying to open the message.
* Extractors were only being deleted from running inputs but not from all inputs
* Output plugins were not always properly loaded
* You can now configure the ``alert_check_interval`` in your ``graylog2.conf``
* Parsing of configured Elasticsearch unicast discovery addresses could break when including spaces


Graylog2 0.90.1
===============

Released: 2014-10-17

https://www.graylog.org/two-new-graylog2-releases/

* Messages written to the persisted master caches were written to the system with unreadable timestamps, leading to errors when trying to open the message.
* Extractors were only being deleted from running inputs but not from all inputs
* Output plugins were not always properly loaded
* You can now configure the ``alert_check_interval`` in your ``graylog2.conf``
* Parsing of configured Elasticsearch unicast discovery addresses could break when including spaces


Graylog2 0.91.0-rc.1
====================

Released: 2014-09-23

https://www.graylog.org/graylog2-v0-90-has-been-released/

* Optional ElasticSearch v1.3.2 support


Graylog2 0.90.0
===============

Released: 2014-09-23

https://www.graylog.org/graylog2-v0-90-has-been-released/

* Real-time data forwarding to Splunk or other systems
* Alert callbacks for greater flexibility
* New disk-based architecture for buffering in load spike situations
* Improved graphing
* Plugin API
* Huge performance and stability improvements across the whole stack
* Small possibility of losing messages in certain scenarios has been fixed
* Improvements to internal logging from threads to avoid swallowing Graylog2 error messages
* Paused streams are no longer checked for alerts
* Several improvements to timezone handling
* JavaScript performance fixes in the web interface and especially a fixed memory leak of charts on dashboards
* The GELF HTTP input now supports CORS
* Stream matching now has a configurable timeout to avoid stalling message processing in case of too complex rules or erroneous regular expressions
* Stability improvements for Kafka and AMQP inputs
* Inputs can now be paused and resumed
* Dozens of bug fixes and other improvements


Graylog2 0.20.3
===============

Released: 2014-08-09

https://www.graylog.org/graylog2-v0-20-3-has-been-released/

* Bugfix: Storing saved searches was not accounting custom application contexts
* Bugfix: Editing stream rules could have a wrong a pre-filled value
* Bugfix: The create dashboard link was shown even if the user has no permission to so. This caused an ugly error page because of the missing permissions.
* Bugfix: graylog2-radio could lose numeric fields when writing to the message broker
* Better default batch size values for the Elasticsearch output
* Improved ``rest_transport_uri`` default settings to avoid confusion with loopback interfaces
* The deflector index is now also using the configured index prefix


Graylog2 0.20.2
===============

Released: 2014-05-24

https://www.graylog.org/graylog2-v0-20-2-has-been-released/

* Search result highlighting
* Reintroduces AMQP support
* Extractor improvements and sharing
* Graceful shutdowns, Lifecycles, Load Balancer integration
* Improved stream alert emails
* Alert annotations
* CSV exports via the REST API now support chunked transfers and avoid heap size problems with huge result sets
* Login now redirects to page you visited before if there was one
* More live updating information in node detail pages
* Empty dashboards no longer show lock/unlock buttons
* Global inputs now also show IO metrics
* You can now easily copy message IDs into native clipboard with one click
* Improved message field selection in the sidebar
* Fixed display of floating point numbers in several places
* Now supporting application contexts in the web interface like ``http://example.org/graylog2``
* Several fixes for LDAP configuration form
* Message fields in the search result sidebar now survive pagination
* Only admin users are allowed to change the session timeout for reader users
* New extractor: Copy whole input
* New converters: uppercase/lowercase, flexdate (tries to parse any string as date)
* New stream rule to check for presence or absence of fields
* Message processing now supports trace logging
* Better error message for ES discovery problems
* Fixes to GELF HTTP input and it holding open connections
* Some timezone fixes
* CSV exports now only contain selected fields
* Improvements for bin/graylog* control scripts
* UDP inputs now allow for custom receive buffer sizes
* Numeric extractor converter now supports floating point values
* Bugfix: Several small fixes to system notifications and closing them
* Bugfix: Carriage returns were not escaped properly in CSV exports
* Bugfix: Some AJAX calls redirected to the startpage when they failed
* Bugfix: Wrong sorting in sources table
* Bugfix: Quickvalues widget was broken with very long values
* Bugfix: Quickvalues modal was positioned wrong in some cases
* Bugfix: Indexer failures list could break when you had a lot of failures
* Custom application prefix was not working for field chart analytics
* Bugfix: Memory leaks in the dashboards
* Bugfix: NullPointerException when Elasticsearch discovery failed and unicast discovery was disabled
* Message backlog in alert emails did not always include the correct number of messages
* Improvements for message outputs: No longer only waiting for filled buffers but also flushing them regularly. This avoids problems that make Graylog2 look like it misses messages in cheap benchmark scenarios combined with only little throughput.
