*********
Changelog
*********

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
* Dynamically update dashboard widgets with keyword range. `Graylog2/graylog2-server#956 <https://github.com/Graylog2/graylog2-server/pull/956>`_ `Graylog2/graylog2-web-interface#958 <https://github.com/Graylog2/graylog2-web-interface/issues/958>`_
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
* Fixed data type for the <em>max_size_per_index</em> config option value. `Graylog2/graylog2-web-interface#1100 <https://github.com/Graylog2/graylog2-web-interface/issues/1100>`_
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
* Improved layout for the message journal information. `Graylog2/graylog2-web-interface#1084 <https://github.com/Graylog2/graylog2-web-interface/issues/1084>`_ `Graylog2/graylog2-web-interface#1085 <https://github.com/Graylog2/graylog2-web-interface/issues/1085>`_
* Fixed wording on radio inputs page. `Graylog2/graylog2-web-interface#1077 <https://github.com/Graylog2/graylog2-web-interface/issues/1077>`_
* Fixed formatting on indices page. `Graylog2/graylog2-web-interface#1086 <https://github.com/Graylog2/graylog2-web-interface/issues/1086>`_
* Improved error handling in stream rule form. `Graylog2/graylog2-web-interface#1076 <https://github.com/Graylog2/graylog2-web-interface/issues/1076>`_
* Fixed time range selection problem for the sources page. `Graylog2/graylog2-web-interface#1080 <https://github.com/Graylog2/graylog2-web-interface/issues/1080>`_
* Several improvements regarding permission checks for user creation. `Graylog2/graylog2-web-interface#1088 <https://github.com/Graylog2/graylog2-web-interface/issues/1088>`_
* Do not show stream alert test button for reader users. `Graylog2/graylog2-web-interface#1089 <https://github.com/Graylog2/graylog2-web-interface/issues/1089>`_
* Fixed node processing status not updating on the nodes page. `Graylog2/graylog2-web-interface#1090 <https://github.com/Graylog2/graylog2-web-interface/issues/1090>`_
* Fixed filename handling on Windows. `Graylog2/graylog2-server#928 <https://github.com/Graylog2/graylog2-server/issues/928>`_ `Graylog2/graylog2-server#732 <https://github.com/Graylog2/graylog2-server/issues/732>`_


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
* Allow arbitrary characters in user names (in fact in any resource url). `Graylog2/graylog2-web-interface#1005 <https://github.com/Graylog2/graylog2-web-interface/issues/1005>`_ `Graylog2/graylog2-web-interface#1006 <https://github.com/Graylog2/graylog2-web-interface/issues/1006>`_
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
