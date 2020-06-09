*********
Changelog
*********

Graylog 3.2.6
=============

Released: 2020-06-10

Core
^^^^

**Fixed**

- Retry message indexing when indices are read-only due to disk space problems in Elasticsearch. `Graylog2/graylog2-server#8211 <https://github.com/Graylog2/graylog2-server/issues/8211>`_ `Graylog2/graylog2-server#8269 <https://github.com/Graylog2/graylog2-server/issues/8269>`_
- Fix issue with using float numbers in event definitions. `Graylog2/graylog2-server#8290 <https://github.com/Graylog2/graylog2-server/issues/8290>`_

Graylog 3.2.5
=============

Released: 2020-05-19

Core
^^^^

**Added**

- Add minimal support for Beats 7.x to the beats input. `Graylog2/graylog2-server#6501 <https://github.com/Graylog2/graylog2-server/issues/6501>`_ `Graylog2/graylog2-server#7894 <https://github.com/Graylog2/graylog2-server/issues/7894>`_
- Show system notification when disk in Elasticsearch fills up. `Graylog2/graylog2-server#7899 <https://github.com/Graylog2/graylog2-server/issues/7899>`_ (Thanks `@radykal-com <https://github.com/radykal-com>`_)

**Changed**

- Enforce unix newlines in the sidecar collector configuration file editor. `Graylog2/graylog2-server#7889 <https://github.com/Graylog2/graylog2-server/issues/7889>`_ `Graylog2/collector-sidecar#389 <https://github.com/Graylog2/collector-sidecar/issues/389>`_ `Graylog2/graylog2-server#7975 <https://github.com/Graylog2/graylog2-server/issues/7975>`_
- Mask passwords in input configuration returned from the ``/system/inputstates`` endpoint. `Graylog2/graylog2-server#8037 <https://github.com/Graylog2/graylog2-server/issues/8037>`_
- Sanitize URLs in content packs. `Graylog2/graylog2-server#8072 <https://github.com/Graylog2/graylog2-server/issues/8072>`_ `Graylog2/graylog2-server#8104 <https://github.com/Graylog2/graylog2-server/issues/8104>`_
- Sanitize URls in "Hyperlink String" decorator. `Graylog2/graylog2-server#8150 <https://github.com/Graylog2/graylog2-server/issues/8150>`_

**Fixed**

- Fix UI issues in sidecar configuration. `Graylog2/graylog2-server#7406 <https://github.com/Graylog2/graylog2-server/issues/7406>`_ `Graylog2/graylog2-server#7754 <https://github.com/Graylog2/graylog2-server/issues/7754>`_
- Fix dashboard migration issues. `Graylog2/graylog2-server#7732 <https://github.com/Graylog2/graylog2-server/issues/7732>`_ `Graylog2/graylog2-server#7749 <https://github.com/Graylog2/graylog2-server/issues/7749>`_ `Graylog2/graylog2-server#7840 <https://github.com/Graylog2/graylog2-server/issues/7840>`_
- Fix message list sorting option. `Graylog2/graylog2-server#7758 <https://github.com/Graylog2/graylog2-server/issues/7758>`_ `Graylog2/graylog2-server#7763 <https://github.com/Graylog2/graylog2-server/issues/7763>`_
- Fix compatibility issue with Safari and the aggregation configuration. `Graylog2/graylog2-server#7806 <https://github.com/Graylog2/graylog2-server/issues/7806>`_ `Graylog2/graylog2-server#7815 <https://github.com/Graylog2/graylog2-server/issues/7815>`_
- Fix pipeline stage parsing endpoint. `Graylog2/graylog2-server#7322 <https://github.com/Graylog2/graylog2-server/issues/7322>`_ `Graylog2/graylog2-server#7830 <https://github.com/Graylog2/graylog2-server/issues/7830>`_

AWS Plugin (legacy)
^^^^^^^^^^^^^^^^^^^

**Changed**

- Encrypt default AWS secret key with system secret. `Graylog2/graylog-plugin-aws#361 <https://github.com/Graylog2/graylog-plugin-aws/issues/361>`_

Graylog 3.2.4
=============

Released: 2020-03-19

Core
^^^^

**Changed**

- Display old LDAP group mappings so they can be deleted by the user. `Graylog2/graylog2-server#7502 <https://github.com/Graylog2/graylog2-server/issues/7502>`_ `Graylog2/graylog2-server#7697 <https://github.com/Graylog2/graylog2-server/issues/7697>`_
- Don't allow aggregations on analyzed fields. `Graylog2/graylog2-server#7508 <https://github.com/Graylog2/graylog2-server/issues/7508>`_ `Graylog2/graylog2-server#7685 <https://github.com/Graylog2/graylog2-server/issues/7685>`_

**Fixed**

- Fix problem with message list pagination. `Graylog2/graylog2-server#7680 <https://github.com/Graylog2/graylog2-server/issues/7680>`_ `Graylog2/graylog2-server#7665 <https://github.com/Graylog2/graylog2-server/issues/7665>`_ `Graylog2/graylog2-server#7693 <https://github.com/Graylog2/graylog2-server/issues/7693>`_
- Fix issue removing custom fields from event definitions. `Graylog2/graylog2-server#7544 <https://github.com/Graylog2/graylog2-server/issues/7544>`_ `Graylog2/graylog2-server#7692 <https://github.com/Graylog2/graylog2-server/issues/7692>`_
- Fix drop-down overlay placements on search page. `Graylog2/graylog2-server#7723 <https://github.com/Graylog2/graylog2-server/issues/7723>`_
- Remove streams parameter from URL when the last stream got removed from a search query. `Graylog2/graylog2-server#7717 <https://github.com/Graylog2/graylog2-server/issues/7717>`_ `Graylog2/graylog2-server#7719 <https://github.com/Graylog2/graylog2-server/issues/7719>`_

Graylog 3.2.3
=============

Released: 2020-03-11

Core
^^^^

**Added**

- Add back auto-completion for ``_exists_`` queries. `Graylog2/graylog2-server#7441 <https://github.com/Graylog2/graylog2-server/issues/7441>`_ `Graylog2/graylog2-server#7604 <https://github.com/Graylog2/graylog2-server/issues/7604>`_
- Add back surrounding search feature for searches and dashboards. `Graylog2/graylog2-server#7616 <https://github.com/Graylog2/graylog2-server/issues/7616>`_ `Graylog2/graylog2-server#7621 <https://github.com/Graylog2/graylog2-server/issues/7621>`_
- Add support for newer Kafka versions and allowing more customization options. `Graylog2/graylog2-server#7504 <https://github.com/Graylog2/graylog2-server/issues/7504>`_ (Thanks `@muralibasani <https://github.com/muralibasani>`_)
- Add back field sorting for the message table widget. `Graylog2/graylog2-server#7645 <https://github.com/Graylog2/graylog2-server/issues/7645>`_
- Add back "replay search" button for dashboard widgets. `Graylog2/graylog2-server#7372 <https://github.com/Graylog2/graylog2-server/issues/7372>`_ `Graylog2/graylog2-server#7648 <https://github.com/Graylog2/graylog2-server/issues/7648>`_
- Add option to share a saved search with other users. `Graylog2/graylog2-server#7668 <https://github.com/Graylog2/graylog2-server/issues/7668>`_

**Changed**

- Improve chart rendering for zero values. `Graylog2/graylog2-server#7605 <https://github.com/Graylog2/graylog2-server/issues/7605>`_
- Rename "Aggregate" field option to "Show top values" to make it more clear. (this was previously called quick values) `Graylog2/graylog2-server#7663 <https://github.com/Graylog2/graylog2-server/issues/7663>`_

**Fixed**

- Fix widget error "n.find is not a function". `Graylog2/graylog2-server#7365 <https://github.com/Graylog2/graylog2-server/issues/7365>`_ `Graylog2/graylog2-server#7538 <https://github.com/Graylog2/graylog2-server/issues/7538>`_
- Fix problem with rendering table widgets. `Graylog2/graylog2-server#7565 <https://github.com/Graylog2/graylog2-server/issues/7565>`_ `Graylog2/graylog2-server#7611 <https://github.com/Graylog2/graylog2-server/issues/7611>`_
- Fix aggregation event definitions when no streams are selected. `Graylog2/graylog2-server#7619 <https://github.com/Graylog2/graylog2-server/issues/7619>`_ `Graylog2/graylog2-server#7625 <https://github.com/Graylog2/graylog2-server/issues/7625>`_
- Fix problem with showing message journal statistics on the node details page. `Graylog2/graylog2-server#7521 <https://github.com/Graylog2/graylog2-server/issues/7521>`_ `Graylog2/graylog2-server#7633 <https://github.com/Graylog2/graylog2-server/issues/7633>`_
- Fix sorting problem when sorting over different streams. `Graylog2/graylog2-server#6490 <https://github.com/Graylog2/graylog2-server/issues/6490>`_ `Graylog2/graylog2-server#7569 <https://github.com/Graylog2/graylog2-server/issues/7569>`_
- Fix search and dashboard issues with Internet Explorer 11. `Graylog2/graylog2-server#7660 <https://github.com/Graylog2/graylog2-server/issues/7660>`_
- Fix search page refresh handling. `Graylog2/graylog2-server#7661 <https://github.com/Graylog2/graylog2-server/issues/7661>`_

Graylog 3.2.2
=============

Released: 2020-02-20

Core
^^^^

**Changed**

- Use Graylog data dir for storing netty tcnative libraries. `Graylog2/graylog2-server#5762 <https://github.com/Graylog2/graylog2-server/issues/5762>`_ `Graylog2/graylog2-server#7359 <https://github.com/Graylog2/graylog2-server/issues/7359>`_
- Add colon (``:``) when selecting a field from auto-completion. `Graylog2/graylog2-server#7408 <https://github.com/Graylog2/graylog2-server/issues/7408>`_ `Graylog2/graylog2-server#7493 <https://github.com/Graylog2/graylog2-server/issues/7493>`_

**Fixed**

- Suppress system notification for whitelist errors from test alerts. `Graylog2/graylog2-server#7350 <https://github.com/Graylog2/graylog2-server/issues/7350>`_ `Graylog2/graylog2-server#7390 <https://github.com/Graylog2/graylog2-server/issues/7390>`_
- Fix issue with duplicating dashboard tabs. `Graylog2/graylog2-server#7397 <https://github.com/Graylog2/graylog2-server/issues/7397>`_
- Improve search URL synchronization by avoiding unnecessary entries in browser history. `Graylog2/graylog2-server#7415 <https://github.com/Graylog2/graylog2-server/issues/7415>`_
- Fix error on system overview page. `Graylog2/graylog2-server#7329 <https://github.com/Graylog2/graylog2-server/issues/7329>`_ `Graylog2/graylog2-server#7351 <https://github.com/Graylog2/graylog2-server/issues/7351>`_
- Fix issue with content pack creation. `Graylog2/graylog2-server#6690 <https://github.com/Graylog2/graylog2-server/issues/6690>`_ `Graylog2/graylog2-server#7449 <https://github.com/Graylog2/graylog2-server/issues/7449>`_
- Fix problem with dashboard migration and hidden filters. `Graylog2/graylog2-server#7366 <https://github.com/Graylog2/graylog2-server/issues/7366>`_ `Graylog2/graylog2-server#7420 <https://github.com/Graylog2/graylog2-server/issues/7420>`_
- Fix dashboard migration issue with field name extraction. `Graylog2/graylog2-server#7452 <https://github.com/Graylog2/graylog2-server/issues/7452>`_
- Fix widget error "n.find is not a function". `Graylog2/graylog2-server#7365 <https://github.com/Graylog2/graylog2-server/issues/7365>`_ `Graylog2/graylog2-server#7450 <https://github.com/Graylog2/graylog2-server/issues/7450>`_
- Fix dashboard widget migration error related to value sorting. `Graylog2/graylog2-server#7476 <https://github.com/Graylog2/graylog2-server/issues/7476>`_ `Graylog2/graylog2-server#7481 <https://github.com/Graylog2/graylog2-server/issues/7481>`_
- Fix issue with Active Directory authentication support. `Graylog2/graylog2-server#7431 <https://github.com/Graylog2/graylog2-server/issues/7431>`_ `Graylog2/graylog2-server#7498 <https://github.com/Graylog2/graylog2-server/issues/7498>`_
- Fix issue with field ordering in message table widgets. `Graylog2/graylog2-server#6808 <https://github.com/Graylog2/graylog2-server/issues/6808>`_ `Graylog2/graylog2-server#7501 <https://github.com/Graylog2/graylog2-server/issues/7501>`_
- Fix problem with running Graylog under a subpath. `Graylog2/graylog2-server#7447 <https://github.com/Graylog2/graylog2-server/issues/7447>`_ `Graylog2/graylog2-server#7500 <https://github.com/Graylog2/graylog2-server/issues/7500>`_

Integrations Plugin
^^^^^^^^^^^^^^^^^^^

**Fixed**

- Fix issue with AWS Kinesis token refresh. `Graylog2/graylog-plugin-integrations#386 <https://github.com/Graylog2/graylog-plugin-integrations/issues/386>`_ `Graylog2/graylog-plugin-integrations#389 <https://github.com/Graylog2/graylog-plugin-integrations/issues/389>`_

Graylog 3.2.1
=============

Released: 2020-02-04

Core
^^^^

**Fixed**

- Fix problem with message processing and invalid ``timestamp`` fields. `Graylog2/graylog2-server#7364 <https://github.com/Graylog2/graylog2-server/issues/7364>`_ `Graylog2/graylog2-server#7290 <https://github.com/Graylog2/graylog2-server/issues/7290>`_
- Fix scrolling issue in data table widget for Safari browser. `Graylog2/graylog2-server#7344 <https://github.com/Graylog2/graylog2-server/issues/7344>`_ `Graylog2/graylog2-server#7353 <https://github.com/Graylog2/graylog2-server/issues/7353>`_
- Fix two issues with saved search migration. `Graylog2/graylog2-server#7362 <https://github.com/Graylog2/graylog2-server/issues/7362>`_ `Graylog2/graylog2-server#7369 <https://github.com/Graylog2/graylog2-server/issues/7369>`_

Graylog 3.2.0
=============

Released: 2020-01-31

Core
^^^^

**Added**

- Add configuration options for event index set prefixes. `Graylog2/graylog2-server#6340 <https://github.com/Graylog2/graylog2-server/issues/6340>`_ `Graylog2/graylog2-server#6350 <https://github.com/Graylog2/graylog2-server/issues/6350>`_
- Add support for trailing comma characters in GELF input. `Graylog2/graylog2-server#6325 <https://github.com/Graylog2/graylog2-server/issues/6325>`_
- Add "apply" button to pipeline rule editor to improve editing workflow. `Graylog2/graylog2-server#6312 <https://github.com/Graylog2/graylog2-server/issues/6312>`_ `Graylog2/graylog2-server#6351 <https://github.com/Graylog2/graylog2-server/issues/6351>`_ (Thanks `@radykal-com <https://github.com/radykal-com>`_!)
- Start infrastructure for UI theming.
- Support for percentile aggregations in the aggregation builder. `Graylog2/graylog2-server#6597 <https://github.com/Graylog2/graylog2-server/issues/6597>`_
- Add support for MaxMind ASN geo IP databases. `Graylog2/graylog2-server#6623 <https://github.com/Graylog2/graylog2-server/issues/6623>`_
- Introduce cluster global REST API browser button.
- Add heatmap visualization in aggregation builder. `Graylog2/graylog2-server#6678 <https://github.com/Graylog2/graylog2-server/issues/6678>`_
- Add area chart visualization to aggregation builder. `Graylog2/graylog2-server#6893 <https://github.com/Graylog2/graylog2-server/issues/6893>`_
- Add support for disabling the built-in root user. `Graylog2/graylog2-server#6688 <https://github.com/Graylog2/graylog2-server/issues/6688>`_
- Support for string list values in lookup tables. `Graylog2/graylog2-server#6542 <https://github.com/Graylog2/graylog2-server/issues/6542>`_
- Add pipeline functions to update string list values in lookup tables. `Graylog2/graylog2-server#7189 <https://github.com/Graylog2/graylog2-server/issues/7189>`_
- Bring back content pack auto-load. `Graylog2/graylog2-server#5744 <https://github.com/Graylog2/graylog2-server/issues/5744>`_ `Graylog2/graylog2-server#6096 <https://github.com/Graylog2/graylog2-server/issues/6096>`_
- Add scratchpad for short notes. `Graylog2/graylog2-server#6492 <https://github.com/Graylog2/graylog2-server/issues/6492>`_
- Add content pack support for searches. `Graylog2/graylog2-server#6973 <https://github.com/Graylog2/graylog2-server/issues/6973>`_
- Add support for multiple conditions in event and alert aggregations. `Graylog2/graylog2-server#6353 <https://github.com/Graylog2/graylog2-server/issues/6353>`_ `Graylog2/graylog2-server#6879 <https://github.com/Graylog2/graylog2-server/issues/6879>`_
- Configuration option to enforce system wide TLS protocol settings. `Graylog2/graylog2-server#6444 <https://github.com/Graylog2/graylog2-server/issues/6444>`_ `Graylog2/graylog2-server#7130 <https://github.com/Graylog2/graylog2-server/issues/7130>`_
- Support for multiple dashboard tabs.
- Automatic tab rotation on dashboards in TV/full-screen mode.
- Add ``gl2_accounted_message_size`` field to every message to help with accounting license traffic. `Graylog2/graylog2-server#6838 <https://github.com/Graylog2/graylog2-server/issues/6838>`_ `Graylog2/graylog2-server#7187 <https://github.com/Graylog2/graylog2-server/issues/7187>`_
- Remember event/alert display settings in event/alerts overview page. `Graylog2/graylog2-server#6796 <https://github.com/Graylog2/graylog2-server/issues/6796>`_ `Graylog2/graylog2-server#7221 <https://github.com/Graylog2/graylog2-server/issues/7221>`_
- Add support for dumping the current process buffer state to help debugging slow processing. `Graylog2/graylog2-server#7199 <https://github.com/Graylog2/graylog2-server/issues/7199>`_
- Add ``elasticsearch_discovery_default_scheme`` config file setting to improve Elasticsearch node discovery. `Graylog2/graylog2-server#6280 <https://github.com/Graylog2/graylog2-server/issues/6280>`_ `Graylog2/graylog2-server#6315 <https://github.com/Graylog2/graylog2-server/issues/6315>`_ (Thanks `@radykal-com <https://github.com/radykal-com>`_!)
- Allow customization of colors in visualizations.
- Add global filter and timerange override for dashboards. `Graylog2/graylog2-server#6424 <https://github.com/Graylog2/graylog2-server/issues/6424>`_ `Graylog2/graylog2-server#6445 <https://github.com/Graylog2/graylog2-server/issues/6445>`_

**Changed**

- Improve navigation display on small screens. `Graylog2/graylog2-server#6329 <https://github.com/Graylog2/graylog2-server/issues/6329>`_
- Introduce abstraction for bootstrap UI components. `Graylog2/graylog2-server#6385 <https://github.com/Graylog2/graylog2-server/issues/6385>`_
- Improve log level configuration to include more log classes. `Graylog2/graylog2-server#6423 <https://github.com/Graylog2/graylog2-server/issues/6423>`_
- Improve event notification test button. `Graylog2/graylog2-server#6522 <https://github.com/Graylog2/graylog2-server/issues/6522>`_
- Don't show event streams in pipeline configuration. `Graylog2/graylog2-server#6454 <https://github.com/Graylog2/graylog2-server/issues/6454>`_ `Graylog2/graylog2-server#6513 <https://github.com/Graylog2/graylog2-server/issues/6513>`_
- Migrated legacy dashboards into new dashboards.
- Migrated legacy saved searches into new search bookmarks.
- Improve lookup cache error handling. `Graylog2/graylog2-server#6295 <https://github.com/Graylog2/graylog2-server/issues/6295>`_ `Graylog2/graylog2-server#6518 <https://github.com/Graylog2/graylog2-server/issues/6518>`_
- Migrate "Sources" page into a dashboard. `Graylog2/graylog2-server#7024 <https://github.com/Graylog2/graylog2-server/issues/7024>`_

**Removed**

- Remove unused search-type implementations. `Graylog2/graylog2-server#6438 <https://github.com/Graylog2/graylog2-server/issues/6438>`_
- Sources page has been removed and converted into a dashboard. `Graylog2/graylog2-server#7024 <https://github.com/Graylog2/graylog2-server/issues/7024>`_

**Fixed**

- Fix sorting issue on inputs page. `Graylog2/graylog2-server#5921 <https://github.com/Graylog2/graylog2-server/issues/5921>`_ (Thanks `@radykal-com <https://github.com/radykal-com>`_!)
- Fix issue creating database indices for processin status. `Graylog2/graylog2-server#6322 <https://github.com/Graylog2/graylog2-server/issues/6322>`_ `Graylog2/graylog2-server#6333 <https://github.com/Graylog2/graylog2-server/issues/6333>`_
- Fix server shutdown problem with message generator input. `Graylog2/graylog2-server#6305 <https://github.com/Graylog2/graylog2-server/issues/6305>`_
- Fix issue loading views. `Graylog2/graylog2-server#6346 <https://github.com/Graylog2/graylog2-server/issues/6346>`_ `Graylog2/graylog2-server#6352 <https://github.com/Graylog2/graylog2-server/issues/6352>`_
- Fix display issues with auto-completion in search bar. `Graylog2/graylog2-server#6461 <https://github.com/Graylog2/graylog2-server/issues/6461>`_
- Fix issue with compound index field types. `Graylog2/graylog2-server#6313 <https://github.com/Graylog2/graylog2-server/issues/6313>`_ `Graylog2/graylog2-server#6462 <https://github.com/Graylog2/graylog2-server/issues/6462>`_
- Fix issues with field highlighting. `Graylog2/graylog2-server#6511 <https://github.com/Graylog2/graylog2-server/issues/6511>`_ `Graylog2/graylog2-server#6512 <https://github.com/Graylog2/graylog2-server/issues/6512>`_
- Fix race condition in index management. `Graylog2/graylog2-server#6383 <https://github.com/Graylog2/graylog2-server/issues/6383>`_ `Graylog2/graylog2-server#6634 <https://github.com/Graylog2/graylog2-server/issues/6634>`_
- Fix issue with event notification backlog seeting display. `Graylog2/graylog2-server#6580 <https://github.com/Graylog2/graylog2-server/issues/6580>`_
- Fix sorting in streams selection in search. `Graylog2/graylog2-server#6514 <https://github.com/Graylog2/graylog2-server/issues/6514>`_ `Graylog2/graylog2-server#6655 <https://github.com/Graylog2/graylog2-server/issues/6655>`_
- Fix issue with managing event index set templates. `Graylog2/graylog2-server#6507 <https://github.com/Graylog2/graylog2-server/issues/6507>`_ `Graylog2/graylog2-server#6656 <https://github.com/Graylog2/graylog2-server/issues/6656>`_
- Fix issue reloading changed GROK patterns in a cluster setup. `Graylog2/graylog2-server#6666 <https://github.com/Graylog2/graylog2-server/issues/6666>`_
- Fix pipeline rule parsing error. `Graylog2/graylog2-server#6716 <https://github.com/Graylog2/graylog2-server/issues/6716>`_
- Fix UI problem modifying pipeline stages. `Graylog2/graylog2-server#5896 <https://github.com/Graylog2/graylog2-server/issues/5896>`_ `Graylog2/graylog2-server#6743 <https://github.com/Graylog2/graylog2-server/issues/6743>`_
- Fix issue with object validation in REST API. `Graylog2/graylog2-server#5402 <https://github.com/Graylog2/graylog2-server/issues/5402>`_
- Fix timestamp data type issue with COMMONAPACHELOG GROK pattern. `Graylog2/graylog2-server#1647 <https://github.com/Graylog2/graylog2-server/issues/1647>`_ `Graylog2/graylog2-server#6847 <https://github.com/Graylog2/graylog2-server/issues/6847>`_
- Fix issue with pipelines and the default stream in content packs. `Graylog2/graylog2-server#6873 <https://github.com/Graylog2/graylog2-server/issues/6873>`_ (Thanks `@pschichtel <https://github.com/pschichtel>`_!)
- Improve REST API browser documentation. `Graylog2/graylog2-server#6955 <https://github.com/Graylog2/graylog2-server/issues/6955>`_
- Fix event aggregation issues with empty fields. `Graylog2/graylog2-server#6933 <https://github.com/Graylog2/graylog2-server/issues/6933>`_ `Graylog2/graylog2-server#7070 <https://github.com/Graylog2/graylog2-server/issues/7070>`_
- Fix issue with upsert database operations. `Graylog2/graylog2-server#7258 <https://github.com/Graylog2/graylog2-server/issues/7258>`_ `Graylog2/graylog2-server#7259 <https://github.com/Graylog2/graylog2-server/issues/7259>`_
- Fix issue in DNS adapter that could cause message processing stalls. `Graylog2/graylog2-server#5782 <https://github.com/Graylog2/graylog2-server/issues/5782>`_ `Graylog2/graylog2-server#7325 <https://github.com/Graylog2/graylog2-server/issues/7325>`_

Integrations Plugin
^^^^^^^^^^^^^^^^^^^

**Added**

- Add IPFIX input plugin.

Graylog 3.1.4
=============

Released: 2020-01-14

Core
^^^^

**Added**

- Add URL whitelist service to make sure that lookup data adapters and event notifications cannot use arbitrary URLs.
  **Attention:** The URL whitelist is enabled by default! On the first server startup after the upgrade, the URL whitelist service will automatically generate
  whitelist entries for existing lookup data adapters and event notifications. See :ref:`URL whitelist documentation <sec_url_whitelist>` for details.

**Changed**

- Reduce amount of log messages when job scheduler is disabled on a node. `Graylog2/graylog2-server#6451 <https://github.com/Graylog2/graylog2-server/issues/6451>`_ `Graylog2/graylog2-server#6816 <https://github.com/Graylog2/graylog2-server/issues/6816>`_

**Fixed**

- Fix global API browser link. `Graylog2/graylog2-server#6823 <https://github.com/Graylog2/graylog2-server/issues/6823>`_ `Graylog2/graylog2-server#6826 <https://github.com/Graylog2/graylog2-server/issues/6826>`_
- Ensure that aggregation events always have a ``source_streams`` field for permission checks. `Graylog2/graylog2-server#6876 <https://github.com/Graylog2/graylog2-server/issues/6876>`_ `Graylog2/graylog2-server#6877 <https://github.com/Graylog2/graylog2-server/issues/6877>`_
- Fix caching issue with ``route_to_stream`` pipeline function. `Graylog2/graylog2-server#4954 <https://github.com/Graylog2/graylog2-server/issues/4954>`_ `Graylog2/graylog2-server#6788 <https://github.com/Graylog2/graylog2-server/issues/6788>`_
- Fix issue with calculating index ranges. `Graylog2/graylog2-server#6828 <https://github.com/Graylog2/graylog2-server/issues/6828>`_ `Graylog2/graylog2-server#6957 <https://github.com/Graylog2/graylog2-server/issues/6957>`_
  **Attention:** If you are affected by `Graylog2/graylog2-server#6828 <https://github.com/Graylog2/graylog2-server/issues/6828>`_, you have to manually recalculated index ranges for all your index sets.
- Improve API browser for event resources. `Graylog2/graylog2-server#6742 <https://github.com/Graylog2/graylog2-server/issues/6742>`_ `Graylog2/graylog2-server#6955 <https://github.com/Graylog2/graylog2-server/issues/6955>`_
- Fix message indexing issue that could potentially stop message indexing completely. `Graylog2/graylog2-server#5091 <https://github.com/Graylog2/graylog2-server/issues/5091>`_ `Graylog2/graylog2-server#6965 <https://github.com/Graylog2/graylog2-server/issues/6965>`_ `Graylog2/graylog2-server#7071 <https://github.com/Graylog2/graylog2-server/issues/7071>`_


Integrations Plugin
^^^^^^^^^^^^^^^^^^^

**Added**

- Add support for automatic authentication scheme for the AWS Kinesis integration. (environment variables, Java properties, instance roles) `Graylog2/graylog-plugin-integrations#264 <https://github.com/Graylog2/graylog-plugin-integrations/issues/264>`_ `Graylog2/graylog-plugin-integrations#279 <https://github.com/Graylog2/graylog-plugin-integrations/issues/279>`_
- Add "assume role" support for AWS Kinesis integration. `Graylog2/graylog-plugin-integrations#264 <https://github.com/Graylog2/graylog-plugin-integrations/issues/264>`_ `Graylog2/graylog-plugin-integrations#279 <https://github.com/Graylog2/graylog-plugin-integrations/issues/279>`_


**Fixed**

- Fix rate limit issue with AWS Kinesis streams. `Graylog2/graylog-plugin-integrations#341 <https://github.com/Graylog2/graylog-plugin-integrations/issues/341>`_ `Graylog2/graylog-plugin-integrations#342 <https://github.com/Graylog2/graylog-plugin-integrations/issues/342>`_

Graylog 3.1.3
=============

Released: 2019-11-06

Core
^^^^

**Added**

- Add test button to allow testing of event notifications. `Graylog2/graylog2-server#6138 <https://github.com/Graylog2/graylog2-server/issues/6138>`__ `Graylog2/graylog2-server#6549 <https://github.com/Graylog2/graylog2-server/issues/6549>`__
- Add support for MaxMind ASN database type in lookup tables. `Graylog2/graylog2-server#6631 <https://github.com/Graylog2/graylog2-server/issues/6631>`__
- Add ``metric_counter_inc`` pipeline function. `Graylog2/graylog2-server#6644 <https://github.com/Graylog2/graylog2-server/issues/6644>`__
- Add ``length`` pipeline function. `Graylog2/graylog2-server#6645 <https://github.com/Graylog2/graylog2-server/issues/6645>`__
- Add ``traffic_accounting_size`` pipeline function. `Graylog2/graylog2-server#6646 <https://github.com/Graylog2/graylog2-server/issues/6646>`__
- Implement pipeline rule timers to help debugging slow rules. `Graylog2/graylog2-server#5494 <https://github.com/Graylog2/graylog2-server/issues/5494>`__ `Graylog2/graylog2-server#6680 <https://github.com/Graylog2/graylog2-server/issues/6680>`__


**Changed**

- Hide event streams from pipelines because events are currently not supported in pipeline rules. `Graylog2/graylog2-server#6454 <https://github.com/Graylog2/graylog2-server/issues/6454>`__ `Graylog2/graylog2-server#6545 <https://github.com/Graylog2/graylog2-server/issues/6545>`__
- Increase default connection limits for Elasticsearch connections. `Graylog2/graylog2-server#4637 <https://github.com/Graylog2/graylog2-server/issues/4637>`__ `Graylog2/graylog2-server#6679 <https://github.com/Graylog2/graylog2-server/issues/6679>`__

**Fixed**

- Fix problem with message highlighting. `Graylog2/graylog2-server#6511 <https://github.com/Graylog2/graylog2-server/issues/6511>`__ `Graylog2/graylog2-server#6526 <https://github.com/Graylog2/graylog2-server/issues/6526>`__
- Improve event and alert processing on nodes with low ingest rates. `Graylog2/graylog2-server#6453 <https://github.com/Graylog2/graylog2-server/issues/6453>`__ `Graylog2/graylog2-server#6548 <https://github.com/Graylog2/graylog2-server/issues/6548>`__
- Remove event streams from global search to fix custom sorting issue. `Graylog2/graylog2-server#6384 <https://github.com/Graylog2/graylog2-server/issues/6384>`__ `Graylog2/graylog2-server#6544 <https://github.com/Graylog2/graylog2-server/issues/6544>`__
- Fix event processing on nodes with a disabled journal. `Graylog2/graylog2-server#6449 <https://github.com/Graylog2/graylog2-server/issues/6449>`__ `Graylog2/graylog2-server#6547 <https://github.com/Graylog2/graylog2-server/issues/6547>`__
- Fix UI problem with select components. `Graylog2/graylog2-server#6554 <https://github.com/Graylog2/graylog2-server/issues/6554>`__
- Fix problem adding multiple percentile aggregations in views. `Graylog2/graylog2-server#6597 <https://github.com/Graylog2/graylog2-server/issues/6597>`__ `Graylog2/graylog2-server#6638 <https://github.com/Graylog2/graylog2-server/issues/6638>`__
- Fix API browser links in setups with multiple nodes. `Graylog2/graylog2-server#2360 <https://github.com/Graylog2/graylog2-server/issues/2360>`__ `Graylog2/graylog2-server#5920 <https://github.com/Graylog2/graylog2-server/issues/5920>`__ `Graylog2/graylog2-server#6636 <https://github.com/Graylog2/graylog2-server/issues/6636>`__
- Fix display of backlog size for legacy event notification plugins. `Graylog2/graylog2-server#6647 <https://github.com/Graylog2/graylog2-server/issues/6647>`__
- Fix issue with MongoDB index creation. `Graylog2/graylog2-server#6383 <https://github.com/Graylog2/graylog2-server/issues/6383>`__ `Graylog2/graylog2-server#6643 <https://github.com/Graylog2/graylog2-server/issues/6643>`__
- Fix stream permission checks for view searches. `Graylog2/graylog2-server#6651 <https://github.com/Graylog2/graylog2-server/issues/6651>`__
- Fix stream sorting in streams filter option in views. `Graylog2/graylog2-server#6514 <https://github.com/Graylog2/graylog2-server/issues/6514>`__ `Graylog2/graylog2-server#6657 <https://github.com/Graylog2/graylog2-server/issues/6657>`__
- Fix problem with event index set migration. `Graylog2/graylog2-server#6507 <https://github.com/Graylog2/graylog2-server/issues/6507>`__ `Graylog2/graylog2-server#6662 <https://github.com/Graylog2/graylog2-server/issues/6662>`__ `Graylog2/graylog2-server#6674 <https://github.com/Graylog2/graylog2-server/issues/6674>`__
- Ensure Grok pattern reloading on bulk pattern import. `Graylog2/graylog2-server#6673 <https://github.com/Graylog2/graylog2-server/issues/6673>`__
- Fix error handling in pipeline parser. `Graylog2/graylog2-server#6696 <https://github.com/Graylog2/graylog2-server/issues/6696>`__ `Graylog2/graylog2-server#6731 <https://github.com/Graylog2/graylog2-server/issues/6731>`__

Integrations Plugin
^^^^^^^^^^^^^^^^^^^

**Fixed**

- Fix checkpointing AWS Kinesis streams. `Graylog2/graylog-plugin-integrations#286 <https://github.com/Graylog2/graylog-plugin-integrations/issues/286>`__ `Graylog2/graylog-plugin-integrations#294 <https://github.com/Graylog2/graylog-plugin-integrations/issues/294>`__

Graylog 3.1.2
=============

Released: 2019-09-12

Core
^^^^

**Fixed**

- Cannot read property 'query' of undefined when replaying search `Graylog2/graylog2-server#6355 <https://github.com/Graylog2/graylog2-server/pull/6355>`__
- Cannot focus input fields in modal form (Dashboard) `Graylog2/graylog2-server#6356 <https://github.com/Graylog2/graylog2-server/pull/6356>`__
- Server start fails with `Index with name: compound_0 already exists with a different name` `Graylog2/graylog2-server#6383 <https://github.com/Graylog2/graylog2-server/pull/6383>`__
- Alerting not working if cluster contains nodes with no active inputs `Graylog2/graylog2-server#6415 <https://github.com/Graylog2/graylog2-server/pull/6415>`__

Graylog 3.1.1
=============

Released: 2019-09-04

Core
^^^^

**Fixed**

- Error when loading a view. `Graylog2/graylog2-server#6346 <https://github.com/Graylog2/graylog2-server/pull/6346>`__
- Fix server startup issue resulting from long index name. `Graylog2/graylog2-server#6322 <https://github.com/Graylog2/graylog2-server/issues/6322>`__

Integrations Plugin
^^^^^^^^^^^^^^^^^^^

**Added**

- Add a new :doc:`/pages/integrations/inputs/aws_kinesis_cloudwatch_input` to Graylog, which guides the user through the setup process and performs checks
  along the way. It also supports an automated CloudWatch Logs to Kinesis Streams setup which helps to automate much
  of the complicated manual setup.

Graylog 3.1.0
=============

Released: 2019-08-16

Views & Extended Search
^^^^^^^^^^^^^^^^^^^^^^^

- This feature was partially (everything besides support for parameters in queries)  open-sourced in this version. Formerly it was accessible only through the commercial enterprise plugin.
- The API prefix for the views/extended search endpoints has changed from ``/api/plugins/org.graylog.plugins.enterprise/(views|search)`` to ``/api/views`` & ``/api/views/search``.
- The configuration file directive specifying the maximum age of an unreferenced search object before it is purged has changed from ``enterprise_search_maximum_search_age`` to ``views_maximum_search_age``.

Core
^^^^

**Added**

- Add ``GracefulShutdownService`` Java API to allow plugins to participate in a graceful server shutdown. `Graylog2/graylog2-server#5738 <https://github.com/Graylog2/graylog2-server/issues/5738>`__
- Add ``MessageOutput.Factory2`` Java API to allow writing output plugins that receive the output instance ID. `Graylog2/graylog2-server#5670 <https://github.com/Graylog2/graylog2-server/issues/5670>`__
- Add metrics for Sidecar HTTP API resources. `Graylog2/graylog2-server#5632 <https://github.com/Graylog2/graylog2-server/issues/5632>`__
- Add new pipeline rule function ``grok_exists`` to check for the existence of Grok patterns. `Graylog2/graylog2-server#5699 <https://github.com/Graylog2/graylog2-server/issues/5699>`__ `Graylog2/graylog2-server#5689 <https://github.com/Graylog2/graylog2-server/issues/5689>`__
- Allow the ``group.id`` setting in a Kafka input to be configured by users. `Graylog2/graylog2-server#5867 <https://github.com/Graylog2/graylog2-server/issues/5867>`__ `Graylog2/graylog2-server#3976 <https://github.com/Graylog2/graylog2-server/issues/3976>`__ (Thank you `@pdepaepe <https://github.com/pdepaepe>`__)
- Add "show documents for value" field value action to views.
- Add automatic refresh feature to views search.
- Add support for extractor creation links to views.
- Add support for highlighting terms in message search results in views.
- Allow user defined granularity for auto interval time-bucketing in views.
- Add views action to duplicate query tabs. (including widgets)
- Make message fields in views message list sortable.
- Add support for stacked bar charts in views.
- Make colors in view charts configurable.
- Add support for percentile metrics in views.
- Add syntax highlighting for pipeline rule editor. `Graylog2/graylog2-server#5957 <https://github.com/Graylog2/graylog2-server/issues/5957>`__
- Add new alerts and events system.
- Add default events and system events streams. `Graylog2/graylog2-server#6089 <https://github.com/Graylog2/graylog2-server/issues/6089>`__ `Graylog2/graylog2-server#6085 <https://github.com/Graylog2/graylog2-server/issues/6085>`__
- Add default ``gl2_message_id`` field for each new message. `Graylog2/graylog2-server#6074 <https://github.com/Graylog2/graylog2-server/issues/6074>`__ `Graylog2/graylog2-server#5994 <https://github.com/Graylog2/graylog2-server/issues/5994>`__
- Add *experimental* JDK 11 support. `Graylog2/graylog2-server#5909 <https://github.com/Graylog2/graylog2-server/issues/5909>`__ (please don't use in production, yet)
- Add default filebeat collector config for Windows. `Graylog2/graylog2-server#6287 <https://github.com/Graylog2/graylog2-server/issues/6287>`__ `Graylog2/collector-sidecar#350 <https://github.com/Graylog2/collector-sidecar/issues/350>`__

**Changed**

- Add a high-resolution logo and favicon and optimize all image files. `Graylog2/graylog2-server#5748 <https://github.com/Graylog2/graylog2-server/issues/5748>`__
- Improve autogenerated UI elements for boolean fields. `Graylog2/graylog2-server#5678 <https://github.com/Graylog2/graylog2-server/issues/5678>`__
- Make modal dialogs only close with ESC key, Cancel and "X" buttons. They don't close anymore when users click outside of the modal content. `Graylog2/graylog2-server#5823 <https://github.com/Graylog2/graylog2-server/issues/5823>`__
- Improve error messages when updating Grok patterns. `Graylog2/graylog2-server#5629 <https://github.com/Graylog2/graylog2-server/issues/5629>`__
- Improve error messages for search errors. `Graylog2/graylog2-server#5681 <https://github.com/Graylog2/graylog2-server/issues/5681>`__
- Improve navigation bar layout. `Graylog2/graylog2-server#6001 <https://github.com/Graylog2/graylog2-server/issues/6001>`__
- Improve views query autocompletion suggestions.
- Move Save/Cancel buttons in views widget edit mode.
- Use dynamic pager in views message lists. `Graylog2/graylog2-server#6090 <https://github.com/Graylog2/graylog2-server/issues/6090>`__
- Set default value for email sender to empty value. `Graylog2/graylog2-server#5981 <https://github.com/Graylog2/graylog2-server/issues/5981>`__ (Thank you `@bjoernhaeuser <https://github.com/bjoernhaeuser>`__)
- Improve stream router engine performance. `Graylog2/graylog2-server#6170 <https://github.com/Graylog2/graylog2-server/issues/6170>`__
- Avoid logging excessive exceptions when other Graylog nodes are not reachable via HTTP. `Graylog2/graylog2-server#6229 <https://github.com/Graylog2/graylog2-server/issues/6229>`__
- Darken disabled inputs on the inputs page, making it easier to see when an input is disabled. `Graylog2/graylog2-server#6257 <https://github.com/Graylog2/graylog2-server/issues/6257>`__

**Removed**

- Remove "show documents" action for message widgets.
- Remove old stream alerts system. (replaced by new alerts and events system, including automatic alerts migration)

**Fixed**

- Fix slow loading HTTP API and UI after server startup. `Graylog2/graylog2-server#5669 <https://github.com/Graylog2/graylog2-server/issues/5669>`__
- Fix API path prefixing to allow running Graylog with a sub-path again. `Graylog2/graylog2-server#5703 <https://github.com/Graylog2/graylog2-server/issues/5703>`__ `Graylog2/graylog2-server#5702 <https://github.com/Graylog2/graylog2-server/issues/5702>`__
- Fix issue with dashboard data migration. `Graylog2/graylog2-server#5751 <https://github.com/Graylog2/graylog2-server/issues/5751>`__ `Graylog2/graylog2-server#5737 <https://github.com/Graylog2/graylog2-server/issues/5737>`__
- Add wildcard support to search page query parser. `Graylog2/graylog2-server#5730 <https://github.com/Graylog2/graylog2-server/issues/5730>`__ `Graylog2/graylog2-server#5719 <https://github.com/Graylog2/graylog2-server/issues/5719>`__
- Fix "Expect: 100-Continue" handling in HTTP inputs. `Graylog2/graylog2-server#5725 <https://github.com/Graylog2/graylog2-server/issues/5725>`__ `Graylog2/graylog2-server#5690 <https://github.com/Graylog2/graylog2-server/issues/5690>`__
- Fix HTTP input keep-alive handling. `Graylog2/graylog2-server#5728 <https://github.com/Graylog2/graylog2-server/issues/5728>`__ `Graylog2/graylog2-server#5720 <https://github.com/Graylog2/graylog2-server/issues/5720>`__
- Fix Grok pattern handling with ``OR`` patterns. `Graylog2/graylog2-server#5749 <https://github.com/Graylog2/graylog2-server/issues/5749>`__ `Graylog2/graylog2-server#4773 <https://github.com/Graylog2/graylog2-server/issues/4773>`__
- Fix issues with Cisco ASA NetFlow handling. `Graylog2/graylog2-server#5729 <https://github.com/Graylog2/graylog2-server/issues/5729>`__ `Graylog2/graylog2-server#5715 <https://github.com/Graylog2/graylog2-server/issues/5715>`__
- Fix support for underscores (``__``) in Grok pattern match group names. `Graylog2/graylog2-server#5800 <https://github.com/Graylog2/graylog2-server/issues/5800>`__ `Graylog2/graylog2-server#5704 <https://github.com/Graylog2/graylog2-server/issues/5704>`__ `Graylog2/graylog2-server#5563 <https://github.com/Graylog2/graylog2-server/issues/5563>`__
- Fix auto-completion in several drop-down fields across the UI. `Graylog2/graylog2-server#5665 <https://github.com/Graylog2/graylog2-server/issues/5665>`__ `Graylog2/graylog2-server#5659 <https://github.com/Graylog2/graylog2-server/issues/5659>`__
- Fix problem with loading the extractors page in the UI. `Graylog2/graylog2-server#5954 <https://github.com/Graylog2/graylog2-server/issues/5954>`__ `Graylog2/graylog2-server#5948 <https://github.com/Graylog2/graylog2-server/issues/5948>`__
- Fix links on stream outputs page. `Graylog2/graylog2-server#5953 <https://github.com/Graylog2/graylog2-server/issues/5953>`__ `Graylog2/graylog2-server#5952 <https://github.com/Graylog2/graylog2-server/issues/5952>`__
- Fix edit mode of message widget in views.
- Don't refresh view query when changing query tabs.
- Copy widget filter when creating statistics widget for a field in views.
- Support nested maps in lists for content packs. `Graylog2/graylog2-server#6003 <https://github.com/Graylog2/graylog2-server/issues/6003>`__ `Graylog2/graylog2-server#5742 <https://github.com/Graylog2/graylog2-server/issues/5742>`__
- Reload changed Grok patterns in Grok extractor. `Graylog2/graylog2-server#5982 <https://github.com/Graylog2/graylog2-server/issues/5982>`__ `Graylog2/graylog2-server#5833 <https://github.com/Graylog2/graylog2-server/issues/5833>`__
- Fix support for TLS trusted certificate directories in inputs. `Graylog2/graylog2-server#5958 <https://github.com/Graylog2/graylog2-server/issues/5958>`__ `Graylog2/graylog2-server#5939 <https://github.com/Graylog2/graylog2-server/issues/5939>`__
- Fix plugin UI routes when running the web interface with a sub-path. `Graylog2/graylog2-server#6150 <https://github.com/Graylog2/graylog2-server/issues/6150>`__ `Graylog2/graylog2-server#6149 <https://github.com/Graylog2/graylog2-server/issues/6149>`__
- Fix rendering of events in single message view. `Graylog2/graylog2-server#6156 <https://github.com/Graylog2/graylog2-server/issues/6156>`__ `Graylog2/graylog2-server#6142 <https://github.com/Graylog2/graylog2-server/issues/6142>`__
- Fix rendering of LDAP page. `Graylog2/graylog2-server#6249 <https://github.com/Graylog2/graylog2-server/issues/6249>`__ `Graylog2/graylog2-server#6247 <https://github.com/Graylog2/graylog2-server/issues/6247>`__
- Fix pagination issue with newer JDKs. `Graylog2/graylog2-server#6256 <https://github.com/Graylog2/graylog2-server/issues/6256>`__ `Graylog2/graylog2-server#6254 <https://github.com/Graylog2/graylog2-server/issues/6254>`__
- Fix issue with UDP based inputs becoming unresponsive. `Graylog2/graylog2-server#6263 <https://github.com/Graylog2/graylog2-server/issues/6263>`__ `Graylog2/graylog2-server#5701 <https://github.com/Graylog2/graylog2-server/issues/5701>`__

Graylog 3.0.2
=============

Released: 2019-05-03

**Integrations Plugin**

- Fix issue handling quoted values in PaloAlto input `Graylog2/graylog-plugin-integrations#15 <https://github.com/Graylog2/graylog-plugin-integrations/issues/15>`_ `Graylog2/graylog-plugin-integrations#16 <https://github.com/Graylog2/graylog-plugin-integrations/issues/16>`_


Graylog 3.0.1
=============

Released: 2019-04-01

**Core**

- Fix dashboard position migration. `Graylog2/graylog2-server#5737 <https://github.com/Graylog2/graylog2-server/issues/5737>`_ `Graylog2/graylog2-server#5763 <https://github.com/Graylog2/graylog2-server/issues/5763>`_
- Fix HTTP 100 handling in http inputs. `Graylog2/graylog2-server#5690 <https://github.com/Graylog2/graylog2-server/issues/5690>`_ `Graylog2/graylog2-server#5725 <https://github.com/Graylog2/graylog2-server/issues/5725>`_
- Fix http input keep-alive handling. `Graylog2/graylog2-server#5720 <https://github.com/Graylog2/graylog2-server/issues/5720>`_ `Graylog2/graylog2-server#5728 <https://github.com/Graylog2/graylog2-server/issues/5728>`_
- Fix running Graylog web interface under a path prefix. `Graylog2/graylog2-server#5702 <https://github.com/Graylog2/graylog2-server/issues/5702>`_ `Graylog2/graylog2-server#5703 <https://github.com/Graylog2/graylog2-server/issues/5703>`_
- Fix issue with wildcards in the search query parser when running with newer Elasticsearch versions. `Graylog2/graylog2-server#5719 <https://github.com/Graylog2/graylog2-server/issues/5719>`_ `Graylog2/graylog2-server#5766 <https://github.com/Graylog2/graylog2-server/issues/5766>`_
- Fix Grok patterns that use "OR" to not return "null" values. `Graylog2/graylog2-server#4773 <https://github.com/Graylog2/graylog2-server/issues/4773>`_ `Graylog2/graylog2-server#5749 <https://github.com/Graylog2/graylog2-server/issues/5749>`_
- Fix NetFlow parsing for Cisco ASA devices. `Graylog2/graylog2-server#5715 <https://github.com/Graylog2/graylog2-server/issues/5715>`_ `Graylog2/graylog2-server#5729 <https://github.com/Graylog2/graylog2-server/issues/5729>`_
- Fix Grok patterns to support underscores in match group names again. `Graylog2/graylog2-server#5704 <https://github.com/Graylog2/graylog2-server/issues/5704>`_ `Graylog2/graylog2-server#5563 <https://github.com/Graylog2/graylog2-server/issues/5563>`_ `Graylog2/graylog2-server#5800 <https://github.com/Graylog2/graylog2-server/issues/5800>`_
- Document password escaping issue for the MongoDB connection URL. `Graylog2/graylog2-server#5680 <https://github.com/Graylog2/graylog2-server/issues/5680>`_ `Graylog2/graylog2-server#5764 <https://github.com/Graylog2/graylog2-server/issues/5764>`_

**Integrations Plugin**

- Fix input parsing problem in PaloAlto input. `Graylog2/graylog-plugin-integrations#10 <https://github.com/Graylog2/graylog-plugin-integrations/issues/10>`_ `Graylog2/graylog-plugin-integrations#11 <https://github.com/Graylog2/graylog-plugin-integrations/issues/11>`_

**Threatintel Plugin**

- Fix problem with content pack migration. `Graylog2/graylog-plugin-threatintel#123 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/123>`_

Graylog 3.0.0
=============

Released: 2019-02-14

- Announcement blog post: https://www.graylog.org/post/announcing-graylog-v3-0-ga
- Upgrade notes: :doc:`/pages/upgrade/graylog-3.0`

A detailed changelog is following soon!

Graylog 2.5.2
=============

Released: 2019-03-15

**Core**

- Mask password fields of inputs returned by the REST API.  `Graylog2/graylog2-server#5432 <https://github.com/Graylog2/graylog2-server/issues/5432>`_ `Graylog2/graylog2-server#5733 <https://github.com/Graylog2/graylog2-server/issues/5733>`_

**Integrations Plugin**

- Fix input parsing problem in PaloAlto input. `Graylog2/graylog-plugin-integrations#10 <https://github.com/Graylog2/graylog-plugin-integrations/issues/10>`_ `Graylog2/graylog-plugin-integrations#11 <https://github.com/Graylog2/graylog-plugin-integrations/issues/11>`_

Graylog 2.5.1
=============

Released: 2018-12-19

**Core**

- Improve description of ``web_endpoint_uri`` in ``graylog.conf``. `Graylog2/graylog2-server#5359 <https://github.com/Graylog2/graylog2-server/issues/5359>`_
- Add CSRF backward compatibility for older Sidecars. `Graylog2/graylog2-server#5388 <https://github.com/Graylog2/graylog2-server/issues/5388>`_ `Graylog2/graylog2-server#4987 <https://github.com/Graylog2/graylog2-server/issues/4987>`_

**AWS Plugin**

- Remove low limit for GZIP decompression of AWS events. `Graylog2/graylog-plugin-aws#98 <https://github.com/Graylog2/graylog-plugin-aws/issues/98>`_

**Pipeline Processor Plugin**

- Fix IPv6 handling in IPv4 ``cidr_match`` pipeline function. `Graylog2/graylog-plugin-pipeline-processor#254 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/254>`_ `Graylog2/graylog2-server#5405 <https://github.com/Graylog2/graylog2-server/issues/5405>`_

Graylog 2.5.0
=============

Released: 2018-11-30

**Core**

- Improve CSRF protection by requiring a custom HTTP header for non-GET requests sent to the API. (`requires sidecar 0.1.7 <https://github.com/Graylog2/collector-sidecar/releases/tag/0.1.7)>`_) `Graylog2/graylog2-server#4998 <https://github.com/Graylog2/graylog2-server/issues/4998>`_ `Graylog2/graylog2-server#5012 <https://github.com/Graylog2/graylog2-server/issues/5012>`_ `Graylog2/graylog2-server#5182 <https://github.com/Graylog2/graylog2-server/issues/5182>`_
- Improve alert conditions by making the query string configurable. `Graylog2/graylog2-server#5277 <https://github.com/Graylog2/graylog2-server/issues/5277>`_ `Graylog2/graylog2-server#3966 <https://github.com/Graylog2/graylog2-server/issues/3966>`_
- Improve alert overview for streams. `Graylog2/graylog2-server#5311 <https://github.com/Graylog2/graylog2-server/issues/5311>`_
- Add test button for alert conditions. `Graylog2/graylog2-server#5322 <https://github.com/Graylog2/graylog2-server/issues/5322>`_
- Add DNS lookup adapter that supports foward and reverse lookups. `Graylog2/graylog2-server#5274 <https://github.com/Graylog2/graylog2-server/issues/5274>`_ `Graylog2/graylog2-server#4200 <https://github.com/Graylog2/graylog2-server/issues/4200>`_ `Graylog2/graylog2-server#5124 <https://github.com/Graylog2/graylog2-server/issues/5124>`_ `Graylog2/graylog-plugin-threatintel#64 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/64>`_
- Add support for Elasticsearch 6.x. `Graylog2/graylog2-server#5020 <https://github.com/Graylog2/graylog2-server/issues/5020>`_ `Graylog2/graylog2-server#5064 <https://github.com/Graylog2/graylog2-server/issues/5064>`_
- Update time zone database for the web interface. `Graylog2/graylog2-server#5260 <https://github.com/Graylog2/graylog2-server/issues/5260>`_ `Graylog2/graylog2-server#5245 <https://github.com/Graylog2/graylog2-server/issues/5245>`_
- Fix description and default values for the DSV HTTP lookup table adapter. `Graylog2/graylog2-server#4973 <https://github.com/Graylog2/graylog2-server/issues/4973>`_ `@zionio <https://github.com/zionio>`_
- Fix slow and unreliable CSV export by using a bigger default batch size. `Graylog2/graylog2-server#5172 <https://github.com/Graylog2/graylog2-server/issues/5172>`_ `Graylog2/graylog2-server#5304 <https://github.com/Graylog2/graylog2-server/issues/5304>`_
- Fix index stats in index set overview. `Graylog2/graylog2-server#5306 <https://github.com/Graylog2/graylog2-server/issues/5306>`_
- Fix security issue with the users API where regular users could retrieve details of other users. `Graylog2/graylog2-server#5308 <https://github.com/Graylog2/graylog2-server/issues/5308>`_ `Graylog2/graylog2-server#5068 <https://github.com/Graylog2/graylog2-server/issues/5068>`_ `@radykal-com <https://github.com/radykal-com>`_
- Fix backslash escaping for phrase searches. `Graylog2/graylog2-server#5314 <https://github.com/Graylog2/graylog2-server/issues/5314>`_ `Graylog2/graylog2-server#4111 <https://github.com/Graylog2/graylog2-server/issues/4111>`_ `Graylog2/graylog2-server#5266 <https://github.com/Graylog2/graylog2-server/issues/5266>`_

**Integrations Plugin**

* Add Palo Alto input

**AWS Plugin**

- Add throttling support to the AWS Flow Logs input. `Graylog2/graylog-plugin-aws#94 <https://github.com/Graylog2/graylog-plugin-aws/issues/94>`_ `Graylog2/graylog-plugin-aws#85 <https://github.com/Graylog2/graylog-plugin-aws/issues/85>`_
- Improve logging for the CloudTrail input. `Graylog2/graylog-plugin-aws#95 <https://github.com/Graylog2/graylog-plugin-aws/issues/95>`_ `Graylog2/graylog-plugin-aws#80 <https://github.com/Graylog2/graylog-plugin-aws/issues/80>`_

**Pipeline Processor Plugin**

- Fix key-value function to be more robust with splitting values. `Graylog2/graylog-plugin-pipeline-processor#249 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/249>`_ `Graylog2/graylog2-server#4920 <https://github.com/Graylog2/graylog2-server/issues/4920>`_ `@radykal-com <https://github.com/radykal-com>`_
- Add support for decimal IPv4 representation in the ``to_ip`` function. `Graylog2/graylog-plugin-pipeline-processor#253 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/253>`_ `Graylog2/graylog2-server#5268 <https://github.com/Graylog2/graylog2-server/issues/5268>`_

Graylog 2.4.7
=============

Released: 2019-03-01

**Core**

- Mask password fields of inputs returned by the REST API. `Graylog2/graylog2-server#5408 <https://github.com/Graylog2/graylog2-server/issues/5408>`_ `Graylog2/graylog2-server#5734 <https://github.com/Graylog2/graylog2-server/issues/5734>`_

Graylog 2.4.6
=============

Released: 2018-07-16

**Core**

- Unbreak input throttling by publishing throttle state again. `Graylog2/graylog2-server#4850 <https://github.com/Graylog2/graylog2-server/issues/4850>`_ `Graylog2/graylog2-server#4321 <https://github.com/Graylog2/graylog2-server/issues/4321>`_
- Check for permission before terminating input. `Graylog2/graylog2-server#4867 <https://github.com/Graylog2/graylog2-server/issues/4867>`_ `Graylog2/graylog2-server#4858 <https://github.com/Graylog2/graylog2-server/issues/4858>`_
- Require user to be authenticated to retrieve plugin list. `Graylog2/graylog2-server#4868 <https://github.com/Graylog2/graylog2-server/issues/4868>`_ `Graylog2/graylog2-server#4863 <https://github.com/Graylog2/graylog2-server/issues/4863>`_
- Add missing permission checks. `Graylog2/graylog2-server#4873 <https://github.com/Graylog2/graylog2-server/issues/4873>`_ `Graylog2/graylog2-server#4861 <https://github.com/Graylog2/graylog2-server/issues/4861>`_ `Graylog2/graylog2-server#4859 <https://github.com/Graylog2/graylog2-server/issues/4859>`_
- UI fixes for index rotation strategy dropdown. `Graylog2/graylog2-server#4826 <https://github.com/Graylog2/graylog2-server/issues/4826>`_ `Graylog2/graylog2-server#4769 <https://github.com/Graylog2/graylog2-server/issues/4769>`_
- XSS fix for typeahead components. `Graylog2/graylog2-server#4904 <https://github.com/Graylog2/graylog2-server/issues/4904>`_
- Fix potential NullPointerException in csv and maxmind data adapters. `Graylog2/graylog2-server#4912 <https://github.com/Graylog2/graylog2-server/issues/4912>`_ `Graylog2/graylog2-server#4748 <https://github.com/Graylog2/graylog2-server/issues/4748>`_
- Add "http_non_proxy_hosts" configuration option. `Graylog2/graylog2-server#4915 <https://github.com/Graylog2/graylog2-server/issues/4915>`_ `Graylog2/graylog2-server#4905 <https://github.com/Graylog2/graylog2-server/issues/4905>`_ `Graylog2/graylog2-server#4392 <https://github.com/Graylog2/graylog2-server/issues/4392>`_

Graylog 2.4.5
=============

Released: 2018-05-28

**Core**

- Improve HTTP proxy authentication to support more proxy server software. `Graylog2/graylog2-server#4788 <https://github.com/Graylog2/graylog2-server/issues/4788>`_ `Graylog2/graylog2-server#4790 <https://github.com/Graylog2/graylog2-server/issues/4790>`_
- Fix an issue where the Elasticsearch URL credentials have been written to the Graylog log file. `Graylog2/graylog2-server#4804 <https://github.com/Graylog2/graylog2-server/issues/4804>`_ `Graylog2/graylog2-server#4806 <https://github.com/Graylog2/graylog2-server/issues/4806>`_
- Fix issue with deleting dashboard widgets. `Graylog2/graylog2-server#4525 <https://github.com/Graylog2/graylog2-server/issues/4525>`_ `Graylog2/graylog2-server#4808 <https://github.com/Graylog2/graylog2-server/issues/4808>`_

Graylog 2.4.4
=============

Released: 2018-05-02

**Core**

- Fix issues with loading example message for extractor. `Graylog2/graylog2-server#4553 <https://github.com/Graylog2/graylog2-server/issues/4553>`_ `Graylog2/graylog2-server#4559 <https://github.com/Graylog2/graylog2-server/pull/4559>`_
- Allow ``:`` character in password. `Graylog2/graylog2-server/#4557 <https://github.com/Graylog2/graylog2-server/pull/4557>`_
- Fix lookup table cache entry count metric. `Graylog2/graylog2-server#4558 <https://github.com/Graylog2/graylog2-server/pull/4558>`_
- Simplify plugin development for lookup table plugins. `Graylog2/graylog2-server#4586 <https://github.com/Graylog2/graylog2-server/pull/4586>`_ `Graylog2/graylog2-server#4587 <https://github.com/Graylog2/graylog2-server/pull/4587>`_
- Fix security issue with unescaped text in notification and dashboard names. `Graylog2/graylog2-server#4727 <https://github.com/Graylog2/graylog2-server/pull/4727>`_ `Graylog2/graylog2-server#4739 <https://github.com/Graylog2/graylog2-server/pull/4739>`_
- Improve high-availability behavior with missing Elasticsearch nodes. `Graylog2/graylog2-server#4738 <https://github.com/Graylog2/graylog2-server/issues/4738>`_
- Fix issue with updating saved searches. `Graylog2/graylog2-server#2285 <https://github.com/Graylog2/graylog2-server/pull/2285>`_ `Graylog2/graylog2-server#4743 <https://github.com/Graylog2/graylog2-server/pull/4743>`_
- Fix issue assigning stream outputs to the default stream. `Graylog2/graylog2-server#4747 <https://github.com/Graylog2/graylog2-server/pull/4747>`_ `Graylog2/graylog2-server#4754 <https://github.com/Graylog2/graylog2-server/pull/4754>`_
- Improve rendering of input configuration forms.  `Graylog2/graylog2-server#4755 <https://github.com/Graylog2/graylog2-server/pull/4755>`_ `Graylog2/graylog2-server#4745 <https://github.com/Graylog2/graylog2-server/issues/4745>`_ by `@Al2Klimov <https://github.com/Al2Klimov>`_
- Add code to allow HTTP proxy authentication in ``http_proxy_uri`` config option. `Graylog2/graylog2-server#4594 <https://github.com/Graylog2/graylog2-server/issues/4594>`_ `Graylog2/graylog2-server#4758 <https://github.com/Graylog2/graylog2-server/pull/4758>`_

**ThreatIntel Plugin**

- Fix issue with missing threat names in lookup results. `Graylog2/graylog-plugin-threatintel#99 <https://github.com/Graylog2/graylog-plugin-threatintel/pull/99>`_ by `@pbr0ck3r <https://github.com/pbr0ck3r>`_

**AWS Plugin**

- Support new AWS regions. `Graylog2/graylog-plugin-aws#71 <https://github.com/Graylog2/graylog-plugin-aws/pull/71>`_ `Graylog2/graylog-plugin-aws#73 <https://github.com/Graylog2/graylog-plugin-aws/pull/73>`_ `Graylog2/graylog-plugin-aws#75 <https://github.com/Graylog2/graylog-plugin-aws/pull/75>`_

Graylog 2.4.3
=============

Released: 2018-01-24

https://www.graylog.org/blog/108-announcing-graylog-v2-4-3

**Core**

* Fix timezone issue when using the timestamp field in quick values. `Graylog2/graylog2-server#4519 <https://github.com/Graylog2/graylog2-server/issues/4519>`_ `Graylog2/graylog2-server#4509 <https://github.com/Graylog2/graylog2-server/issues/4509>`_


Graylog 2.4.2
=============

Released: 2018-01-24

**Core**

* Fix issue with creating dashboards as non-admin user. `Graylog2/graylog2-server#4505 <https://github.com/Graylog2/graylog2-server/issues/4505>`_ `Graylog2/graylog2-server#4511 <https://github.com/Graylog2/graylog2-server/issues/4511>`_
* Fix edge case in recent message loader for extractors. `Graylog2/graylog2-server#4513 <https://github.com/Graylog2/graylog2-server/issues/4513>`_ `Graylog2/graylog2-server#4510 <https://github.com/Graylog2/graylog2-server/issues/4510>`_
* Fix formatting issue when using quick values on the timestamp field. `Graylog2/graylog2-server#4423 <https://github.com/Graylog2/graylog2-server/issues/4423>`_ `Graylog2/graylog2-server#4288 <https://github.com/Graylog2/graylog2-server/issues/4288>`_
* Fix issue with handling the timestamp field in stacked quick value widgets. `Graylog2/graylog2-server#4516 <https://github.com/Graylog2/graylog2-server/issues/4516>`_ `Graylog2/graylog2-server#4509 <https://github.com/Graylog2/graylog2-server/issues/4509>`_

**Threatintel Plugin**

* Fix README.md about ``tor_lookup()`` function. `Graylog2/graylog2-server#86 <https://github.com/Graylog2/graylog2-server/issues/86>`_


Graylog 2.4.1
=============

Released: 2018-01-19

https://www.graylog.org/blog/107-announcing-graylog-v2-4-1

**Core**

* Fix SyslogCodecTest.testCiscoSyslogMessages. `Graylog2/graylog2-server#4446 <https://github.com/Graylog2/graylog2-server/issues/4446>`_
* Fix privileges for input start/stop operations. `Graylog2/graylog2-server#4454 <https://github.com/Graylog2/graylog2-server/issues/4454>`_ `Graylog2/graylog2-server#4455 <https://github.com/Graylog2/graylog2-server/issues/4455>`_ `Graylog2/graylog2-server#4439 <https://github.com/Graylog2/graylog2-server/issues/4439>`_
* Fix problem with Elasticsearch indexing over HTTPS. `Graylog2/graylog2-server#4485 <https://github.com/Graylog2/graylog2-server/issues/4485>`_ `Graylog2/graylog2-server#4232 <https://github.com/Graylog2/graylog2-server/issues/4232>`_
* Fix web plugin compatibility problem. `Graylog2/graylog2-server#4496 <https://github.com/Graylog2/graylog2-server/issues/4496>`_
* Fix problem that didn't allow a reader user to edit their own profile. `Graylog2/graylog2-server#4488 <https://github.com/Graylog2/graylog2-server/issues/4488>`_ `Graylog2/graylog2-server#4494 <https://github.com/Graylog2/graylog2-server/issues/4494>`_ `Graylog2/graylog2-server#4442 <https://github.com/Graylog2/graylog2-server/issues/4442>`_ `Graylog2/graylog2-server#4420 <https://github.com/Graylog2/graylog2-server/issues/4420>`_

**Pipeline Processor Plugin**

* Fix pipeline interpreter log message by handing change event. `Graylog2/graylog-plugin-pipeline-processor#235 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/235>`_ `Graylog2/graylog-plugin-pipeline-processor#241 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/241>`_

**AWS Plugin**

* Fix problem updating the AWS configuration in the UI. `Graylog2/graylog-plugin-aws#58 <https://github.com/Graylog2/graylog-plugin-aws/issues/58>`_ `Graylog2/graylog-plugin-aws#60 <https://github.com/Graylog2/graylog-plugin-aws/issues/60>`_
* Add missing proxy configuration option to UI. `Graylog2/graylog-plugin-aws#59 <https://github.com/Graylog2/graylog-plugin-aws/issues/59>`_ `Graylog2/graylog-plugin-aws#61 <https://github.com/Graylog2/graylog-plugin-aws/issues/61>`_


**Threatintel Plugin**

* Fix ``otx_lookup_domain`` pipeline function. `Graylog2/graylog-plugin-threatintel#83 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/83>`_ `Graylog2/graylog2-server#4489 <https://github.com/Graylog2/graylog2-server/issues/4489>`_


Graylog 2.4.0
=============

Released: 2017-12-22

https://www.graylog.org/blog/106-announcing-graylog-v2-4-0

No changes since 2.4.0-rc.2.


Graylog 2.4.0-rc.2
==================

Released: 2017-12-20

**Core**

* Fixed node-id validator problem by removing the validator for now. `Graylog2/graylog2-server#4433 <https://github.com/Graylog2/graylog2-server/issues/4433>`_


Graylog 2.4.0-rc.1
==================

Released: 2017-12-19

https://www.graylog.org/blog/105-announcing-graylog-v2-4-0-rc-1

**Core**

* Fix problem with new node-id file check that got introduced in 2.4.0-beta.4. `Graylog2/graylog2-server#4428 <https://github.com/Graylog2/graylog2-server/issues/4428>`_ # 4427

**Threatintel Plugin**

* Improve Whois data adapter to always use the ARIN registry for now. `Graylog2/graylog2-server#78 <https://github.com/Graylog2/graylog2-server/issues/78>`_ 76
* Fix object comparison in Whois data adapter. `Graylog2/graylog2-server#69 <https://github.com/Graylog2/graylog2-server/issues/69>`_


Graylog 2.4.0-beta.4
====================

Released: 2017-12-15

**Core**

* Improve HTTPJSONPath lookup table data adapter UI. `Graylog2/graylog2-server#4406 <https://github.com/Graylog2/graylog2-server/issues/4406>`_
* Add and use ExternalLink and ExternalLinkButton components. `Graylog2/graylog2-server#4414 <https://github.com/Graylog2/graylog2-server/issues/4414>`_
* Improve UI components when user lacks permissions. `Graylog2/graylog2-server#4416 <https://github.com/Graylog2/graylog2-server/issues/4416>`_ `Graylog2/graylog2-server#4407 <https://github.com/Graylog2/graylog2-server/issues/4407>`_
* Fix output traffic graph on "System/Overview". `Graylog2/graylog2-server#4418 <https://github.com/Graylog2/graylog2-server/issues/4418>`_ `Graylog2/graylog2-server#4395 <https://github.com/Graylog2/graylog2-server/issues/4395>`_
* Improve query suggestions for field existence. `Graylog2/graylog2-server#4422 <https://github.com/Graylog2/graylog2-server/issues/4422>`_ `Graylog2/graylog2-server#4362 <https://github.com/Graylog2/graylog2-server/issues/4362>`_
* Check node-id file permissions and improve error messages. `Graylog2/graylog2-server#4417 <https://github.com/Graylog2/graylog2-server/issues/4417>`_ `Graylog2/graylog2-server#4410 <https://github.com/Graylog2/graylog2-server/issues/4410>`_

**Pipeline Processor Plugin**

* Fix problem with ``null`` values in the ``select_jsonpath`` function. `Graylog2/graylog-plugin-pipeline-processor#233 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/233>`_ `Graylog2/graylog-plugin-pipeline-processor#232 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/232>`_

**Threatintel Plugin**

* Fix several issues with OTX and Whois data adapters. `Graylog2/graylog-plugin-threatintel#75 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/75>`_

**Anonymous Usage-Stats Plugin**

* The plugin got removed.


Graylog 2.4.0-beta.3
====================

Released: 2017-12-04

**Core**

* Improve documentation for outputbuffer settings. `Graylog2/graylog2-server#4331 <https://github.com/Graylog2/graylog2-server/issues/4331>`_
* Improve QuickValues stacking. `Graylog2/graylog2-server#4343 <https://github.com/Graylog2/graylog2-server/issues/4343>`_
* Improve auth providers UI. `Graylog2/graylog2-server#4347 <https://github.com/Graylog2/graylog2-server/issues/4347>`_
* Add pluggable global notification area to page. `Graylog2/graylog2-server#4353 <https://github.com/Graylog2/graylog2-server/issues/4353>`_ `Graylog2/graylog2-server#4389 <https://github.com/Graylog2/graylog2-server/issues/4389>`_ `Graylog2/graylog2-server#4393 <https://github.com/Graylog2/graylog2-server/issues/4393>`_
* Fix changing the default index set from the UI. `Graylog2/graylog2-server#4377 <https://github.com/Graylog2/graylog2-server/issues/4377>`_
* Add global traffic counter to system overview page. `Graylog2/graylog2-server#4357 <https://github.com/Graylog2/graylog2-server/issues/4357>`_
* Remove anonymous usage-stats plugin. `Graylog2/graylog2-server#4349 <https://github.com/Graylog2/graylog2-server/issues/4349>`_

**AWS Plugin**

* Add "logGroup" and "logStream" attributes to flow log and raw log codecs. `Graylog2/graylog-plugin-aws#55 <https://github.com/Graylog2/graylog-plugin-aws/issues/55>`_ `Graylog2/graylog-plugin-aws#54 <https://github.com/Graylog2/graylog-plugin-aws/issues/54>`_

**CEF Plugin**

* Upgrade to CEF parser 0.0.1.10. `Graylog2/graylog-plugin-cef#23 <https://github.com/Graylog2/graylog-plugin-cef/issues/23>`_ `Graylog2/graylog-plugin-cef#24 <https://github.com/Graylog2/graylog-plugin-cef/issues/24>`_

**Threatintel Plugin**

* Fix lookup table used in ``tor_lookup()`` function. `Graylog2/graylog-plugin-threatintel#71 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/71>`_
* Fix lookup table used in ``spamhaus_lookup_ip()`` function. `Graylog2/graylog-plugin-threatintel#73 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/73>`_


Graylog 2.4.0-beta.2
====================

Released: 2017-11-07

https://www.graylog.org/blog/104-announcing-graylog-v2-4-0-beta-2

**Core**

* Improve UI elements for field analyzers. `Graylog2/graylog2-server#4280 <https://github.com/Graylog2/graylog2-server/issues/4280>`_ `Graylog2/graylog2-server#4230 <https://github.com/Graylog2/graylog2-server/issues/4230>`_
* Add upgrade notes for new plugins. `Graylog2/graylog2-server#4187 <https://github.com/Graylog2/graylog2-server/issues/4187>`_
* Fix query button in QuickValues widget. `Graylog2/graylog2-server#4216 <https://github.com/Graylog2/graylog2-server/issues/4216>`_ `Graylog2/graylog2-server#4278 <https://github.com/Graylog2/graylog2-server/issues/4278>`_
* Improve QuickValues histogram data. `Graylog2/graylog2-server#4312 <https://github.com/Graylog2/graylog2-server/issues/4312>`_ `Graylog2/graylog2-server#4309 <https://github.com/Graylog2/graylog2-server/issues/4309>`_
* Add loading indicator when reloading field chart data. `Graylog2/graylog2-server#4319 <https://github.com/Graylog2/graylog2-server/issues/4319>`_
* Add feedback on create widget modal. `Graylog2/graylog2-server#4320 <https://github.com/Graylog2/graylog2-server/issues/4320>`_ `Graylog2/graylog2-server#4318 <https://github.com/Graylog2/graylog2-server/issues/4318>`_
* Improve robustness of QuickValues widget with stacked fields. `Graylog2/graylog2-server#4322 <https://github.com/Graylog2/graylog2-server/issues/4322>`_ `Graylog2/graylog2-server#4289 <https://github.com/Graylog2/graylog2-server/issues/4289>`_ `Graylog2/graylog2-server#4287 <https://github.com/Graylog2/graylog2-server/issues/4287>`_ `Graylog2/graylog2-server#4082 <https://github.com/Graylog2/graylog2-server/issues/4082>`_


Graylog 2.4.0-beta.1
====================

Released: 2017-10-20

https://www.graylog.org/blog/103-announcing-graylog-v2-4-0-beta-1

**Core**

* Ship NetFlow plugin by default. `Graylog2/graylog2-server#4086 <https://github.com/Graylog2/graylog2-server/issues/4086>`_
* Ship AWS plugin by default. `Graylog2/graylog2-server#4085 <https://github.com/Graylog2/graylog2-server/issues/4085>`_
* Ship Threat Intelligence plugin by default. `Graylog2/graylog2-server#4084 <https://github.com/Graylog2/graylog2-server/issues/4084>`_
* Ship CEF plugin by default. `Graylog2/graylog2-server#4161 <https://github.com/Graylog2/graylog2-server/issues/4161>`_
* Fix race condition in user session removal. `Graylog2/graylog2-server#4041 <https://github.com/Graylog2/graylog2-server/issues/4041>`_ `Graylog2/graylog2-server#3634 <https://github.com/Graylog2/graylog2-server/issues/3634>`_ `Graylog2/graylog2-server#3948 <https://github.com/Graylog2/graylog2-server/issues/3948>`_ `Graylog2/graylog2-server#3973 <https://github.com/Graylog2/graylog2-server/issues/3973>`_
* Update web interface dependencies and fix deprecations. `Graylog2/graylog2-server#4057 <https://github.com/Graylog2/graylog2-server/issues/4057>`_ `Graylog2/graylog2-server#4059 <https://github.com/Graylog2/graylog2-server/issues/4059>`_ `Graylog2/graylog2-server#4037 <https://github.com/Graylog2/graylog2-server/issues/4037>`_ `Graylog2/graylog2-server#4192 <https://github.com/Graylog2/graylog2-server/issues/4192>`_ `Graylog2/graylog2-server#4189 <https://github.com/Graylog2/graylog2-server/issues/4189>`_
* Improve Elasticsearch query performance. `Graylog2/graylog2-server#4056 <https://github.com/Graylog2/graylog2-server/issues/4056>`_ `Graylog2/graylog2-server#4051 <https://github.com/Graylog2/graylog2-server/issues/4051>`_
* Improve web UI performance by using React production mode. `Graylog2/graylog2-server#4048 <https://github.com/Graylog2/graylog2-server/issues/4048>`_
* Add possibility for server plugins to add database migrations. `Graylog2/graylog2-server#4095 <https://github.com/Graylog2/graylog2-server/issues/4095>`_
* Add support for custom HTTP headers in HTTPJSONPath lookup table adapter. `Graylog2/graylog2-server#4094 <https://github.com/Graylog2/graylog2-server/issues/4094>`_
* Fix HTTP header size settings. `Graylog2/graylog2-server#4128 <https://github.com/Graylog2/graylog2-server/issues/4128>`_ `Graylog2/graylog2-server#4118 <https://github.com/Graylog2/graylog2-server/issues/4118>`_
* Add ``/system/indices/index_sets/{id}/stats`` REST API endpoint to fetch stats for a single index set. `Graylog2/graylog2-server#4129 <https://github.com/Graylog2/graylog2-server/issues/4129>`_ `Graylog2/graylog2-server#4088 <https://github.com/Graylog2/graylog2-server/issues/4088>`_
* Add DSV over HTTP data adapter for lookup tables. `Graylog2/graylog2-server#4096 <https://github.com/Graylog2/graylog2-server/issues/4096>`_
* Improve and update Elasticsearch testing infrastructure. `Graylog2/graylog2-server#4125 <https://github.com/Graylog2/graylog2-server/issues/4125>`_ `Graylog2/graylog2-server#4165 <https://github.com/Graylog2/graylog2-server/issues/4165>`_
* Improve dashboard widget layout to show long widget titles. `Graylog2/graylog2-server#4072 <https://github.com/Graylog2/graylog2-server/issues/4072>`_ `@billmurrin <https://github.com/billmurrin>`_
* Fix problem in GELF output by removing special handling of the ``facility``. `Graylog2/graylog2-server#4141 <https://github.com/Graylog2/graylog2-server/issues/4141>`_ `Graylog2/graylog2-server#4140 <https://github.com/Graylog2/graylog2-server/issues/4140>`_
* Expose ``LdapUserAuthenticator#syncLdapUser()`` method to allow usage from plugins. `Graylog2/graylog2-server#4159 <https://github.com/Graylog2/graylog2-server/issues/4159>`_ `@gaspardpetit <https://github.com/gaspardpetit>`_
* Fix problem with getting Elasticsearch stats. `Graylog2/graylog2-server#4127 <https://github.com/Graylog2/graylog2-server/issues/4127>`_ `Graylog2/graylog2-server#4119 <https://github.com/Graylog2/graylog2-server/issues/4119>`_
* Fix Elasticsearch document counting with lots of indices. `Graylog2/graylog2-server#4147 <https://github.com/Graylog2/graylog2-server/issues/4147>`_ `Graylog2/graylog2-server#4136 <https://github.com/Graylog2/graylog2-server/issues/4136>`_
* Fix link placement in multi select UI elements. `Graylog2/graylog2-server#3911 <https://github.com/Graylog2/graylog2-server/issues/3911>`_
* Fix HTTP problems when searching in lots of indices. `Graylog2/graylog2-server#4149 <https://github.com/Graylog2/graylog2-server/issues/4149>`_ `Graylog2/graylog2-server#4054 <https://github.com/Graylog2/graylog2-server/issues/4054>`_ `Graylog2/graylog2-server#4168 <https://github.com/Graylog2/graylog2-server/issues/4168>`_
* Fix config issues with stacked charts. `Graylog2/graylog2-server#4151 <https://github.com/Graylog2/graylog2-server/issues/4151>`_ `Graylog2/graylog2-server#4150 <https://github.com/Graylog2/graylog2-server/issues/4150>`_
* Improve eslint rules for UI development. `Graylog2/graylog2-server#4173 <https://github.com/Graylog2/graylog2-server/issues/4173>`_
* Update serveral server dependencies. `Graylog2/graylog2-server#4134 <https://github.com/Graylog2/graylog2-server/issues/4134>`_
* Add config option to disable analysis features (such a QuickValues) for certain message fields. `Graylog2/graylog2-server#4175 <https://github.com/Graylog2/graylog2-server/issues/4175>`_ `Graylog2/graylog2-server#3957 <https://github.com/Graylog2/graylog2-server/issues/3957>`_
* Improve message separator handling for TCP based inputs. `Graylog2/graylog2-server#4106 <https://github.com/Graylog2/graylog2-server/issues/4106>`_ `Graylog2/graylog2-server#4105 <https://github.com/Graylog2/graylog2-server/issues/4105>`_
* Improve CSV lookup table adapter to use the same field for key and value. `Graylog2/graylog2-server#4181 <https://github.com/Graylog2/graylog2-server/issues/4181>`_ `Graylog2/graylog2-server#4177 <https://github.com/Graylog2/graylog2-server/issues/4177>`_
* Add possibility to create charts for non-numeric fields to show cardinality and total counts. `Graylog2/graylog2-server#4182 <https://github.com/Graylog2/graylog2-server/issues/4182>`_ `Graylog2/graylog2-server#4083 <https://github.com/Graylog2/graylog2-server/issues/4083>`_
* Improve widget and grid positioning and styling. `Graylog2/graylog2-server#4160 <https://github.com/Graylog2/graylog2-server/issues/4160>`_ `Graylog2/graylog2-server#4209 <https://github.com/Graylog2/graylog2-server/issues/4209>`_
* Improve UI testing environment. `Graylog2/graylog2-server#4162 <https://github.com/Graylog2/graylog2-server/issues/4162>`_
* Improve error logging on indexing failures. `Graylog2/graylog2-server#4195 <https://github.com/Graylog2/graylog2-server/issues/4195>`_ `Graylog2/graylog2-server#4166 <https://github.com/Graylog2/graylog2-server/issues/4166>`_
* Improve styling for highlighting checkbox in the search sidebar. `Graylog2/graylog2-server#4201 <https://github.com/Graylog2/graylog2-server/issues/4201>`_
* Fix problem with lookup table content pack import. `Graylog2/graylog2-server#4197 <https://github.com/Graylog2/graylog2-server/issues/4197>`_ `Graylog2/graylog-plugin-threatintel#57 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/57>`_
* Add configuration options to QuickValue widget. `Graylog2/graylog2-server#4205 <https://github.com/Graylog2/graylog2-server/issues/4205>`_ `Graylog2/graylog2-server#4082 <https://github.com/Graylog2/graylog2-server/issues/4082>`_ `Graylog2/graylog2-server#4259 <https://github.com/Graylog2/graylog2-server/issues/4259>`_ `Graylog2/graylog2-server#4258 <https://github.com/Graylog2/graylog2-server/issues/4258>`_
* Improve styling and positioning for search page widget buttons. `Graylog2/graylog2-server#4219 <https://github.com/Graylog2/graylog2-server/issues/4219>`_
* Improve permission handling to allow regular users to create dashboards. `Graylog2/graylog2-server#4155 <https://github.com/Graylog2/graylog2-server/issues/4155>`_
* Add stats summary for all index sets to the "System/Indices" page. `Graylog2/graylog2-server#4211 <https://github.com/Graylog2/graylog2-server/issues/4211>`_ `Graylog2/graylog2-server#4204 <https://github.com/Graylog2/graylog2-server/issues/4204>`_
* Improve table layout in lookup table UI for entries with long descriptions. `Graylog2/graylog2-server#4239 <https://github.com/Graylog2/graylog2-server/issues/4239>`_ `Graylog2/graylog2-server#4172 <https://github.com/Graylog2/graylog2-server/issues/4172>`_
* Fix permission check which was hiding a menu item in the UI. `Graylog2/graylog2-server#4237 <https://github.com/Graylog2/graylog2-server/issues/4237>`_ `Graylog2/graylog2-server#4234 <https://github.com/Graylog2/graylog2-server/issues/4234>`_
* Fix error with message histogram selection. `Graylog2/graylog2-server#4243 <https://github.com/Graylog2/graylog2-server/issues/4243>`_ `Graylog2/graylog2-server#4214 <https://github.com/Graylog2/graylog2-server/issues/4214>`_
* Add histogram option to QuickValue widget to show values over time. `Graylog2/graylog2-server#4244 <https://github.com/Graylog2/graylog2-server/issues/4244>`_ `Graylog2/graylog2-server#4082 <https://github.com/Graylog2/graylog2-server/issues/4082>`_
* Fix permission handling for editing/deleting roles. `Graylog2/graylog2-server#4265 <https://github.com/Graylog2/graylog2-server/issues/4265>`_
* Fix some smaller lookup table issues. `Graylog2/graylog2-server#4266 <https://github.com/Graylog2/graylog2-server/issues/4266>`_

**Map Widget plugin**

* Improve rendering and styling for map widget. `Graylog2/graylog-plugin-map-widget#53 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/53>`_ `Graylog2/graylog-plugin-map-widget#54 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/54>`_
* Improve styling and positioning for search page widget buttons. `Graylog2/graylog-plugin-map-widget#56 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/56>`_

**Pipeline Processor plugin**

* Add various Base encoding functions. (e.g. Base16, Base32, Base64) `Graylog2/graylog-plugin-pipeline-processor#190 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/190>`_
* Fix sorting of pipeline rules. `Graylog2/graylog-plugin-pipeline-processor#208 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/208>`_
* Fix ``parse_json()`` function on invalid input. `Graylog2/graylog-plugin-pipeline-processor#210 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/210>`_ `Graylog2/graylog-plugin-pipeline-processor#209 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/209>`_
* Fix NullPointerException when parsing invalid rules. `Graylog2/graylog-plugin-pipeline-processor#212 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/212>`_ `Graylog2/graylog-plugin-pipeline-processor#211 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/211>`_
* Improve documentation for lookup table function. `Graylog2/graylog-plugin-pipeline-processor#217 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/217>`_ `@supahgreg <https://github.com/supahgreg>`_
* Fix numeric conversions with ``to_double()`` and ``to_long()``. `Graylog2/graylog-plugin-pipeline-processor#219 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/219>`_
* Improve rule function documentation in editor by sorting functions alphabetically by name. `Graylog2/graylog-plugin-pipeline-processor#222 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/222>`_
* Add ``remove_from_default`` option to ``route_to_stream()`` function. `Graylog2/graylog-plugin-pipeline-processor#220 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/220>`_
* Add ``remove_from_stream()`` function. `Graylog2/graylog-plugin-pipeline-processor#220 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/220>`_

**Collector plugin**

* Add ``exclude_files`` configuration option for filebeat collectors. `Graylog2/graylog-plugin-collector#63 <https://github.com/Graylog2/graylog-plugin-collector/issues/63>`_ `@silenceper <https://github.com/silenceper>`_

**AWS plugin**

* Fix problem with parsing SNS notification messages. `Graylog2/graylog-plugin-aws#47 <https://github.com/Graylog2/graylog-plugin-aws/issues/47>`_ `Graylog2/graylog-plugin-aws#44 <https://github.com/Graylog2/graylog-plugin-aws/issues/44>`_
* Add support for overriding the ``source`` field for all input types. `Graylog2/graylog-plugin-aws#46 <https://github.com/Graylog2/graylog-plugin-aws/issues/46>`_
* Add support for cross account role based authentication. `Graylog2/graylog-plugin-aws#49 <https://github.com/Graylog2/graylog-plugin-aws/issues/49>`_ `Graylog2/graylog-plugin-aws#48 <https://github.com/Graylog2/graylog-plugin-aws/issues/48>`_ `@radykal-com <https://github.com/radykal-com>`_

**CEF plugin**

* Improve CEF parser and add proper testing infrastructure.
* Fix problems with Kafka and AMQP inputs.

**NetFlow plugin**

* Improved NetFlow v9 support. `Graylog2/graylog-plugin-netflow#21 <https://github.com/Graylog2/graylog-plugin-netflow/issues/21>`_

**Threat Intelligence plugin**

* Convert plugin to use the lookup table system. `Graylog2/graylog-plugin-threatintel#48 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/48>`_
* Fix problem with absent OTX API key in plugin configuration. `Graylog2/graylog-plugin-threatintel#54 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/54>`_ `Graylog2/graylog-plugin-threatintel#53 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/53>`_
* Improve pipeline function parameter consistency. `Graylog2/graylog-plugin-threatintel#58 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/58>`_
* Improve lookup table based data adapters. `Graylog2/graylog-plugin-threatintel#63 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/63>`_ `Graylog2/graylog-plugin-threatintel#61 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/61>`_ `Graylog2/graylog-plugin-threatintel#59 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/59>`_ `Graylog2/graylog-plugin-threatintel#67 <https://github.com/Graylog2/graylog-plugin-threatintel/issues/67>`_

Graylog 2.3.2
=============

Released: 2017-10-19

https://www.graylog.org/blog/102-announcing-graylog-v2-3-2

**Core**

* Fix permission handling for editing/deleting roles. `Graylog2/graylog2-server#4270 <https://github.com/Graylog2/graylog2-server/issues/4270>`_ `Graylog2/graylog2-server#4254 <https://github.com/Graylog2/graylog2-server/issues/4254>`_
* Fix CSV export when using lots of Elasticsearch index shards. `Graylog2/graylog2-server#4269 <https://github.com/Graylog2/graylog2-server/issues/4269>`_ `Graylog2/graylog2-server#4190 <https://github.com/Graylog2/graylog2-server/issues/4190>`_
* Fix infinite redirect loop when accessing non-permitted resources/entities. `Graylog2/graylog2-server#4139 <https://github.com/Graylog2/graylog2-server/issues/4139>`_ `Graylog2/graylog2-server#4117 <https://github.com/Graylog2/graylog2-server/issues/4117>`_

Graylog 2.3.1
=============

Released: 2017-08-25

https://www.graylog.org/blog/100-announcing-graylog-v2-3-1

**Core**

* Fix NullPointerException for field stats. `Graylog2/graylog2-server#4026 <https://github.com/Graylog2/graylog2-server/issues/4026>`_ `Graylog2/graylog2-server#4045 <https://github.com/Graylog2/graylog2-server/issues/4045>`_ `Graylog2/graylog2-server#4046 <https://github.com/Graylog2/graylog2-server/issues/4046>`_
* Make GELF parser less strict. `Graylog2/graylog2-server#4055 <https://github.com/Graylog2/graylog2-server/issues/4055>`_
* Fix search requests with selected fields by using source filtering. `Graylog2/graylog2-server#4069 <https://github.com/Graylog2/graylog2-server/issues/4069>`_ `Graylog2/graylog2-server#4077 <https://github.com/Graylog2/graylog2-server/issues/4077>`_ `Graylog2/graylog2-server#4068 <https://github.com/Graylog2/graylog2-server/issues/4068>`_
* Add missing index for `session_id` in "sessions" MongoDB collection. `Graylog2/graylog2-server#4070 <https://github.com/Graylog2/graylog2-server/issues/4070>`_ `Graylog2/graylog2-server#4076 <https://github.com/Graylog2/graylog2-server/issues/4076>`_
* Fix search errors when lots of indices will be used. `Graylog2/graylog2-server#4062 <https://github.com/Graylog2/graylog2-server/issues/4062>`_ `Graylog2/graylog2-server#4078 <https://github.com/Graylog2/graylog2-server/issues/4078>`_ `Graylog2/graylog2-server#4054 <https://github.com/Graylog2/graylog2-server/issues/4054>`_
* Upgrade to Jest 2.4.7+jackson. `Graylog2/graylog2-server#4107 <https://github.com/Graylog2/graylog2-server/issues/4107>`_
* Fix search term highlighting. `Graylog2/graylog2-server#4108 <https://github.com/Graylog2/graylog2-server/issues/4108>`_ `Graylog2/graylog2-server#4101 <https://github.com/Graylog2/graylog2-server/issues/4101>`_

**Pipeline Processor Plugin**

* Make ``locale`` parameter of ``parse_date()`` optional. `Graylog2/graylog-plugin-pipeline-processor#202 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/202>`_

Graylog 2.3.0
=============

Released: 2017-07-26

https://www.graylog.org/blog/98-announcing-graylog-v2-3-0

**Core**

* Fix remote address field for GELF UDP inputs. `Graylog2/graylog2-server#3982 <https://github.com/Graylog2/graylog2-server/issues/3982>`_ `Graylog2/graylog2-server#3988 <https://github.com/Graylog2/graylog2-server/issues/3988>`_ `Graylog2/graylog2-server#3980 <https://github.com/Graylog2/graylog2-server/issues/3980>`_
* Improve error messages for rotation strategies. `Graylog2/graylog2-server#3995 <https://github.com/Graylog2/graylog2-server/issues/3995>`_ `Graylog2/graylog2-server#3990 <https://github.com/Graylog2/graylog2-server/issues/3990>`_
* Fix legend for stacked charts. `Graylog2/graylog2-server#4010 <https://github.com/Graylog2/graylog2-server/issues/4010>`_ `Graylog2/graylog2-server#3996 <https://github.com/Graylog2/graylog2-server/issues/3996>`_
* Fix size based index rotation strategy. `Graylog2/graylog2-server#4011 <https://github.com/Graylog2/graylog2-server/issues/4011>`_ `Graylog2/graylog2-server#4008 <https://github.com/Graylog2/graylog2-server/issues/4008>`_ `Graylog2/graylog2-server#3997 <https://github.com/Graylog2/graylog2-server/issues/3997>`_
* Implement retry handling for failed Elasticsearch requests. `Graylog2/graylog2-server#4012 <https://github.com/Graylog2/graylog2-server/issues/4012>`_ `Graylog2/graylog2-server#3993 <https://github.com/Graylog2/graylog2-server/issues/3993>`_
* Fix NullPointerException in ExceptionUtils. `Graylog2/graylog2-server#4014 <https://github.com/Graylog2/graylog2-server/issues/4014>`_ `Graylog2/graylog2-server#4003 <https://github.com/Graylog2/graylog2-server/issues/4003>`_
* Avoid noisy stack traces when Elasticsearch is not available. `Graylog2/graylog2-server#3934 <https://github.com/Graylog2/graylog2-server/issues/3934>`_ `Graylog2/graylog2-server#3861 <https://github.com/Graylog2/graylog2-server/issues/3861>`_
* Do not run SetIndexReadOnlyAndCalculateRangeJob if index is closed. `Graylog2/graylog2-server#3931 <https://github.com/Graylog2/graylog2-server/issues/3931>`_ `Graylog2/graylog2-server#3909 <https://github.com/Graylog2/graylog2-server/issues/3909>`_
* Fix issues when updating users and user roles. `Graylog2/graylog2-server#3942 <https://github.com/Graylog2/graylog2-server/issues/3942>`_ `Graylog2/graylog2-server#3918 <https://github.com/Graylog2/graylog2-server/issues/3918>`_
* Improved IPv6 support. `Graylog2/graylog2-server#3926 <https://github.com/Graylog2/graylog2-server/issues/3926>`_ `Graylog2/graylog2-server#3870 <https://github.com/Graylog2/graylog2-server/issues/3870>`_
* Fix login code to unbreak SSO plugin. `Graylog2/graylog2-server#3973 <https://github.com/Graylog2/graylog2-server/issues/3973>`_ `Graylog2/graylog2-server#3948 <https://github.com/Graylog2/graylog2-server/issues/3948>`_
* Allow case-insensitive lookups for CSV lookup data adapter. `Graylog2/graylog2-server#3971 <https://github.com/Graylog2/graylog2-server/issues/3971>`_ `Graylog2/graylog2-server#3961 <https://github.com/Graylog2/graylog2-server/issues/3961>`_
* Allow manual lookup table cache purge via UI and API. `Graylog2/graylog2-server#3967 <https://github.com/Graylog2/graylog2-server/issues/3967>`_ `Graylog2/graylog2-server#3962 <https://github.com/Graylog2/graylog2-server/issues/3962>`_
* Mark Message class as not thread-safe. `Graylog2/graylog2-server#3978 <https://github.com/Graylog2/graylog2-server/issues/3978>`_ `Graylog2/graylog2-server#3876 <https://github.com/Graylog2/graylog2-server/issues/3876>`_
* Fail fast and loud for invalid GELF messages. `Graylog2/graylog2-server#3972 <https://github.com/Graylog2/graylog2-server/issues/3972>`_ `Graylog2/graylog2-server#3970 <https://github.com/Graylog2/graylog2-server/issues/3970>`_
* Add support for automatic Elasticsearch node discovery. `Graylog2/graylog2-server#3805 <https://github.com/Graylog2/graylog2-server/issues/3805>`_
* Fix DateHistogram-related functionality in Searches class. `Graylog2/graylog2-server#3806 <https://github.com/Graylog2/graylog2-server/issues/3806>`_
* Hide update spinner with auto-update interval <=5s. `Graylog2/graylog2-server#3738 <https://github.com/Graylog2/graylog2-server/issues/3738>`_ `Graylog2/graylog2-server#3723 <https://github.com/Graylog2/graylog2-server/issues/3723>`_ `@billmurrin <https://github.com/billmurrin>`_
* Small spelling/documentation fixes. `Graylog2/graylog2-server#3817 <https://github.com/Graylog2/graylog2-server/issues/3817>`_
* Fix pagination and offset/total hits in Searches. `Graylog2/graylog2-server#3821 <https://github.com/Graylog2/graylog2-server/issues/3821>`_ `Graylog2/graylog2-server#3813 <https://github.com/Graylog2/graylog2-server/issues/3813>`_
* Add sort order to terms API call. `Graylog2/graylog2-server#3829 <https://github.com/Graylog2/graylog2-server/issues/3829>`_
* Don't start stopped inputs after updating them. `Graylog2/graylog2-server#3824 <https://github.com/Graylog2/graylog2-server/issues/3824>`_ `Graylog2/graylog2-server#3479 <https://github.com/Graylog2/graylog2-server/issues/3479>`_
* Allow specifying locale for Date converter. `Graylog2/graylog2-server#3820 <https://github.com/Graylog2/graylog2-server/issues/3820>`_
* Hide "Delete from stream" button if stream is undefined. `Graylog2/graylog2-server#3822 <https://github.com/Graylog2/graylog2-server/issues/3822>`_
* Don't reload errorstates on  pages that don't need them. `Graylog2/graylog2-server#3839 <https://github.com/Graylog2/graylog2-server/issues/3839>`_ `Graylog2/graylog2-server#3834 <https://github.com/Graylog2/graylog2-server/issues/3834>`_
* Emit StreamsChangedEvent and StreamDeletedEvent in BundleImporter. `Graylog2/graylog2-server#3848 <https://github.com/Graylog2/graylog2-server/issues/3848>`_ `Graylog2/graylog2-server#3842 <https://github.com/Graylog2/graylog2-server/issues/3842>`_
* Add Lookup Table search result decorator. `Graylog2/graylog2-server#3852 <https://github.com/Graylog2/graylog2-server/issues/3852>`_ `Graylog2/graylog2-server#3844 <https://github.com/Graylog2/graylog2-server/issues/3844>`_
* Check Elasticsearch version when creating index template. `Graylog2/graylog2-server#3862 <https://github.com/Graylog2/graylog2-server/issues/3862>`_
* Add admin user to list of receivers in EmailAlarmCallback. `Graylog2/graylog2-server#3864 <https://github.com/Graylog2/graylog2-server/issues/3864>`_ `Graylog2/graylog2-server#3859 <https://github.com/Graylog2/graylog2-server/issues/3859>`_
* Fix parameters for count query in ``Searches#count()``. `Graylog2/graylog2-server#3865 <https://github.com/Graylog2/graylog2-server/issues/3865>`_ `Graylog2/graylog2-server#3841 <https://github.com/Graylog2/graylog2-server/issues/3841>`_
* Add search system for objects in MongoDB `Graylog2/graylog2-server#3877 <https://github.com/Graylog2/graylog2-server/issues/3877>`_
* Make Kafka config setting ``auto.offset.reset`` configurable for input. `Graylog2/graylog2-server#3743 <https://github.com/Graylog2/graylog2-server/issues/3743>`_ `Graylog2/graylog2-server#3894 <https://github.com/Graylog2/graylog2-server/issues/3894>`_ `@r4um <https://github.com/r4um>`_
* Use preemptive authentication for Elasticsearch if credentials are given. `Graylog2/graylog2-server#3895 <https://github.com/Graylog2/graylog2-server/issues/3895>`_ `Graylog2/graylog2-server#3907 <https://github.com/Graylog2/graylog2-server/issues/3907>`_
* Add lookup adapter and cache config validation. `Graylog2/graylog2-server#3836 <https://github.com/Graylog2/graylog2-server/issues/3836>`_
* Unbreak elasticsearch duration config settings. `Graylog2/graylog2-server#3899 <https://github.com/Graylog2/graylog2-server/issues/3899>`_
* Fix lookup table UI state problem. `Graylog2/graylog2-server#3898 <https://github.com/Graylog2/graylog2-server/issues/3898>`_
* Enable search for lookup tables, data adapters and caches. `Graylog2/graylog2-server#3878 <https://github.com/Graylog2/graylog2-server/issues/3878>`_
* Make Elasticsearch version injectable. `Graylog2/graylog2-server#3896 <https://github.com/Graylog2/graylog2-server/issues/3896>`_
* Refactor lifecycle for lookup adapters and caches. `Graylog2/graylog2-server#3873 <https://github.com/Graylog2/graylog2-server/issues/3873>`_
* Introduce setting for enabling ES request compression. `Graylog2/graylog2-server#3901 <https://github.com/Graylog2/graylog2-server/issues/3901>`_
* Add content pack import/export for lookup tables, caches and adapters. `Graylog2/graylog2-server#3892 <https://github.com/Graylog2/graylog2-server/issues/3892>`_
* Upgrade to Jackson 2.8.9. `Graylog2/graylog2-server#3908 <https://github.com/Graylog2/graylog2-server/issues/3908>`_
* Fix and centralize lookup adapter/cache error handling. `Graylog2/graylog2-server#3905 <https://github.com/Graylog2/graylog2-server/issues/3905>`_
* Switch RoleResponse to java.util.Optional to fix serialization. `Graylog2/graylog2-server#3915 <https://github.com/Graylog2/graylog2-server/issues/3915>`_
* Add lookup table/cache/adapter permissions. `Graylog2/graylog2-server#3914 <https://github.com/Graylog2/graylog2-server/issues/3914>`_
* Collect and show metrics for lookup caches and adapters. `Graylog2/graylog2-server#3917 <https://github.com/Graylog2/graylog2-server/issues/3917>`_
* Remove obsolete "disableExpensiveUpdates" user preference. `Graylog2/graylog2-server#3922 <https://github.com/Graylog2/graylog2-server/issues/3922>`_
* Migrate to Jackson-based release of Jest 2.4.5. `Graylog2/graylog2-server#3925 <https://github.com/Graylog2/graylog2-server/issues/3925>`_
* Use aliases for reopened indices. `Graylog2/graylog2-server#3897 <https://github.com/Graylog2/graylog2-server/issues/3897>`_
* Add default values for lookup tables. `Graylog2/graylog2-server#3921 <https://github.com/Graylog2/graylog2-server/issues/3921>`_
* Add support for updating extractors in InputService. `Graylog2/graylog2-server#3910 <https://github.com/Graylog2/graylog2-server/issues/3910>`_
* Fix index set overview with closed indices. `Graylog2/graylog2-server#3930 <https://github.com/Graylog2/graylog2-server/issues/3930>`_
* Don't check ES cluster health when flushing messages. `Graylog2/graylog2-server#3927 <https://github.com/Graylog2/graylog2-server/issues/3927>`_
* Retrying bulk indexing in case of all IOExceptions. `Graylog2/graylog2-server#3929 <https://github.com/Graylog2/graylog2-server/issues/3929>`_ `Graylog2/graylog2-server#3941 <https://github.com/Graylog2/graylog2-server/issues/3941>`_
* Add support for automatic Elasticsearch node discovery. `Graylog2/graylog2-server#3805 <https://github.com/Graylog2/graylog2-server/issues/3805>`_
* Fix DateHistogram-related functionality in Searches class. `Graylog2/graylog2-server#3806 <https://github.com/Graylog2/graylog2-server/issues/3806>`_
* Hide update spinner with auto-update interval <=5s. `Graylog2/graylog2-server#3738 <https://github.com/Graylog2/graylog2-server/issues/3738>`_ `Graylog2/graylog2-server#3723 <https://github.com/Graylog2/graylog2-server/issues/3723>`_ `@billmurrin <https://github.com/billmurrin>`_
* Small spelling/documentation fixes. `Graylog2/graylog2-server#3817 <https://github.com/Graylog2/graylog2-server/issues/3817>`_
* Fix pagination and offset/total hits in Searches. `Graylog2/graylog2-server#3821 <https://github.com/Graylog2/graylog2-server/issues/3821>`_ `Graylog2/graylog2-server#3813 <https://github.com/Graylog2/graylog2-server/issues/3813>`_
* Add timing metrics to GelfOutput. `Graylog2/graylog2-server#3810 <https://github.com/Graylog2/graylog2-server/issues/3810>`_ `Graylog2/graylog2-server#3716 <https://github.com/Graylog2/graylog2-server/issues/3716>`_
* Add sort order to terms API call. `Graylog2/graylog2-server#3829 <https://github.com/Graylog2/graylog2-server/issues/3829>`_
* Don't start stopped inputs after updating them. `Graylog2/graylog2-server#3824 <https://github.com/Graylog2/graylog2-server/issues/3824>`_ `Graylog2/graylog2-server#3479 <https://github.com/Graylog2/graylog2-server/issues/3479>`_
* Allow specifying locale for Date converter. `Graylog2/graylog2-server#3820 <https://github.com/Graylog2/graylog2-server/issues/3820>`_
* Hide "Delete from stream" button if stream is undefined. `Graylog2/graylog2-server#3822 <https://github.com/Graylog2/graylog2-server/issues/3822>`_
* Don't reload errorstates on  pages that don't need them. `Graylog2/graylog2-server#3839 <https://github.com/Graylog2/graylog2-server/issues/3839>`_ `Graylog2/graylog2-server#3834 <https://github.com/Graylog2/graylog2-server/issues/3834>`_
* Emit StreamsChangedEvent and StreamDeletedEvent in BundleImporter. `Graylog2/graylog2-server#3848 <https://github.com/Graylog2/graylog2-server/issues/3848>`_ `Graylog2/graylog2-server#3842 <https://github.com/Graylog2/graylog2-server/issues/3842>`_
* Add Lookup Table search result decorator. `Graylog2/graylog2-server#3852 <https://github.com/Graylog2/graylog2-server/issues/3852>`_ `Graylog2/graylog2-server#3844 <https://github.com/Graylog2/graylog2-server/issues/3844>`_
* Check Elasticsearch version when creating index template. `Graylog2/graylog2-server#3862 <https://github.com/Graylog2/graylog2-server/issues/3862>`_
* Add admin user to list of receivers in EmailAlarmCallback. `Graylog2/graylog2-server#3864 <https://github.com/Graylog2/graylog2-server/issues/3864>`_ `Graylog2/graylog2-server#3859 <https://github.com/Graylog2/graylog2-server/issues/3859>`_
* Fix parameters for count query in ``Searches#count()``. `Graylog2/graylog2-server#3865 <https://github.com/Graylog2/graylog2-server/issues/3865>`_ `Graylog2/graylog2-server#3841 <https://github.com/Graylog2/graylog2-server/issues/3841>`_
* Allow version '0' for structured syslog messages. `Graylog2/graylog2-server#3503 <https://github.com/Graylog2/graylog2-server/issues/3503>`_
* Ignore Content-Type in ``HttpTransport``. `Graylog2/graylog2-server#3508 <https://github.com/Graylog2/graylog2-server/issues/3508>`_ `Graylog2/graylog2-server#3477 <https://github.com/Graylog2/graylog2-server/issues/3477>`_
* Ensure that ``index_prefix`` is lower case. `Graylog2/graylog2-server#3509 <https://github.com/Graylog2/graylog2-server/issues/3509>`_ `Graylog2/graylog2-server#3476 <https://github.com/Graylog2/graylog2-server/issues/3476>`_
* Make map in ``MessageInput#asMap()`` mutable. `Graylog2/graylog2-server#3521 <https://github.com/Graylog2/graylog2-server/issues/3521>`_ `Graylog2/graylog2-server#3515 <https://github.com/Graylog2/graylog2-server/issues/3515>`_
* Fix pagination for alert conditions. `Graylog2/graylog2-server#3529 <https://github.com/Graylog2/graylog2-server/issues/3529>`_ `Graylog2/graylog2-server#3528 <https://github.com/Graylog2/graylog2-server/issues/3528>`_
* Wait until alert notification types are loaded. `Graylog2/graylog2-server#3537 <https://github.com/Graylog2/graylog2-server/issues/3537>`_ `Graylog2/graylog2-server#3534 <https://github.com/Graylog2/graylog2-server/issues/3534>`_
* Upgrade development environment to Webpack v2. `Graylog2/graylog2-server#3460 <https://github.com/Graylog2/graylog2-server/issues/3460>`_
* Add an option to repeat alert notifications again. `Graylog2/graylog2-server#3536 <https://github.com/Graylog2/graylog2-server/issues/3536>`_ `Graylog2/graylog2-server#3511 <https://github.com/Graylog2/graylog2-server/issues/3511>`_
* Fix accidentally changed exports of ``UsersStore`` `Graylog2/graylog2-server#3560 <https://github.com/Graylog2/graylog2-server/issues/3560>`_ `Graylog2/graylog2-server#3556 <https://github.com/Graylog2/graylog2-server/issues/3556>`_
* Properly escape username/roles in web interface. `Graylog2/graylog2-server#3570 <https://github.com/Graylog2/graylog2-server/issues/3570>`_ `Graylog2/graylog2-server#3569 <https://github.com/Graylog2/graylog2-server/issues/3569>`_
* Improved dashboard grid system. `Graylog2/graylog2-server#3575 <https://github.com/Graylog2/graylog2-server/issues/3575>`_
* Add support for sorting by count to ``Search#terms()``. `Graylog2/graylog2-server#3540 <https://github.com/Graylog2/graylog2-server/issues/3540>`_ (`@billmurrin <https://github.com/billmurrin>`_)
* Fix for copy query button. `Graylog2/graylog2-server#3548 <https://github.com/Graylog2/graylog2-server/issues/3548>`_ (`@billmurrin <https://github.com/billmurrin>`_)
* Fix issue with cloning streams. `Graylog2/graylog2-server#3615 <https://github.com/Graylog2/graylog2-server/issues/3615>`_ `Graylog2/graylog2-server#3608 <https://github.com/Graylog2/graylog2-server/issues/3608>`_
* Prevent session extension when polling system messages. `Graylog2/graylog2-server#3632 <https://github.com/Graylog2/graylog2-server/issues/3632>`_ `Graylog2/graylog2-server#3628 <https://github.com/Graylog2/graylog2-server/issues/3628>`_
* Prevent session extension when polling system jobs. `Graylog2/graylog2-server#3625 <https://github.com/Graylog2/graylog2-server/issues/3625>`_ `Graylog2/graylog2-server#3587 <https://github.com/Graylog2/graylog2-server/issues/3587>`_
* Prevent NPE due to race between rotation and retention threads. `Graylog2/graylog2-server#3637 <https://github.com/Graylog2/graylog2-server/issues/3637>`_ `Graylog2/graylog2-server#3494 <https://github.com/Graylog2/graylog2-server/issues/3494>`_
* Fix problem with message decorators and field selection. `Graylog2/graylog2-server#3585 <https://github.com/Graylog2/graylog2-server/issues/3585>`_ `Graylog2/graylog2-server#3584 <https://github.com/Graylog2/graylog2-server/issues/3584>`_
* Fix issue with loading indicator on an empty search result page. `Graylog2/graylog2-server#3652 <https://github.com/Graylog2/graylog2-server/issues/3652>`_ `Graylog2/graylog2-server#3650 <https://github.com/Graylog2/graylog2-server/issues/3650>`_
* Fix navigation in LDAP users UI. `Graylog2/graylog2-server#3651 <https://github.com/Graylog2/graylog2-server/issues/3651>`_ `Graylog2/graylog2-server#3485 <https://github.com/Graylog2/graylog2-server/issues/3485>`_
* Ensure that plugin RPMs will be built for Linux. `Graylog2/graylog2-server#3658 <https://github.com/Graylog2/graylog2-server/issues/3658>`_ `Graylog2/graylog2-server#3657 <https://github.com/Graylog2/graylog2-server/issues/3657>`_
* Fix reloading problem with content packs and GROK patterns. `Graylog2/graylog2-server#3621 <https://github.com/Graylog2/graylog2-server/issues/3621>`_ `Graylog2/graylog2-server#3610 <https://github.com/Graylog2/graylog2-server/issues/3610>`_
* Add support for Cisco and FortiGate Syslog messages. `Graylog2/graylog2-server#3599 <https://github.com/Graylog2/graylog2-server/issues/3599>`_
* Fix permission problem for inputs API. `Graylog2/graylog2-server#3681 <https://github.com/Graylog2/graylog2-server/issues/3681>`_
* Restore removal of role permissions upon roles update. `Graylog2/graylog2-server#3683 <https://github.com/Graylog2/graylog2-server/issues/3683>`_
* Comply with grace condition when repeat alert notifications is enabled. `Graylog2/graylog2-server#3676 <https://github.com/Graylog2/graylog2-server/issues/3676>`_ `Graylog2/graylog2-server#3579 <https://github.com/Graylog2/graylog2-server/issues/3579>`_
* Invalidate dashboards data after logout. `Graylog2/graylog2-server#3700 <https://github.com/Graylog2/graylog2-server/issues/3700>`_ `Graylog2/graylog2-server#3693 <https://github.com/Graylog2/graylog2-server/issues/3693>`_
* Fix OptionalStringValidator and validations for extractors. `Graylog2/graylog2-server#3633 <https://github.com/Graylog2/graylog2-server/issues/3633>`_ `Graylog2/graylog2-server#3630 <https://github.com/Graylog2/graylog2-server/issues/3630>`_
* Better time range for "Show Received Messages" button on inputs page. `Graylog2/graylog2-server#3725 <https://github.com/Graylog2/graylog2-server/issues/3725>`_
* Remove deprecated rotation/retention configuration resources. `Graylog2/graylog2-server#3724 <https://github.com/Graylog2/graylog2-server/issues/3724>`_
* Introduce lookup tables feature. `Graylog2/graylog2-server#3748 <https://github.com/Graylog2/graylog2-server/issues/3748>`_
* Creating dashboard from search page does now select the right ID `Graylog2/graylog2-server#3786 <https://github.com/Graylog2/graylog2-server/issues/3786>`_ `Graylog2/graylog2-server#3785 <https://github.com/Graylog2/graylog2-server/issues/3785>`_
* Fix importing of dashboards from content packs `Graylog2/graylog2-server#3766 <https://github.com/Graylog2/graylog2-server/issues/3766>`_ `Graylog2/graylog2-server#3765 <https://github.com/Graylog2/graylog2-server/issues/3765>`_

**Beats Plugin**

* Spelling fixes. `Graylog2/graylog-plugin-beats#22 <https://github.com/Graylog2/graylog-plugin-beats/issues/22>`_ `@jsoref <https://github.com/jsoref>`_

**Collector Plugin**

* Increase "Show messages" time range.
* Allow collectors list to be filtered by tags. `Graylog2/graylog-plugin-collector#52 <https://github.com/Graylog2/graylog-plugin-collector/issues/52>`_
* UI and UX improvements.  `Graylog2/graylog-plugin-collector#55 <https://github.com/Graylog2/graylog-plugin-collector/issues/55>`_
* Fix configuration setting usage for collector heartbeat interval. `Graylog2/graylog-plugin-collector#58 <https://github.com/Graylog2/graylog-plugin-collector/issues/58>`_
* Prevent unwanted session extension. `Graylog2/graylog-plugin-collector#49 <https://github.com/Graylog2/graylog-plugin-collector/issues/49>`_

**Map Widget Plugin**

* Adjust to lookup cache and adapter changes in server. `Graylog2/graylog-plugin-map-widget#48 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/48>`_ `Graylog2/graylog-plugin-map-widget#50 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/50>`_
* Fix refresh handling in error conditions. `Graylog2/graylog-plugin-map-widget#49 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/49>`_
* Fix HMR as in Graylog/graylog2-server#3591 `Graylog2/graylog-plugin-map-widget#51 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/51>`_
* Update to a new GeoIP2 release.
* Add lookup tables data adapter for the GeoIP2 database. `Graylog2/graylog-plugin-map-widget#40 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/40>`_

**Pipeline Processor Plugin**

* Improve robustness of ``clone_message()`` pipeline function. `Graylog2/graylog-plugin-pipeline-processor#192 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/192>`_ `Graylog2/graylog2-server#3880 <https://github.com/Graylog2/graylog2-server/issues/3880>`_
* Fix pipline condition handling of "match all"/"match either". `Graylog2/graylog-plugin-pipeline-processor#193 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/193>`_ `Graylog2/graylog2-server#3924 <https://github.com/Graylog2/graylog2-server/issues/3924>`_
* Fix serialization/deserialization of pipeline StageSource. `Graylog2/graylog-plugin-pipeline-processor#195 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/195>`_ `Graylog2/graylog-plugin-pipeline-processor#194 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/194>`_
* Improve error handling with invalid expressions. `Graylog2/graylog-plugin-pipeline-processor#196 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/196>`_ `Graylog2/graylog-plugin-pipeline-processor#185 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/185>`_
* Spelling fixes. `Graylog2/graylog-plugin-pipeline-processor#181 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/181>`_ `@jsoref <https://github.com/jsoref>`_
* Add support for custom locale in ``parse_date()`` function. `Graylog2/graylog-plugin-pipeline-processor#184 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/184>`_ `Graylog2/graylog-plugin-pipeline-processor#183 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/183>`_
* Smaller UI and UX changes. `Graylog2/graylog-plugin-pipeline-processor#186 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/186>`_
* New function: debug() `Graylog2/graylog-plugin-pipeline-processor#188 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/188>`_
* Allow snake-case access to bean objects `Graylog2/graylog-plugin-pipeline-processor#189 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/189>`_
* Improve lookup functions. `Graylog2/graylog-plugin-pipeline-processor#191 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/191>`_
* Spelling fixes. `Graylog2/graylog-plugin-pipeline-processor#181 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/181>`_ `@jsoref <https://github.com/jsoref>`_
* Use uppercase timezone in ``TimezoneAwareFunction`` and fix default value. `Graylog2/graylog2-server#169 <https://github.com/Graylog2/graylog2-server/issues/169>`_ `Graylog2/graylog2-server#168 <https://github.com/Graylog2/graylog2-server/issues/168>`_
* Add ``lookup`` and ``lookup_value`` pipeline functions for lookup table support. `Graylog2/graylog2-server#177 <https://github.com/Graylog2/graylog2-server/issues/177>`_

Graylog 2.2.3
=============

Released: 2017-04-04

https://www.graylog.org/blog/92-announcing-graylog-v2-2-3

**Core**

* Prevent unwanted session extension. `Graylog2/graylog2-server#3583 <https://github.com/Graylog2/graylog2-server/issues/3583>`__
* Properly escape username/roles in web interface. `Graylog2/graylog2-server#3588 <https://github.com/Graylog2/graylog2-server/issues/3588>`__
* Allow "-" in the path pattern for the index range rebuild endpoint. `Graylog2/graylog2-server#3600 <https://github.com/Graylog2/graylog2-server/issues/3600>`__
* Copy Query Button Fix. `Graylog2/graylog2-server#3491 <https://github.com/Graylog2/graylog2-server/issues/3491>`__
* Fixing slicing of alert notifications in pagination. `Graylog2/graylog2-server#3619 <https://github.com/Graylog2/graylog2-server/issues/3619>`__
* Fix cloning alert conditions with identical id when cloning stream. `Graylog2/graylog2-server#3616 <https://github.com/Graylog2/graylog2-server/issues/3616>`__
* Use UTC for embedded Date objects as well. `Graylog2/graylog2-server#3626 <https://github.com/Graylog2/graylog2-server/issues/3626>`__
* Prevent session extension for polling system messages. `Graylog2/graylog2-server#3638 <https://github.com/Graylog2/graylog2-server/issues/3638>`__
* Support replacing whitespace in nested keys for JSON extractor. `Graylog2/graylog2-server#3623 <https://github.com/Graylog2/graylog2-server/issues/3623>`__
* Prevent NPE due to race between rotation and retention threads. `Graylog2/graylog2-server#3640 <https://github.com/Graylog2/graylog2-server/issues/3640>`__
* Prevent session extension in SystemJobsStore. `Graylog2/graylog2-server#3625 <https://github.com/Graylog2/graylog2-server/issues/3625>`__
* Render loading indicator on no results page. `Graylog2/graylog2-server#3667 <https://github.com/Graylog2/graylog2-server/issues/3667>`__
* Using consistent collection of non displayable fields to filter against. `Graylog2/graylog2-server#3668 <https://github.com/Graylog2/graylog2-server/issues/3668>`__
* Ensure that plugin RPMs will be built for Linux. `Graylog2/graylog2-server#3659 <https://github.com/Graylog2/graylog2-server/issues/3659>`__
* Fix navigation in LDAP components. `Graylog2/graylog2-server#3670 <https://github.com/Graylog2/graylog2-server/issues/3670>`__
* Publish GrokPatternsChangedEvent when using content packs. `Graylog2/graylog2-server#3621 <https://github.com/Graylog2/graylog2-server/issues/3621>`__
* Add support for Cisco and FortiGate syslog messages. `Graylog2/graylog2-server#3599 <https://github.com/Graylog2/graylog2-server/issues/3599>`__
* Effectively change user permissions when listing inputs. `Graylog2/graylog2-server#3682 <https://github.com/Graylog2/graylog2-server/issues/3682>`__
* Restore removal of role permissions upon roles update. `Graylog2/graylog2-server#3684 <https://github.com/Graylog2/graylog2-server/issues/3684>`__
* Comply with grace condition when repeat alert notifications is enabled `Graylog2/graylog2-server#3676 <https://github.com/Graylog2/graylog2-server/issues/3676>`__

**Pipeline Processor**

* Use uppercase timezone in TimezoneAwareFunction and fix default value. `Graylog2/graylog-plugin-pipeline-processor#169 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/169>`__

Graylog 2.2.2
=============

Released: 2017-03-03

https://www.graylog.org/blog/90-announcing-graylog-v2-2-2

**Core**

* Give an option to repeat alert notifications. `Graylog2/graylog2-server#3511 <https://github.com/Graylog2/graylog2-server/issues/3511>`__
* Wait until notification types are loaded. `Graylog2/graylog2-server#3534 <https://github.com/Graylog2/graylog2-server/issues/3534>`__
* Fixing slicing of alert conditions in pagination. `Graylog2/graylog2-server#3528 <https://github.com/Graylog2/graylog2-server/issues/3528>`__
* Fix command line help of the server jar. `Graylog2/graylog2-server#3527 <https://github.com/Graylog2/graylog2-server/pull/3527>`__

Graylog 2.2.1
=============

Released: 2017-02-20

https://www.graylog.org/blog/89-announcing-graylog-v2-2-1

**Core**

* Allow version '0' for structured syslog messages. `Graylog2/graylog2-server#3502 <https://github.com/Graylog2/graylog2-server/issues/3502>`__
* Ignore ``Content-Type`` in ``HttpTransport``. `Graylog2/graylog2-server#3477 <https://github.com/Graylog2/graylog2-server/issues/3477>`__
* Ensure that ``index_prefix`` is lower case. `Graylog2/graylog2-server#3476 <https://github.com/Graylog2/graylog2-server/issues/3476>`__
* Add missing whitespace in SystemOutputsPage. `Graylog2/graylog2-server#3505 <https://github.com/Graylog2/graylog2-server/issues/3505>`__

Graylog 2.2.0
=============

Released: 2017-02-14

https://www.graylog.org/blog/88-announcing-graylog-v2-2-0

**Core**

* Warn about pipeline stream routing `Graylog2/graylog2-server#3472 <https://github.com/Graylog2/graylog2-server/issues/3472>`__
* Add npm shrinkwrap for 2.2.0 `Graylog2/graylog2-server#3468 <https://github.com/Graylog2/graylog2-server/issues/3468>`__
* Use consistent case in old message count conditions `Graylog2/graylog2-server#3454 <https://github.com/Graylog2/graylog2-server/issues/3454>`__
* Fix stream filter view. `Graylog2/graylog2-server#3390 <https://github.com/Graylog2/graylog2-server/issues/3390>`__
* Use the default index set by default in stream create form. `Graylog2/graylog2-server#3397 <https://github.com/Graylog2/graylog2-server/issues/3397>`__
* Fix broken decorator with duplicate messages. `Graylog2/graylog2-server#3400 <https://github.com/Graylog2/graylog2-server/issues/3400>`__
* Updating index sets store when stream form is opened. `Graylog2/graylog2-server#3410 <https://github.com/Graylog2/graylog2-server/issues/3410>`__
* Only show extractor actions on string fields. `Graylog2/graylog2-server#3404 <https://github.com/Graylog2/graylog2-server/issues/3404>`__
* Use correct format when adding timestamp to search. `Graylog2/graylog2-server#3412 <https://github.com/Graylog2/graylog2-server/issues/3412>`__
* Properly escape strings sent to /messages/{index}/analyze. `Graylog2/graylog2-server#3418 <https://github.com/Graylog2/graylog2-server/issues/3418>`__
* Retain input and stream IDs in content packs. `Graylog2/graylog2-server#3416 <https://github.com/Graylog2/graylog2-server/issues/3416>`__
* Use "order": -1 in default index template to allow override. `Graylog2/graylog2-server#3422 <https://github.com/Graylog2/graylog2-server/issues/3422>`__
* Improve base-line memory usage. `Graylog2/graylog2-server#3425 <https://github.com/Graylog2/graylog2-server/issues/3425>`__
* Use condition and notification placeholders. `Graylog2/graylog2-server#3432 <https://github.com/Graylog2/graylog2-server/issues/3432>`__
* Get field stats for indices only, which contain field. `Graylog2/graylog2-server#3424 <https://github.com/Graylog2/graylog2-server/issues/3424>`__
* Redirect to overview after editing index set configuration. `Graylog2/graylog2-server#3438 <https://github.com/Graylog2/graylog2-server/issues/3438>`__
* Send "stream" property when updating a decorator. `Graylog2/graylog2-server#3439 <https://github.com/Graylog2/graylog2-server/issues/3439>`__
* Adding simple cache for index sets in MongoIndexSetRegistry. `Graylog2/graylog2-server#3440 <https://github.com/Graylog2/graylog2-server/issues/3440>`__
* Restrict search in RecentMessageLoader to 1 hour. `Graylog2/graylog2-server#3367 <https://github.com/Graylog2/graylog2-server/issues/3367>`__
* Remove stray whitespace in MongoIndexSet. `Graylog2/graylog2-server#3371 <https://github.com/Graylog2/graylog2-server/issues/3371>`__
* Add more detail to index range system notification. `Graylog2/graylog2-server#3372 <https://github.com/Graylog2/graylog2-server/issues/3372>`__
* Suppress error notification when loading a potentially missing input. `Graylog2/graylog2-server#3373 <https://github.com/Graylog2/graylog2-server/issues/3373>`__
* Ensure resolved at is non-null on resolvedSecondsAgo. `Graylog2/graylog2-server#3376 <https://github.com/Graylog2/graylog2-server/issues/3376>`__
* Do not allow testing a message against the default stream. `Graylog2/graylog2-server#3377 <https://github.com/Graylog2/graylog2-server/issues/3377>`__
* Propagate shard failure in multi-index search to global search failure. `Graylog2/graylog2-server#3379 <https://github.com/Graylog2/graylog2-server/issues/3379>`__
* Add support for arrays to "contains" stream rule. `Graylog2/graylog2-server#3380 <https://github.com/Graylog2/graylog2-server/issues/3380>`__
* Automatically unsubscribe from DecoratorsStore in SearchPage. `Graylog2/graylog2-server#3363 <https://github.com/Graylog2/graylog2-server/issues/3363>`__
* Keep modified search bar params when opening modal. `Graylog2/graylog2-server#3384 <https://github.com/Graylog2/graylog2-server/issues/3384>`__
* Reset keyword content after changing range type. `Graylog2/graylog2-server#3386 <https://github.com/Graylog2/graylog2-server/issues/3386>`__
* Disable the "set as default" action for the default index set. `Graylog2/graylog2-server#3385 <https://github.com/Graylog2/graylog2-server/issues/3385>`__
* Unregistering component callbacks from Stream(Rules)Store. `Graylog2/graylog2-server#3378 <https://github.com/Graylog2/graylog2-server/issues/3378>`__
* Check for stream existence when displaying replay link. `Graylog2/graylog2-server#3387 <https://github.com/Graylog2/graylog2-server/issues/3387>`__
* Reuse Generator instance in DocumentationResource. `Graylog2/graylog2-server#3293 <https://github.com/Graylog2/graylog2-server/issues/3293>`__
* Fix: Refreshing saved searches store after deleting one. `Graylog2/graylog2-server#3309 <https://github.com/Graylog2/graylog2-server/issues/3309>`__
* Escape curly braces in Swagger resource URIs for challenged browsers. `Graylog2/graylog2-server#3290 <https://github.com/Graylog2/graylog2-server/issues/3290>`__
* Unbreak Firefox by requesting JSON when pinging the API `Graylog2/graylog2-server#3312 <https://github.com/Graylog2/graylog2-server/issues/3312>`__
* Escape search query when using surrounding search. `Graylog2/graylog2-server#3314 <https://github.com/Graylog2/graylog2-server/issues/3314>`__
* Close idle GELF HTTP connections after a timeout. `Graylog2/graylog2-server#3315 <https://github.com/Graylog2/graylog2-server/issues/3315>`__
* Ensure that index ranges are deleted when an index set is removed. `Graylog2/graylog2-server#3310 <https://github.com/Graylog2/graylog2-server/issues/3310>`__
* Ignore reopened indices for count-based retention strategies. `Graylog2/graylog2-server#3321 <https://github.com/Graylog2/graylog2-server/issues/3321>`__
* Ignore deprecated "default" field in IndexSetConfig. `Graylog2/graylog2-server#3329 <https://github.com/Graylog2/graylog2-server/issues/3329>`__
* Use last executed search data on auto-refresh. `Graylog2/graylog2-server#3330 <https://github.com/Graylog2/graylog2-server/issues/3330>`__
* Show stats for each index set on the index sets overview page. `Graylog2/graylog2-server#3322 <https://github.com/Graylog2/graylog2-server/issues/3322>`__
* Not fetching/checking unnecessary streams in AlertScannerThread. `Graylog2/graylog2-server#3336 <https://github.com/Graylog2/graylog2-server/issues/3336>`__
* Add more metrics for extractors. `Graylog2/graylog2-server#3332 <https://github.com/Graylog2/graylog2-server/issues/3332>`__
* Saved search improvements. `Graylog2/graylog2-server#3338 <https://github.com/Graylog2/graylog2-server/issues/3338>`__
* Warn when neither reader nor admin roles are selected for a user. `Graylog2/graylog2-server#3337 <https://github.com/Graylog2/graylog2-server/issues/3337>`__
* Prevent setting default index set readonly. `Graylog2/graylog2-server#3339 <https://github.com/Graylog2/graylog2-server/issues/3339>`__
* Add migration to fix parameter value types for alert conditions. `Graylog2/graylog2-server#3340 <https://github.com/Graylog2/graylog2-server/issues/3340>`__
* Fix unlock dashboard from link. `Graylog2/graylog2-server#3344 <https://github.com/Graylog2/graylog2-server/issues/3344>`__
* Allow re-configuration of shards and replicas in the UI. `Graylog2/graylog2-server#3349 <https://github.com/Graylog2/graylog2-server/issues/3349>`__
* Adapt grace period to latest changes in alerts. `Graylog2/graylog2-server#3346 <https://github.com/Graylog2/graylog2-server/issues/3346>`__
* Go back in history instead to users page when canceling user form. `Graylog2/graylog2-server#3350 <https://github.com/Graylog2/graylog2-server/issues/3350>`__
* Improve wrapping of entity title and description. `Graylog2/graylog2-server#3351 <https://github.com/Graylog2/graylog2-server/issues/3351>`__
* Keep stream filter after editing stream. `Graylog2/graylog2-server#3352 <https://github.com/Graylog2/graylog2-server/issues/3352>`__
* Guard against duplication key error from MongoDB. `Graylog2/graylog2-server#3358 <https://github.com/Graylog2/graylog2-server/issues/3358>`__
* Keep calling convention of SearchPage._refreshData consistent. `Graylog2/graylog2-server#3357 <https://github.com/Graylog2/graylog2-server/issues/3357>`__
* Creating MongoDB indices in services running conditional queries. `Graylog2/graylog2-server#3345 <https://github.com/Graylog2/graylog2-server/issues/3345>`__
* Fix NPE in MongoDbSessionDAO#doDelete(). `Graylog2/graylog2-server#3227 <https://github.com/Graylog2/graylog2-server/issues/3227>`__
* Support syslog messages with ISO-8601 timestamps. `Graylog2/graylog2-server#3228 <https://github.com/Graylog2/graylog2-server/issues/3228>`__
* Use local copies of Droid Sans font in Swagger UI. `Graylog2/graylog2-server#3229 <https://github.com/Graylog2/graylog2-server/issues/3229>`__
* Remove empty row if input description is empty. `Graylog2/graylog2-server#3237 <https://github.com/Graylog2/graylog2-server/issues/3237>`__
* Make "sender" optional in EmailAlarmCallback. `Graylog2/graylog2-server#3224 <https://github.com/Graylog2/graylog2-server/issues/3224>`__
* Fix URL for throbber image. `Graylog2/graylog2-server#3242 <https://github.com/Graylog2/graylog2-server/issues/3242>`__
* Remove special handling in SplitAndCountConverter. `Graylog2/graylog2-server#3230 <https://github.com/Graylog2/graylog2-server/issues/3230>`__
* Add missing AuditBindings to journal commands. `Graylog2/graylog2-server#3226 <https://github.com/Graylog2/graylog2-server/issues/3226>`__
* Don't check private key/certificate if REST API and web interface on same port. `Graylog2/graylog2-server#3231 <https://github.com/Graylog2/graylog2-server/issues/3231>`__
* Add configuration settings for timeout and concurrency of OptimizeIndexJob. `Graylog2/graylog2-server#3225 <https://github.com/Graylog2/graylog2-server/issues/3225>`__
* Change way of exporting CSV search results. `Graylog2/graylog2-server#3238 <https://github.com/Graylog2/graylog2-server/issues/3238>`__
* Add space in processing limit notification. `Graylog2/graylog2-server#3256 <https://github.com/Graylog2/graylog2-server/issues/3256>`__
* Only recalculate index set ranges in index set maintenance menu. `Graylog2/graylog2-server#3252 <https://github.com/Graylog2/graylog2-server/issues/3252>`__
* Fix alert condition validations. `Graylog2/graylog2-server#3257 <https://github.com/Graylog2/graylog2-server/issues/3257>`__
* Validate alarm callbacks before saving them. `Graylog2/graylog2-server#3262 <https://github.com/Graylog2/graylog2-server/issues/3262>`__
* Only update index ranges for managed indices. `Graylog2/graylog2-server#3259 <https://github.com/Graylog2/graylog2-server/issues/3259>`__
* Resolve alerts from deleted alert conditions. `Graylog2/graylog2-server#3265 <https://github.com/Graylog2/graylog2-server/issues/3265>`__
* Alert UI changes. `Graylog2/graylog2-server#3266 <https://github.com/Graylog2/graylog2-server/issues/3266>`__
* Properly track stream throughput for the default stream. `Graylog2/graylog2-server#3278 <https://github.com/Graylog2/graylog2-server/issues/3278>`__
* Add support for OPTIONS request to HttpTransport. `Graylog2/graylog2-server#3234 <https://github.com/Graylog2/graylog2-server/issues/3234>`__
* Add list of stream IDs to Message#toElasticSearchObject(). `Graylog2/graylog2-server#3277 <https://github.com/Graylog2/graylog2-server/issues/3277>`__
* Fix document counts with an empty index set. `Graylog2/graylog2-server#3291 <https://github.com/Graylog2/graylog2-server/issues/3291>`__
* Handle ElasticsearchException in Counts class. `Graylog2/graylog2-server#3288 <https://github.com/Graylog2/graylog2-server/issues/3288>`__
* Move client-side split/import of Grok pattern files to server. `Graylog2/graylog2-server#3284 <https://github.com/Graylog2/graylog2-server/issues/3284>`__
* Showing index set in stream listing only if user is permitted to. `Graylog2/graylog2-server#3300 <https://github.com/Graylog2/graylog2-server/issues/3300>`__
* Fix reloading after notification changes. `Graylog2/graylog2-server#3264 <https://github.com/Graylog2/graylog2-server/issues/3264>`__
* Add "messages:analyze" permission to reader permission set. `Graylog2/graylog2-server#3305 <https://github.com/Graylog2/graylog2-server/issues/3305>`__
* Disable alarm notification controls if user is not permitted to edit. `Graylog2/graylog2-server#3303 <https://github.com/Graylog2/graylog2-server/issues/3303>`__
* Changing conditional to check for presence of index set definition. `Graylog2/graylog2-server#3304 <https://github.com/Graylog2/graylog2-server/issues/3304>`__
* Allow to get a thread dump as plain text. `Graylog2/graylog2-server#3289 <https://github.com/Graylog2/graylog2-server/issues/3289>`__
* Add missing authentication to ClusterResource and ClusterStatsResource. `Graylog2/graylog2-server#3279 <https://github.com/Graylog2/graylog2-server/issues/3279>`__
* Save anchor and last rotation in TimeBasedRotationStrategy depending on IndexSet. `Graylog2/graylog2-server#3306 <https://github.com/Graylog2/graylog2-server/issues/3306>`__
* Fix loading of plugins in development mode. `Graylog2/graylog2-server#3185 <https://github.com/Graylog2/graylog2-server/issues/3185>`__
* Add contains string tester. `Graylog2/graylog2-server#3186 <https://github.com/Graylog2/graylog2-server/issues/3186>`__
* Index set fixes. `Graylog2/graylog2-server#3193 <https://github.com/Graylog2/graylog2-server/issues/3193>`__
* Add synthetic JavaBean getters to AutoValue classes. `Graylog2/graylog2-server#3188 <https://github.com/Graylog2/graylog2-server/issues/3188>`__
* Improve IndexSetValidator. `Graylog2/graylog2-server#3197 <https://github.com/Graylog2/graylog2-server/issues/3197>`_
* Add custom Jackson (de-) serializer for ZonedDateTime and DateTime. `Graylog2/graylog2-server#3198 <https://github.com/Graylog2/graylog2-server/issues/3198>`__
* Improved alarm callback testing. `Graylog2/graylog2-server#3196 <https://github.com/Graylog2/graylog2-server/issues/3196>`__
* Fix DateTime serialization. `Graylog2/graylog2-server#3202 <https://github.com/Graylog2/graylog2-server/issues/3202>`__
* Fix labels on field graphs. `Graylog2/graylog2-server#3204 <https://github.com/Graylog2/graylog2-server/issues/3204>`__
* Alerts cleanup. `Graylog2/graylog2-server#3205 <https://github.com/Graylog2/graylog2-server/issues/3205>`__
* Index set UI fixes. `Graylog2/graylog2-server#3203 <https://github.com/Graylog2/graylog2-server/issues/3203>`__
* Fix quickvalues and field statistics refresh. `Graylog2/graylog2-server#3206 <https://github.com/Graylog2/graylog2-server/issues/3206>`__
* Allow fetching streams by index set ID. `Graylog2/graylog2-server#3207 <https://github.com/Graylog2/graylog2-server/issues/3207>`__
* UI improvements. `Graylog2/graylog2-server#3213 <https://github.com/Graylog2/graylog2-server/issues/3213>`__
* IndexSet default setting. `Graylog2/graylog2-server#3209 <https://github.com/Graylog2/graylog2-server/issues/3209>`__
* Alerts UI improvements. `Graylog2/graylog2-server#3214 <https://github.com/Graylog2/graylog2-server/issues/3214>`__
* Create DefaultIndexSetConfig when creating the default index set. `Graylog2/graylog2-server#3215 <https://github.com/Graylog2/graylog2-server/issues/3215>`__
* ClusterEventPeriodical must use MongoJackObjectMapper. `Graylog2/graylog2-server#3217 <https://github.com/Graylog2/graylog2-server/issues/3217>`__
* Fix V20161130141500_DefaultStreamRecalcIndexRanges. `Graylog2/graylog2-server#3222 <https://github.com/Graylog2/graylog2-server/issues/3222>`__
* Migration improvements. `Graylog2/graylog2-server#3211 <https://github.com/Graylog2/graylog2-server/issues/3211>`__

**Beats plugin**

* Add support for Metricbeat
* Extract "fields" for every type of beat

**Pipeline processor plugin**

* Allow duplicate stream titles in route_to_stream. `Graylog2/graylog-plugin-pipeline-processor#154 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/154>`__
* Do not use lambdas with gauge metrics. `Graylog2/graylog-plugin-pipeline-processor#152 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/152>`__
* Add clone_message() function. `Graylog2/graylog-plugin-pipeline-processor#153 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/153>`__
* Track total pipeline interpreter executionTime as a single metric. `Graylog2/graylog-plugin-pipeline-processor#155 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/155>`__

**Collector sidecar plugin**

* Fix: Reload on Beats configuration change.
* Update Beats to version 5.1.1
* Fix race conditions in start/stop/restart code for the exec runner `Graylog2/collector-sidecar#123 <https://github.com/Graylog2/collector-sidecar/issues/123>`__
* Add debug switch `Graylog2/collector-sidecar#124 <https://github.com/Graylog2/collector-sidecar/issues/124>`__
* Using Modern UI in a standard way (thanks to `@nicozanf <https://github.com/nicozanf>`__) `Graylog2/collector-sidecar#125 <https://github.com/Graylog2/collector-sidecar/issues/125>`__
* Extract etag cache into its own service. `Graylog2/graylog-plugin-collector#43 <https://github.com/Graylog2/graylog-plugin-collector/issues/43>`__

Graylog 2.1.3
=============

Released: 2017-01-26

https://www.graylog.org/blog/84-announcing-graylog-2-1-3

**Core**

* Use "order": -1 in default index template to allow override. `Graylog2/graylog2-server#3426 <https://github.com/Graylog2/graylog2-server/issues/3426>`__
* Add missing authentication to ClusterResource and ClusterStatsResource. `Graylog2/graylog2-server#3427 <https://github.com/Graylog2/graylog2-server/issues/3427>`__
* Unbreak Firefox by requesting JSON when pinging the API. `Graylog2/graylog2-server#3430 <https://github.com/Graylog2/graylog2-server/issues/3430>`__
* Use custom Grizzly error page to prevent XSS. `Graylog2/graylog2-server#3428 <https://github.com/Graylog2/graylog2-server/issues/3428>`__

**Beats plugin**

* Add support for Metricbeat. `Graylog2/graylog-plugin-beats#19 <https://github.com/Graylog2/graylog-plugin-beats/issues/19>`__
* Extract "fields" for every type of beat. `Graylog2/graylog-plugin-beats#18 <https://github.com/Graylog2/graylog-plugin-beats/issues/18>`__


Graylog 2.1.2
=============

Released: 2016-11-04

https://www.graylog.org/blog/75-announcing-graylog-v2-1-2

**Core**

* Improve logging in DecodingProcessor. `Graylog2/graylog2-server#3025 <https://github.com/Graylog2/graylog2-server/issues/3025>`__, `Graylog2/graylog2-server#3034 <https://github.com/Graylog2/graylog2-server/issues/3034>`__
* Support all ZLIB compression levels for GELF messages. `Graylog2/graylog2-server#3022 <https://github.com/Graylog2/graylog2-server/issues/3022>`__, `Graylog2/graylog2-server#3036 <https://github.com/Graylog2/graylog2-server/issues/3036>`__
* Implement "contains" stream rule. `Graylog2/graylog2-server#3020 <https://github.com/Graylog2/graylog2-server/issues/3020>`__, `Graylog2/graylog2-server#3037 <https://github.com/Graylog2/graylog2-server/issues/3037>`__
* Make ValidatorProvider a Singleton. `Graylog2/graylog2-server#3019 <https://github.com/Graylog2/graylog2-server/issues/3019>`__, `Graylog2/graylog2-server#3038 <https://github.com/Graylog2/graylog2-server/issues/3038>`__
* Fix NPE in MongoProbe if MongoDB doesn't run with MMAPv1. `Graylog2/graylog2-server#3018 <https://github.com/Graylog2/graylog2-server/issues/3018>`__, `Graylog2/graylog2-server#3039 <https://github.com/Graylog2/graylog2-server/issues/3039>`__
* Fix NPE in Indices#numberOfMessages(String). `Graylog2/graylog2-server#3016 <https://github.com/Graylog2/graylog2-server/issues/3016>`__, `Graylog2/graylog2-server#3041 <https://github.com/Graylog2/graylog2-server/issues/3041>`__
* Only create new LdapConnectionConfig if LDAP is enabled. `Graylog2/graylog2-server#3017 <https://github.com/Graylog2/graylog2-server/issues/3017>`__, `Graylog2/graylog2-server#3040 <https://github.com/Graylog2/graylog2-server/issues/3040>`__
* Properly track replace-all flag and pass through to API. `Graylog2/graylog2-server#3023 <https://github.com/Graylog2/graylog2-server/issues/3023>`__, `Graylog2/graylog2-server#3043 <https://github.com/Graylog2/graylog2-server/issues/3043>`__
* Replace Jersey GZipEncoder with Grizzly's GZipFilter. `Graylog2/graylog2-server#3021 <https://github.com/Graylog2/graylog2-server/issues/3021>`__, `Graylog2/graylog2-server#3044 <https://github.com/Graylog2/graylog2-server/issues/3044>`__
* Prevent n+1 query loading for Stream Rules. `Graylog2/graylog2-server#3024 <https://github.com/Graylog2/graylog2-server/issues/3024>`__, `Graylog2/graylog2-server#3035 <https://github.com/Graylog2/graylog2-server/issues/3035>`__. Thank you `@bjoernhaeuser <https://github.com/bjoernhaeuser>`__!
* Handle search execution errors. `Graylog2/graylog2-server#3027 <https://github.com/Graylog2/graylog2-server/issues/3027>`__, `Graylog2/graylog2-server#3045 <https://github.com/Graylog2/graylog2-server/issues/3045>`__
* Calculate cardinality on field graphs. `Graylog2/graylog2-server#3028 <https://github.com/Graylog2/graylog2-server/issues/3028>`__, `Graylog2/graylog2-server#3046 <https://github.com/Graylog2/graylog2-server/issues/3046>`__
* Update stats function in field graph description. `Graylog2/graylog2-server#3029 <https://github.com/Graylog2/graylog2-server/issues/3029>`__, `Graylog2/graylog2-server#3047 <https://github.com/Graylog2/graylog2-server/issues/3047>`__
* Use response status 500 if search failed but wasn't syntax error. `Graylog2/graylog2-server#3026 <https://github.com/Graylog2/graylog2-server/issues/3026>`__, `Graylog2/graylog2-server#3042 <https://github.com/Graylog2/graylog2-server/issues/3042>`__
* Improved search indicators. `Graylog2/graylog2-server#3031 <https://github.com/Graylog2/graylog2-server/issues/3031>`__, `Graylog2/graylog2-server#3050 <https://github.com/Graylog2/graylog2-server/issues/3050>`__
* Fix field analyzers loading when search changes. `Graylog2/graylog2-server#3030 <https://github.com/Graylog2/graylog2-server/issues/3030>`__, `Graylog2/graylog2-server#3049 <https://github.com/Graylog2/graylog2-server/issues/3049>`__
* Close search query autocompletion on enter. `Graylog2/graylog2-server#3032 <https://github.com/Graylog2/graylog2-server/issues/3032>`__, `Graylog2/graylog2-server#3051 <https://github.com/Graylog2/graylog2-server/issues/3051>`__
* Refresh stream search when stream changes. `Graylog2/graylog2-server#3033 <https://github.com/Graylog2/graylog2-server/issues/3033>`__, `Graylog2/graylog2-server#3052 <https://github.com/Graylog2/graylog2-server/issues/3052>`__
* Update Joda-Time and moment-timezone. `Graylog2/graylog2-server#3059 <https://github.com/Graylog2/graylog2-server/issues/3059>`__, `Graylog2/graylog2-server#3060 <https://github.com/Graylog2/graylog2-server/issues/3060>`__
* Search button does not always trigger a new search. `Graylog2/graylog2-server#3062 <https://github.com/Graylog2/graylog2-server/issues/3062>`__, `Graylog2/graylog2-server#3063 <https://github.com/Graylog2/graylog2-server/issues/3063>`__

**Beats plugin**

* Fix frame decoding in case of lost connection. `Graylog2/graylog-plugin-beats#14 <https://github.com/Graylog2/graylog-plugin-beats/issues/14>`__, `Graylog2/graylog-plugin-beats#15 <https://github.com/Graylog2/graylog-plugin-beats/issues/15>`__, `Graylog2/graylog-plugin-beats#17 <https://github.com/Graylog2/graylog-plugin-beats/issues/17>`__. Thank you `@hc4 <https://github.com/hc4>`__!
* Support messages >1024 bytes in BeatsFrameDecoder. `Graylog2/graylog-plugin-beats#10 <https://github.com/Graylog2/graylog-plugin-beats/issues/10>`__, `Graylog2/graylog-plugin-beats#12 <https://github.com/Graylog2/graylog-plugin-beats/issues/12>`__

**Pipeline processor plugin**

* Don't doubly negate the value of the expression. `Graylog2/graylog-plugin-pipeline-processor#126 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/126>`__, `Graylog2/graylog-plugin-pipeline-processor#127 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/127>`__


Graylog 2.1.1
=============

Released: 2016-09-14

https://www.graylog.org/blog/69-announcing-graylog-v2-1-1

**Core**

* Proxied requests query other nodes in parallel. `Graylog2/graylog2-server#2764 <https://github.com/Graylog2/graylog2-server/issues/2764>`__, `Graylog2/graylog2-server#2779 <https://github.com/Graylog2/graylog2-server/issues/2779>`__
* Fix 404s on IE 11 using compatibility view. `Graylog2/graylog2-server#2768 <https://github.com/Graylog2/graylog2-server/issues/2768>`__, `Graylog2/graylog2-server#2782 <https://github.com/Graylog2/graylog2-server/issues/2782>`__
* Modify actions in search page triggering a page reload. `Graylog2/graylog2-server#2488 <https://github.com/Graylog2/graylog2-server/issues/2488>`__, `Graylog2/graylog2-server#2798 <https://github.com/Graylog2/graylog2-server/issues/2798>`__
* Do not display login form while loading. `Graylog2/graylog2-server#2770 <https://github.com/Graylog2/graylog2-server/issues/2770>`__, `Graylog2/graylog2-server#2802 <https://github.com/Graylog2/graylog2-server/issues/2802>`__
* Check in SearchPage if search is in progress, reuse promise then. `Graylog2/graylog2-server#2799 <https://github.com/Graylog2/graylog2-server/issues/2799>`__, `Graylog2/graylog2-server#2803 <https://github.com/Graylog2/graylog2-server/issues/2803>`__
* Use index and message\_id as message identifier. `Graylog2/graylog2-server#2801 <https://github.com/Graylog2/graylog2-server/issues/2801>`__, `Graylog2/graylog2-server#2804 <https://github.com/Graylog2/graylog2-server/issues/2804>`__
* Fix: file handle leak in KeyUtil (SSL). `Graylog2/graylog2-server#2808 <https://github.com/Graylog2/graylog2-server/issues/2808>`__. Thank you `@gbu-censhare <https://github.com/gbu-censhare>`__!
* Use current search time configuration for CSV export. `Graylog2/graylog2-server#2795 <https://github.com/Graylog2/graylog2-server/issues/2795>`__, `Graylog2/graylog2-server#2809 <https://github.com/Graylog2/graylog2-server/issues/2809>`__
* Explicitly close okhttp response body, avoiding leak connection warning. `Graylog2/graylog2-server#2811 <https://github.com/Graylog2/graylog2-server/issues/2811>`__. Thank you `@chainkite <https://github.com/chainkite>`__!
* Properly close OkHttp Response objects to avoid resource leaks. `Graylog2/graylog2-server#2812 <https://github.com/Graylog2/graylog2-server/issues/2812>`__
* Remove ldap settings check from authenticators. `Graylog2/graylog2-server#2817 <https://github.com/Graylog2/graylog2-server/issues/2817>`__, `Graylog2/graylog2-server#2820 <https://github.com/Graylog2/graylog2-server/issues/2820>`__

**Map plugin**

* Ignore internal message fields (starting with "gl2\_"). `Graylog2/graylog-plugin-map-widget#17 <https://github.com/Graylog2/graylog-plugin-map-widget/issues/17>`__

**Pipeline processor plugin**

* Display boolean values in pipeline simulator. `Graylog2/graylog-plugin-pipeline-processor#54 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/54>`__, `Graylog2/graylog-plugin-pipeline-processor#99 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/99>`__
* Use case insensitive lookup for timezone IDs. `Graylog2/graylog-plugin-pipeline-processor#100 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/100>`__, `Graylog2/graylog-plugin-pipeline-processor#102 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/102>`__


Graylog 2.1.0
=============

Released: 2016-09-01

https://www.graylog.org/blog/68-announcing-graylog-v-2-1-0-ga

**Core**

* Refactoring of audit events.
  `Graylog2/graylog2-server#2687 <https://github.com/Graylog2/graylog2-server/issues/2687>`__
* Add a prop to display/hide the page selector.
  `Graylog2/graylog2-server#2711 <https://github.com/Graylog2/graylog2-server/issues/2711>`__
* Ensure that ``rest_transport_uri`` can override the URI scheme of ``rest_listen_uri``.
  `Graylog2/graylog2-server#2680 <https://github.com/Graylog2/graylog2-server/issues/2680>`__,
  `Graylog2/graylog2-server#2704 <https://github.com/Graylog2/graylog2-server/issues/2704>`__
* Handle indexer cluster down in web interface.
  `Graylog2/graylog2-server#2623 <https://github.com/Graylog2/graylog2-server/issues/2623>`__,
  `Graylog2/graylog2-server#2713 <https://github.com/Graylog2/graylog2-server/issues/2713>`__
* Prevent NPE and verbose logging if converter returns null.
  `Graylog2/graylog2-server#2717 <https://github.com/Graylog2/graylog2-server/issues/2717>`__,
  `Graylog2/graylog2-server#2729 <https://github.com/Graylog2/graylog2-server/issues/2729>`__
* Let widget replay search button open in a new tab or window.
  `Graylog2/graylog2-server#2725 <https://github.com/Graylog2/graylog2-server/issues/2725>`__,
  `Graylog2/graylog2-server#2726 <https://github.com/Graylog2/graylog2-server/issues/2726>`__
* Return ``"id"`` instead of ``"_id"`` for message decorators.
  `Graylog2/graylog2-server#2734 <https://github.com/Graylog2/graylog2-server/issues/2734>`__,
  `Graylog2/graylog2-server#2735 <https://github.com/Graylog2/graylog2-server/issues/2735>`__
* Make id field consistent for alarm callback histories.
  `Graylog2/graylog2-server#2737 <https://github.com/Graylog2/graylog2-server/issues/2737>`__
* Audit event changes.
  `Graylog2/graylog2-server#2718 <https://github.com/Graylog2/graylog2-server/issues/2718>`__
* Let specific stores reuse promises if request is in progress.
  `Graylog2/graylog2-server#2625 <https://github.com/Graylog2/graylog2-server/issues/2625>`__,
  `Graylog2/graylog2-server#2712 <https://github.com/Graylog2/graylog2-server/issues/2712>`__
* Disable editing controls for decorator if user lacks permissions.
  `Graylog2/graylog2-server#2730 <https://github.com/Graylog2/graylog2-server/issues/2730>`__,
  `Graylog2/graylog2-server#2736 <https://github.com/Graylog2/graylog2-server/issues/2736>`__
* Styling of decorator list.
  `Graylog2/graylog2-server#2743 <https://github.com/Graylog2/graylog2-server/issues/2743>`__,
  `Graylog2/graylog2-server#2744 <https://github.com/Graylog2/graylog2-server/issues/2744>`__
* Do not load plugins for journal commands.
  `Graylog2/graylog2-server#2667 <https://github.com/Graylog2/graylog2-server/issues/2667>`__
* Use proper other count for pie chart slices.
  `Graylog2/graylog2-server#2639 <https://github.com/Graylog2/graylog2-server/issues/2639>`__, `Graylog2/graylog2-server#2671 <https://github.com/Graylog2/graylog2-server/issues/2671>`__
* Removing unused prop type in StreamRuleList component.
  `Graylog2/graylog2-server#2673 <https://github.com/Graylog2/graylog2-server/issues/2673>`__
* Add a generic search form component. `Graylog2/graylog2-server#2678 <https://github.com/Graylog2/graylog2-server/issues/2678>`__
* Decorator improvements. `Graylog2/graylog2-server#2519 <https://github.com/Graylog2/graylog2-server/issues/2519>`__,
  `Graylog2/graylog2-server#2666 <https://github.com/Graylog2/graylog2-server/issues/2666>`__,
  `Graylog2/graylog2-server#2674 <https://github.com/Graylog2/graylog2-server/issues/2674>`__
* Only show notification link when there are notifications.
  `Graylog2/graylog2-server#2677 <https://github.com/Graylog2/graylog2-server/issues/2677>`__
* Enable gzip per default for REST API listener.
  `Graylog2/graylog2-server#2670 <https://github.com/Graylog2/graylog2-server/issues/2670>`__,
  `Graylog2/graylog2-server#2672 <https://github.com/Graylog2/graylog2-server/issues/2672>`__
* Improvements in raw message loader. `Graylog2/graylog2-server#2684 <https://github.com/Graylog2/graylog2-server/issues/2684>`__
* Allow users of MessageFields to disable field actions.
  `Graylog2/graylog2-server#2685 <https://github.com/Graylog2/graylog2-server/issues/2685>`__
* Generating a relative redirect URL for web interface in root
  resource. `Graylog2/graylog2-server#2593 <https://github.com/Graylog2/graylog2-server/issues/2593>`__,
  `Graylog2/graylog2-server#2675 <https://github.com/Graylog2/graylog2-server/issues/2675>`__
* Add help text for session's client address.
  `Graylog2/graylog2-server#2656 <https://github.com/Graylog2/graylog2-server/issues/2656>`__,
  `Graylog2/graylog2-server#2692 <https://github.com/Graylog2/graylog2-server/issues/2692>`__
* Fix content pack extractor validation.
  `Graylog2/graylog2-server#2663 <https://github.com/Graylog2/graylog2-server/issues/2663>`__,
  `Graylog2/graylog2-server#2697 <https://github.com/Graylog2/graylog2-server/issues/2697>`__
* Reset users' startpages if referenced stream/dashboard is deleted.
  `Graylog2/graylog2-server#2400 <https://github.com/Graylog2/graylog2-server/issues/2400>`__,
  `Graylog2/graylog2-server#2695 <https://github.com/Graylog2/graylog2-server/issues/2695>`__,
  `Graylog2/graylog2-server#2702 <https://github.com/Graylog2/graylog2-server/issues/2702>`__
* Fix token creation via API browser. `Graylog2/graylog2-server#2668 <https://github.com/Graylog2/graylog2-server/issues/2668>`__,
  `Graylog2/graylog2-server#2698 <https://github.com/Graylog2/graylog2-server/issues/2698>`__
* Allow surrounding search to be opened in new tab.
  `Graylog2/graylog2-server#2531 <https://github.com/Graylog2/graylog2-server/issues/2531>`__,
  `Graylog2/graylog2-server#2699 <https://github.com/Graylog2/graylog2-server/issues/2699>`__
* Reformatting component, adding error handler for fetching dashboard.
  `Graylog2/graylog2-server#2576 <https://github.com/Graylog2/graylog2-server/issues/2576>`__,
  `Graylog2/graylog2-server#2703 <https://github.com/Graylog2/graylog2-server/issues/2703>`__
* Add format string message decorator. `Graylog2/graylog2-server#2660 <https://github.com/Graylog2/graylog2-server/issues/2660>`__
* Reloading CurrentUserStore when updated user is the current user.
  `Graylog2/graylog2-server#2705 <https://github.com/Graylog2/graylog2-server/issues/2705>`__,
  `Graylog2/graylog2-server#2706 <https://github.com/Graylog2/graylog2-server/issues/2706>`__
* General UI improvements `Graylog2/graylog2-server#2700 <https://github.com/Graylog2/graylog2-server/issues/2700>`__
* Add Syslog severity mapper decorator.
  `Graylog2/graylog2-server#2590 <https://github.com/Graylog2/graylog2-server/issues/2590>`__
* Improvements in message decorators.
  `Graylog2/graylog2-server#2592 <https://github.com/Graylog2/graylog2-server/issues/2592>`__,
  `Graylog2/graylog2-server#2591 <https://github.com/Graylog2/graylog2-server/issues/2591>`__,
  `Graylog2/graylog2-server#2598 <https://github.com/Graylog2/graylog2-server/issues/2598>`__,
  `Graylog2/graylog2-server#2654 <https://github.com/Graylog2/graylog2-server/issues/2654>`__
* Revert "Move link to API Browser into System menu".
  `Graylog2/graylog2-server#2586 <https://github.com/Graylog2/graylog2-server/issues/2586>`__,
  `Graylog2/graylog2-server#2587 <https://github.com/Graylog2/graylog2-server/issues/2587>`__
* Print - instead of null when client did not provide user agent
  header.
  `Graylog2/graylog2-server#2601 <https://github.com/Graylog2/graylog2-server/issues/2601>`__.
  Thank you `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* Change logging in normalizeDn() to debug to avoid noisy warnings.
  `Graylog2/graylog2-server#2599 <https://github.com/Graylog2/graylog2-server/issues/2599>`__
* Ensure that ``{rest,web}_{listen,transport,endpoint}_uri`` settings are
  absolute URIs.
  `Graylog2/graylog2-server#2589 <https://github.com/Graylog2/graylog2-server/issues/2589>`__,
  `Graylog2/graylog2-server#2596 <https://github.com/Graylog2/graylog2-server/issues/2596>`__,
  `Graylog2/graylog2-server#2600 <https://github.com/Graylog2/graylog2-server/issues/2600>`__
* Use HTTP and HTTPS default ports for network settings.
  `Graylog2/graylog2-server#2595 <https://github.com/Graylog2/graylog2-server/issues/2595>`__,
  `Graylog2/graylog2-server#2605 <https://github.com/Graylog2/graylog2-server/issues/2605>`__
* Dashboard improvements.
  `Graylog2/graylog2-server#2084 <https://github.com/Graylog2/graylog2-server/issues/2084>`__,
  `Graylog2/graylog2-server#2281 <https://github.com/Graylog2/graylog2-server/issues/2281>`__,
  `Graylog2/graylog2-server#2626 <https://github.com/Graylog2/graylog2-server/issues/2626>`__
* Ensure that ``password_secret`` is at least 16 characters long.
  `Graylog2/graylog2-server#2619 <https://github.com/Graylog2/graylog2-server/issues/2619>`__,
  `Graylog2/graylog2-server#2622 <https://github.com/Graylog2/graylog2-server/issues/2622>`__
* Reduce production .js files sizes by 51%.
  `Graylog2/graylog2-server#2617 <https://github.com/Graylog2/graylog2-server/issues/2617>`__
* Allow ``web_endpoint_uri`` to be a relative URI.
  `Graylog2/graylog2-server#2600 <https://github.com/Graylog2/graylog2-server/issues/2600>`__,
  `Graylog2/graylog2-server#2614 <https://github.com/Graylog2/graylog2-server/issues/2614>`__
* Use default session attribute for principal.
  `Graylog2/graylog2-server#2620 <https://github.com/Graylog2/graylog2-server/issues/2620>`__,
  `Graylog2/graylog2-server#2621 <https://github.com/Graylog2/graylog2-server/issues/2621>`__
* Compile regex pattern for MetricFilter only once.
  `Graylog2/graylog2-server#2637 <https://github.com/Graylog2/graylog2-server/issues/2637>`__.
  Thank you again
  `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* Fix NPE in Indices#checkForReopened(IndexMetaData).
  `Graylog2/graylog2-server#2628 <https://github.com/Graylog2/graylog2-server/issues/2628>`__,
  `Graylog2/graylog2-server#2635 <https://github.com/Graylog2/graylog2-server/issues/2635>`__
* Mark message offset as committed in case of a decoding error.
  `Graylog2/graylog2-server#2627 <https://github.com/Graylog2/graylog2-server/issues/2627>`__,
  `Graylog2/graylog2-server#2643 <https://github.com/Graylog2/graylog2-server/issues/2643>`__
* Fix cloning streams and editing legacy stream rules.
  `Graylog2/graylog2-server#2244 <https://github.com/Graylog2/graylog2-server/issues/2244>`__,
  `Graylog2/graylog2-server#2346 <https://github.com/Graylog2/graylog2-server/issues/2346>`__,
  `Graylog2/graylog2-server#2646 <https://github.com/Graylog2/graylog2-server/issues/2646>`__
* Add back storing of index failures in MongoDB.
  `Graylog2/graylog2-server#2633 <https://github.com/Graylog2/graylog2-server/issues/2633>`__,
  `Graylog2/graylog2-server#2644 <https://github.com/Graylog2/graylog2-server/issues/2644>`__
* Enable running Graylog REST API on different context path.
  `Graylog2/graylog2-server#2603 <https://github.com/Graylog2/graylog2-server/issues/2603>`__,
  `Graylog2/graylog2-server#2397 <https://github.com/Graylog2/graylog2-server/issues/2397>`__,
  `Graylog2/graylog2-server#2634 <https://github.com/Graylog2/graylog2-server/issues/2634>`__
* Add support for ECDSA private keys to KeyUtil.
  `Graylog2/graylog2-server#2454 <https://github.com/Graylog2/graylog2-server/issues/2454>`__,
  `Graylog2/graylog2-server#2641 <https://github.com/Graylog2/graylog2-server/issues/2641>`__
* Check for conflict of ``rest_listen_uri`` and ``web_listen_uri``.
  `Graylog2/graylog2-server#2634 <https://github.com/Graylog2/graylog2-server/issues/2634>`__,
  `Graylog2/graylog2-server#2652 <https://github.com/Graylog2/graylog2-server/issues/2652>`__
* Remove uppercase example decorator before 2.1 final.
  `Graylog2/graylog2-server#2588 <https://github.com/Graylog2/graylog2-server/issues/2588>`__,
  `Graylog2/graylog-plugin-pipeline-processor#73 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/73>`__
* Make sure to include charset in getBytes and other relevant code
  sections.
  `Graylog2/graylog2-server#2567 <https://github.com/Graylog2/graylog2-server/issues/2567>`__,
  `Graylog2/graylog2-server#2574 <https://github.com/Graylog2/graylog2-server/issues/2574>`__
* Landing page greets with 2.0 in 2.1.
  `Graylog2/graylog2-server#2579 <https://github.com/Graylog2/graylog2-server/issues/2579>`__
* Run WebAppNotFoundResponseFilter later and for GET requests only.
  `Graylog2/graylog2-server#2657 <https://github.com/Graylog2/graylog2-server/issues/2657>`__,
  `Graylog2/graylog2-server#2664 <https://github.com/Graylog2/graylog2-server/issues/2664>`__
* Update dependencies.
  `Graylog2/graylog2-server#2543 <https://github.com/Graylog2/graylog2-server/issues/2543>`__,
  `Graylog2/graylog2-server#2565 <https://github.com/Graylog2/graylog2-server/issues/2565>`__
* Allowing to run REST API and web interface on same port.
  `Graylog2/graylog2-server#2515 <https://github.com/Graylog2/graylog2-server/issues/2515>`__
* Changing default to make REST API and web if to listen on same
  host/port.
  `Graylog2/graylog2-server#2446 <https://github.com/Graylog2/graylog2-server/issues/2446>`__,
  `Graylog2/graylog2-server#2525 <https://github.com/Graylog2/graylog2-server/issues/2525>`__
* Change plugin REST resource injection to use Class instances.
  `Graylog2/graylog2-server#2492 <https://github.com/Graylog2/graylog2-server/issues/2492>`__
* Validate that Elasticsearch home/data paths are readable.
  `Graylog2/graylog2-server#2536 <https://github.com/Graylog2/graylog2-server/issues/2536>`__,
  `Graylog2/graylog2-server#2538 <https://github.com/Graylog2/graylog2-server/issues/2538>`__
* Fix Version#fromClasspathProperties() when loading from JAR plugin.
  `Graylog2/graylog2-server#2535 <https://github.com/Graylog2/graylog2-server/issues/2535>`__
* Decorator UI Fixes.
  `Graylog2/graylog2-server#2539 <https://github.com/Graylog2/graylog2-server/issues/2539>`__
* Fix timing issue in MessageCountAlertCondition.
  `Graylog2/graylog2-server#1704 <https://github.com/Graylog2/graylog2-server/issues/1704>`__,
  `Graylog2/graylog2-server#2382 <https://github.com/Graylog2/graylog2-server/issues/2382>`__,
  `Graylog2/graylog2-server#2546 <https://github.com/Graylog2/graylog2-server/issues/2546>`__
* For HttpHeadersToken pass actual remote address.
  `Graylog2/graylog2-server#2556 <https://github.com/Graylog2/graylog2-server/issues/2556>`__
* Do not blindly override permission set of ldap users.
  `Graylog2/graylog2-server#2516 <https://github.com/Graylog2/graylog2-server/issues/2516>`__,
  `Graylog2/graylog2-server#2529 <https://github.com/Graylog2/graylog2-server/issues/2529>`__
* Display original date time of index ranges on hover.
  `Graylog2/graylog2-server#2549 <https://github.com/Graylog2/graylog2-server/issues/2549>`__,
  `Graylog2/graylog2-server#2552 <https://github.com/Graylog2/graylog2-server/issues/2552>`__
* Make it possible for plugins to request a shared class loader.
  `Graylog2/graylog2-server#2436 <https://github.com/Graylog2/graylog2-server/issues/2436>`__,
  `Graylog2/graylog2-server#2508 <https://github.com/Graylog2/graylog2-server/issues/2508>`__
* Fix REST API browser after changes to the PluginRestResource
  injection.
  `Graylog2/graylog2-server#2550 <https://github.com/Graylog2/graylog2-server/issues/2550>`__
* Make version comparison more lenient with pre-release versions.
  `Graylog2/graylog2-server#2462 <https://github.com/Graylog2/graylog2-server/issues/2462>`__,
  `Graylog2/graylog2-server#2548 <https://github.com/Graylog2/graylog2-server/issues/2548>`__
* Always trim message field values on Message class.
  `Graylog2/graylog2-server#1936 <https://github.com/Graylog2/graylog2-server/issues/1936>`__,
  `Graylog2/graylog2-server#2510 <https://github.com/Graylog2/graylog2-server/issues/2510>`__
* Fix search results console warnings.
  `Graylog2/graylog2-server#2527 <https://github.com/Graylog2/graylog2-server/issues/2527>`__
* Fix bulk import of Grok patterns.
  `Graylog2/graylog2-server#2229 <https://github.com/Graylog2/graylog2-server/issues/2229>`__,
  `Graylog2/graylog2-server#2561 <https://github.com/Graylog2/graylog2-server/issues/2561>`__
* Add helper method to add AuditLogAppenders.
  `Graylog2/graylog2-server#2562 <https://github.com/Graylog2/graylog2-server/issues/2562>`__
* Add explanation about the configuration file format.
  `Graylog2/graylog2-server#2563 <https://github.com/Graylog2/graylog2-server/issues/2563>`__
* Display session information, fix usability in user list, editing
  users.
  `Graylog2/graylog2-server#2526 <https://github.com/Graylog2/graylog2-server/issues/2526>`__,
  `Graylog2/graylog2-server#2528 <https://github.com/Graylog2/graylog2-server/issues/2528>`__,
  `Graylog2/graylog2-server#2540 <https://github.com/Graylog2/graylog2-server/issues/2540>`__,
  `Graylog2/graylog2-server#2541 <https://github.com/Graylog2/graylog2-server/issues/2541>`__
* Fix issues with app prefix.
  `Graylog2/graylog2-server#2564 <https://github.com/Graylog2/graylog2-server/issues/2564>`__,
  `Graylog2/graylog2-server#2583 <https://github.com/Graylog2/graylog2-server/issues/2583>`__
* Fix extractor and static fields creation in multi-node setups.
  `Graylog2/graylog2-server#2580 <https://github.com/Graylog2/graylog2-server/issues/2580>`__,
  `Graylog2/graylog2-server#2584 <https://github.com/Graylog2/graylog2-server/issues/2584>`__
* Authentication improvements.
  `Graylog2/graylog2-server#2572 <https://github.com/Graylog2/graylog2-server/issues/2572>`__,
  `Graylog2/graylog2-server#2573 <https://github.com/Graylog2/graylog2-server/issues/2573>`__
* Move Error Prone into default build profile.
  `Graylog2/graylog2-server#2575 <https://github.com/Graylog2/graylog2-server/issues/2575>`__
* Journal info command does not work.
  `Graylog2/graylog2-server#2493 <https://github.com/Graylog2/graylog2-server/issues/2493>`__
  and
  `Graylog2/graylog2-server#2495 <https://github.com/Graylog2/graylog2-server/issues/2495>`__
* Search result highlighting color similar to white.
  `Graylog2/graylog2-server#2480 <https://github.com/Graylog2/graylog2-server/issues/2480>`__
* Cannot POST on Regex Tester (error 500).
  `Graylog2/graylog2-server#2471 <https://github.com/Graylog2/graylog2-server/issues/2471>`__
  and
  `Graylog2/graylog2-server#2472 <https://github.com/Graylog2/graylog2-server/issues/2472>`__
* Middle-clicking to open new tab not working for some System menu
  items.
  `Graylog2/graylog2-server#2468 <https://github.com/Graylog2/graylog2-server/issues/2468>`__
* Json extractor should check for valid lucene keys.
  `Graylog2/graylog2-server#2434 <https://github.com/Graylog2/graylog2-server/issues/2434>`__
  and
  `Graylog2/graylog2-server#2481 <https://github.com/Graylog2/graylog2-server/issues/2481>`__
* Elasticsearch Red cluster state triggered by index rotation under
  some conditions.
  `Graylog2/graylog2-server#2371 <https://github.com/Graylog2/graylog2-server/issues/2371>`__,
  `Graylog2/graylog2-server#2429 <https://github.com/Graylog2/graylog2-server/issues/2429>`__
  and
  `Graylog2/graylog2-server#2477 <https://github.com/Graylog2/graylog2-server/issues/2477>`__
* Report syntax error when search query contains unescaped slash.
  `Graylog2/graylog2-server#2372 <https://github.com/Graylog2/graylog2-server/issues/2372>`__
  and
  `Graylog2/graylog2-server#2450 <https://github.com/Graylog2/graylog2-server/issues/2450>`__
* Allowing path prefixes in ``web_listen_uri`` so web interface is
  accessible via path != "/".
  `Graylog2/graylog2-server#2271 <https://github.com/Graylog2/graylog2-server/issues/2271>`__
  and
  `Graylog2/graylog2-server#2440 <https://github.com/Graylog2/graylog2-server/issues/2440>`__
* LDAP group mapping: stringwise comparison fails due to different DN
  formats.
  `Graylog2/graylog2-server#1790 <https://github.com/Graylog2/graylog2-server/issues/1790>`__
  and
  `Graylog2/graylog2-server#2484 <https://github.com/Graylog2/graylog2-server/issues/2484>`__
* Json extractor prefix.
  `Graylog2/graylog2-server#1646 <https://github.com/Graylog2/graylog2-server/issues/1646>`__
  and
  `Graylog2/graylog2-server#2481 <https://github.com/Graylog2/graylog2-server/issues/2481>`__
* LDAP users are shown a change password form.
  `Graylog2/graylog2-server#2124 <https://github.com/Graylog2/graylog2-server/issues/2124>`__,
  `Graylog2/graylog2-server#2327 <https://github.com/Graylog2/graylog2-server/issues/2327>`__
  and
  `Graylog2/graylog2-server#2485 <https://github.com/Graylog2/graylog2-server/issues/2485>`__
* Switch message filters from polling to subscribing to change events.
  `Graylog2/graylog2-server#2391 <https://github.com/Graylog2/graylog2-server/issues/2391>`__
  and
  `Graylog2/graylog2-server#2496 <https://github.com/Graylog2/graylog2-server/issues/2496>`__
* Make auth providers fully pluggable.
  `Graylog2/graylog2-server#2232 <https://github.com/Graylog2/graylog2-server/issues/2232>`__,
  `Graylog2/graylog2-server#2367 <https://github.com/Graylog2/graylog2-server/issues/2367>`__
  and
  `Graylog2/graylog2-server#2522 <https://github.com/Graylog2/graylog2-server/issues/2522>`__
* Grok extractor: Allow returning only named captures.
  `Graylog2/graylog2-server#1486 <https://github.com/Graylog2/graylog2-server/issues/1486>`__
  and
  `Graylog2/graylog2-server#2500 <https://github.com/Graylog2/graylog2-server/issues/2500>`__
* Attempt reading DSA key if RSA failed.
  `Graylog2/graylog2-server#2503 <https://github.com/Graylog2/graylog2-server/issues/2503>`__.
  Special thanks to
  `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* Fix session validation propagation.
  `Graylog2/graylog2-server#2498 <https://github.com/Graylog2/graylog2-server/issues/2498>`__
* A wrapper to protect from decompression bombs.
  `Graylog2/graylog2-server#2339 <https://github.com/Graylog2/graylog2-server/issues/2339>`__.
  Thank you again,
  `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* Make exceptions more useful by providing messages and context.
  `Graylog2/graylog2-server#2478 <https://github.com/Graylog2/graylog2-server/issues/2478>`__
* Decorate search results.
  `Graylog2/graylog2-server#2408 <https://github.com/Graylog2/graylog2-server/issues/2408>`__,
  `Graylog2/graylog2-server#2482 <https://github.com/Graylog2/graylog2-server/issues/2482>`__,
  `Graylog2/graylog2-server#2499 <https://github.com/Graylog2/graylog2-server/issues/2499>`__,
  `Graylog2/graylog-plugin-pipeline-processor#41 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/41>`__,
  `Graylog2/graylog-plugin-pipeline-processor#43 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/43>`__
  and
  `Graylog2/graylog-plugin-pipeline-processor#52 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/52>`__
* Introduce CombinedProvider to sync actions and stores initialization.
  `Graylog2/graylog2-server#2523 <https://github.com/Graylog2/graylog2-server/issues/2523>`__
* Actually use the bluebird promise in FetchProvider. `Graylog2/graylog2-server#2762 <https://github.com/Graylog2/graylog2-server/issues/2762>`__
* Audit event cleanup. `Graylog2/graylog2-server#2746 <https://github.com/Graylog2/graylog2-server/issues/2746>`__
* Update documentation links. `Graylog2/graylog2-server#2759 <https://github.com/Graylog2/graylog2-server/issues/2759>`__
* Allow child elements in the search form. `Graylog2/graylog2-server#2756 <https://github.com/Graylog2/graylog2-server/issues/2756>`__
* Make key_prefix configuration optional. `Graylog2/graylog2-server#2755 <https://github.com/Graylog2/graylog2-server/issues/2755>`__, `Graylog2/graylog2-server#2757 <https://github.com/Graylog2/graylog2-server/issues/2757>`__
* Invalidating widget result cache cluster wide when a widget changes. `Graylog2/graylog2-server#2732 <https://github.com/Graylog2/graylog2-server/issues/2732>`__, `Graylog2/graylog2-server#2745 <https://github.com/Graylog2/graylog2-server/issues/2745>`__
* Correct documentation links in 'misc/graylog.conf'. `Graylog2/graylog2-server#2747 <https://github.com/Graylog2/graylog2-server/issues/2747>`__. Thank you `@supahgreg <https://github.com/supahgreg>`__!
* Throttle LB status if journal utilization is too high.
  `Graylog2/graylog2-server#1100 <https://github.com/Graylog2/graylog2-server/issues/1100>`__,
  `Graylog2/graylog2-server#1952 <https://github.com/Graylog2/graylog2-server/issues/1952>`__
  and
  `Graylog2/graylog2-server#2312 <https://github.com/Graylog2/graylog2-server/issues/2312>`__.
  Thank you `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* TLS ciphers for inputs should probably be configurable.
  `Graylog2/graylog2-server#2051 <https://github.com/Graylog2/graylog2-server/issues/2051>`__.
* SelfSignedCertificate should migrate from sun.security.\*.
  `Graylog2/graylog2-server#2132 <https://github.com/Graylog2/graylog2-server/issues/2132>`__
  and
  `Graylog2/graylog2-server#2316 <https://github.com/Graylog2/graylog2-server/issues/2316>`__.
  Thank you `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* Fix formatting metric names including more than one namespace prefix.
  `Graylog2/graylog2-server#2254 <https://github.com/Graylog2/graylog2-server/issues/2254>`__
  and
  `Graylog2/graylog2-server#2425 <https://github.com/Graylog2/graylog2-server/issues/2425>`__.
* Waiting for index range calculation before switching deflector alias.
  `Graylog2/graylog2-server#2264 <https://github.com/Graylog2/graylog2-server/issues/2264>`__
  and
  `Graylog2/graylog2-server#2278 <https://github.com/Graylog2/graylog2-server/issues/2278>`__.
* Specify application.context.
  `Graylog2/graylog2-server#2271 <https://github.com/Graylog2/graylog2-server/issues/2271>`__
  and
  `Graylog2/graylog2-server#2440 <https://github.com/Graylog2/graylog2-server/issues/2440>`__.
* Add handler for / in the Graylog REST API.
  `Graylog2/graylog2-server#2376 <https://github.com/Graylog2/graylog2-server/issues/2376>`__
  and
  `Graylog2/graylog2-server#2377 <https://github.com/Graylog2/graylog2-server/issues/2377>`__.
* User preferred timezone not saved.
  `Graylog2/graylog2-server#2393 <https://github.com/Graylog2/graylog2-server/issues/2393>`__
  and
  `Graylog2/graylog2-server#2395 <https://github.com/Graylog2/graylog2-server/issues/2395>`__.
* Unable to delete closed index.
  `Graylog2/graylog2-server#2419 <https://github.com/Graylog2/graylog2-server/issues/2419>`__
  and
  `Graylog2/graylog2-server#2437 <https://github.com/Graylog2/graylog2-server/issues/2437>`__.
* Absolute search results in widget using wrong time.
  `Graylog2/graylog2-server#2428 <https://github.com/Graylog2/graylog2-server/issues/2428>`__
  and
  `Graylog2/graylog2-server#2452 <https://github.com/Graylog2/graylog2-server/issues/2452>`__.
* Upgrade to Kafka 0.9.0.1.
  `Graylog2/graylog2-server#1912 <https://github.com/Graylog2/graylog2-server/issues/1912>`__.
* RestAccessLogFilter to use X-Forwarded-For set by trusted proxies.
  `Graylog2/graylog2-server#1981 <https://github.com/Graylog2/graylog2-server/issues/1981>`__.
  Thank you `@mikkolehtisalo <https://github.com/mikkolehtisalo>`__!
* Upgrade to Drools 6.4.0.Final.
  `Graylog2/graylog2-server#2106 <https://github.com/Graylog2/graylog2-server/issues/2106>`__.
* Stream Rule Titles.
  `Graylog2/graylog2-server#2244 <https://github.com/Graylog2/graylog2-server/issues/2244>`__.
* Improve search with no results page.
  `Graylog2/graylog2-server#2253 <https://github.com/Graylog2/graylog2-server/issues/2253>`__.
* Refactor Version class to use com.github.zafarkhaja.semver.Version.
  `Graylog2/graylog2-server#2275 <https://github.com/Graylog2/graylog2-server/issues/2275>`__.
* Alert condition titles.
  `Graylog2/graylog2-server#2282 <https://github.com/Graylog2/graylog2-server/issues/2282>`__.
* Upgrade to Jackson 2.7.4.
  `Graylog2/graylog2-server#2304 <https://github.com/Graylog2/graylog2-server/issues/2304>`__.
* Support changes for pipeline processor simulator.
  `Graylog2/graylog2-server#2320 <https://github.com/Graylog2/graylog2-server/issues/2320>`__.
* Add dependency on jna to fix chatty Elasticseach log message.
  `Graylog2/graylog2-server#2342 <https://github.com/Graylog2/graylog2-server/issues/2342>`__.
* Interfaces and simple implementations of an audit log.
  `Graylog2/graylog2-server#2344 <https://github.com/Graylog2/graylog2-server/issues/2344>`__.
* Do not init available alarm callback types, fetch them explicitly.
  `Graylog2/graylog2-server#2353 <https://github.com/Graylog2/graylog2-server/issues/2353>`__.
* Move custom analyzer into index template.
  `Graylog2/graylog2-server#2354 <https://github.com/Graylog2/graylog2-server/issues/2354>`__.
* Remove automatic private key/certificate generation.
  `Graylog2/graylog2-server#2355 <https://github.com/Graylog2/graylog2-server/issues/2355>`__.
* Improved feedback.
  `Graylog2/graylog2-server#2357 <https://github.com/Graylog2/graylog2-server/issues/2357>`__.
* Longer retention interval for journal tests.
  `Graylog2/graylog2-server#2388 <https://github.com/Graylog2/graylog2-server/issues/2388>`__.
* Remove ``elasticsearch_discovery_zen_ping_multicast_enabled`` setting.
  `Graylog2/graylog2-server#2394 <https://github.com/Graylog2/graylog2-server/issues/2394>`__.
* Fix unrequested refresh of configuration forms/Reset configuration
  forms on cancel.
  `Graylog2/graylog2-server#2399 <https://github.com/Graylog2/graylog2-server/issues/2399>`__.
* Web If: Updating a few dependencies which are safe to update.
  `Graylog2/graylog2-server#2407 <https://github.com/Graylog2/graylog2-server/issues/2407>`__.
* Added Information for journal partitions.
  `Graylog2/graylog2-server#2412 <https://github.com/Graylog2/graylog2-server/issues/2412>`__.
* Fix memory problems with webpack-dev-server in development mode.
  `Graylog2/graylog2-server#2433 <https://github.com/Graylog2/graylog2-server/issues/2433>`__.
* Remove ``_ttl`` in index mapping.
  `Graylog2/graylog2-server#2435 <https://github.com/Graylog2/graylog2-server/issues/2435>`__.
* Add raw message loader.
  `Graylog2/graylog2-server#2438 <https://github.com/Graylog2/graylog2-server/issues/2438>`__.
* Extracting our customized ESLint config into separate module.
  `Graylog2/graylog2-server#2441 <https://github.com/Graylog2/graylog2-server/issues/2441>`__.
* Remove deprecated MongoDB metrics reporter.
  `Graylog2/graylog2-server#2443 <https://github.com/Graylog2/graylog2-server/issues/2443>`__.
* Allow access to MongoDatabase in MongoConnection.
  `Graylog2/graylog2-server#2444 <https://github.com/Graylog2/graylog2-server/issues/2444>`__.
* Add some useful FindBugs plugins.
  `Graylog2/graylog2-server#2447 <https://github.com/Graylog2/graylog2-server/issues/2447>`__.
* Proxies deflector cycle call to make it available on every node.
  `Graylog2/graylog2-server#2448 <https://github.com/Graylog2/graylog2-server/issues/2448>`__.


**Collector sidecar plugin**

* Return updated configuration after changing configuration name
* Prevent crashes when failed to propagate state to the server
* Improve compatibility with old API
* Display collector IP address. `Graylog2/graylog-plugin-collector#9 <https://github.com/Graylog2/graylog-plugin-collector/issues/9>`__
* Ability to clone collector configuration.
  `Graylog2/graylog-plugin-collector#10 <https://github.com/Graylog2/graylog-plugin-collector/issues/10>`__
* NXLog GELF/TLS input should work without cert files.
  `Graylog2/graylog-plugin-collector#13 <https://github.com/Graylog2/graylog-plugin-collector/issues/13>`__
* Add ``tail_files`` option
* Expand verbatim text area if value is present
* Validation improvements
* Add buffer option to NXLog outputs
* Make defaults compatible with Windows hosts
* Add support for Beats. Filebeat, Winlogbeat.
* Beats binaries are bundled with the Collector-Sidecar package
* Improve server side validation. Graylog2/graylog2-server#2247 and Graylog2/graylog-plugin-collector#7.
* Add NXlog GELF TCP and TCP/TLS output
* Add support to clone input, outputs and snippets
* Optionally display collector status information in web interface
* Optionally display log directory listing on status page
* If no node-id is given use the hostname as identification
* Linux distribution is detected and can be used in Snippet template
* Silent install on Windows works now
* Collector log files are now auto-rotated
* Collector processes are supervised and restarted on crashes
* NXlog Inputs and Outputs support free text configuration
* Fix web plugin loading on IE 11


**Pipeline processor plugin**

* Add parse error handler for precompute args failures.
  `Graylog2/graylog-plugin-pipeline-processor#84 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/84>`__,
  `Graylog2/graylog-plugin-pipeline-processor#93 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/93>`__
* Add support for DateTime comparison.
  `Graylog2/graylog-plugin-pipeline-processor#86 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/86>`__,
  `Graylog2/graylog-plugin-pipeline-processor#92 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/92>`__
* Make some small UI changes around RuleHelper.
  `Graylog2/graylog-plugin-pipeline-processor#90 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/90>`__
* Use shared classloader so other plugins can contribute functions.
  `Graylog2/graylog-plugin-pipeline-processor#81 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/81>`__,
  `Graylog2/graylog-plugin-pipeline-processor#94 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/94>`__
* UI improvements. `Graylog2/graylog2-server#2683 <https://github.com/Graylog2/graylog2-server/issues/2683>`__,
  `Graylog2/graylog-plugin-pipeline-processor#83 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/83>`__
* Unregister PipelineInterpreter from event bus 🚌. `Graylog2/graylog-plugin-pipeline-processor#79 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/79>`__
* Use find in the regex function.
  `Graylog2/graylog-plugin-pipeline-processor#35 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/35>`__,
  `Graylog2/graylog-plugin-pipeline-processor#88 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/88>`__
* Dynamic function list.
  `Graylog2/graylog-plugin-pipeline-processor#89 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/89>`__
* Unresolved functions not properly handled.
  `Graylog2/graylog-plugin-pipeline-processor#24 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/24>`__,
  `Graylog2/graylog-plugin-pipeline-processor#25 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/25>`__
* Unwrap JsonNode values.
  `Graylog2/graylog-plugin-pipeline-processor#68 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/68>`__,
  `Graylog2/graylog-plugin-pipeline-processor#72 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/72>`__
* Add optional prefix/suffix to ``set_fields`` functions.
  `Graylog2/graylog-plugin-pipeline-processor#74 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/74>`__,
  `Graylog2/graylog-plugin-pipeline-processor#75 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/75>`__
* Add key-value parsing function.
  `Graylog2/graylog-plugin-pipeline-processor#38 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/38>`__,
  `Graylog2/graylog-plugin-pipeline-processor#77 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/77>`__
* Allow selection of an input ID for the simulation message.
  `Graylog2/graylog2-server#2610 <https://github.com/Graylog2/graylog2-server/issues/2610>`__,
  `Graylog2/graylog2-server#2650 <https://github.com/Graylog2/graylog2-server/issues/2650>`__,
  `Graylog2/graylog-plugin-pipeline-processor#78 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/78>`__
* Support "only named captures" for pipeline grok function.
  `Graylog2/graylog-plugin-pipeline-processor#59 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/59>`__,
  `Graylog2/graylog-plugin-pipeline-processor#65 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/65>`__,
  `Graylog2/graylog2-server#2566 <https://github.com/Graylog2/graylog2-server/issues/2566>`__,
  `Graylog2/graylog2-server#2577 <https://github.com/Graylog2/graylog2-server/issues/2577>`__
* Make conversion functions more consistent.
  `Graylog2/graylog2-server#63 <https://github.com/Graylog2/graylog2-server/issues/63>`__,
  `Graylog2/graylog2-server#64 <https://github.com/Graylog2/graylog2-server/issues/64>`__
* Unescape string literals before using them.
  `Graylog2/graylog-plugin-pipeline-processor#47 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/47>`__
* Add ``rename_field`` function.
  `Graylog2/graylog-plugin-pipeline-processor#50 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/50>`__
* Allow null matcher group values in regex function.
  `Graylog2/graylog-plugin-pipeline-processor#49 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/49>`__
* Fix 500 error during simulation.
  `Graylog2/graylog-plugin-pipeline-processor#51 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/51>`__
* IpAddressConversion caught wrong exception.
  `Graylog2/graylog-plugin-pipeline-processor#32 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/32>`__
* Add syslog-related functions.
  `Graylog2/graylog-plugin-pipeline-processor#19 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/19>`__.
* Add ``concat()`` function.
  `Graylog2/graylog-plugin-pipeline-processor#20 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/20>`__.
* NPE during preProcessArgs using Grok pattern.
  `Graylog2/graylog-plugin-pipeline-processor#24 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/24>`__
  and
  `Graylog2/graylog-plugin-pipeline-processor#26 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/26>`__.
* Streams without connections stay visible.
  `Graylog2/graylog2-server#2322 <https://github.com/Graylog2/graylog2-server/issues/2322>`__.
* Add pipeline simulator.
  `Graylog2/graylog-plugin-pipeline-processor#34 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/34>`__,
  `Graylog2/graylog-plugin-pipeline-processor#36 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/36>`__
  and `Graylog2/graylog-plugin-pipeline-processor#42 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/42>`__.
* Fix page size in function list. `Graylog2/graylog-plugin-pipeline-processor#97 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/97>`__


Graylog 2.0.3
=============

Released: 2016-06-20

https://www.graylog.org/blog/58-graylog-v2-0-3-released

**Improvements**

* Make Message#getStreamIds() more reliable. `Graylog2/graylog2-server#2378 <https://github.com/Graylog2/graylog2-server/pull/2378>`_
* Disabling a configured proxy for requests to localhost/127.0.0.1/::1. `Graylog2/graylog2-server#2305 <https://github.com/Graylog2/graylog2-server/pull/2305>`_

**Bug fixes**

* Update search query on auto refresh `Graylog2/graylog2-server#2385 <https://github.com/Graylog2/graylog2-server/pull/2385>`_ `Graylog2/graylog2-server#2379 <https://github.com/Graylog2/graylog2-server/pull/2379>`_
* Fix permission checks for non admin users `Graylog2/graylog2-server#2366 <https://github.com/Graylog2/graylog2-server/pull/2366>`_ `Graylog2/graylog2-server#2358 <https://github.com/Graylog2/graylog2-server/pull/2358>`_
* Fix display of total count of indices. `Graylog2/graylog2-server#2365 <https://github.com/Graylog2/graylog2-server/pull/2365>`_ `Graylog2/graylog2-server#2359 <https://github.com/Graylog2/graylog2-server/pull/2359>`_
* Fix base URI for API documentation `Graylog2/graylog2-server#2362 <https://github.com/Graylog2/graylog2-server/pull/2362>`_ `Graylog2/graylog2-server#2360 <https://github.com/Graylog2/graylog2-server/pull/2360>`_
* Fix link to API Browser on Node pages `Graylog2/graylog2-server#2361 <https://github.com/Graylog2/graylog2-server/pull/2361>`_ `Graylog2/graylog2-server#2360 <https://github.com/Graylog2/graylog2-server/pull/2360>`_
* Calculate keyword from and to values on the fly `Graylog2/graylog2-server#2335 <https://github.com/Graylog2/graylog2-server/pull/2335>`_ `Graylog2/graylog2-server#2301 <https://github.com/Graylog2/graylog2-server/pull/2301>`_
* Make MemoryAppender thread-safe `Graylog2/graylog2-server#2307 <https://github.com/Graylog2/graylog2-server/pull/2307>`_ `Graylog2/graylog2-server#2302 <https://github.com/Graylog2/graylog2-server/pull/2302>`_
* Use right metrics to display buffer usage `Graylog2/graylog2-server#2300 <https://github.com/Graylog2/graylog2-server/pull/2300>`_ `Graylog2/graylog2-server#2299 <https://github.com/Graylog2/graylog2-server/pull/2299>`_
* Check if props actually contain configuration fields before copying them `Graylog2/graylog2-server#2298 <https://github.com/Graylog2/graylog2-server/pull/2298>`_ `Graylog2/graylog2-server#2297 <https://github.com/Graylog2/graylog2-server/pull/2297>`_


Graylog 2.0.2
=============

Released: 2016-05-27

https://www.graylog.org/blog/57-graylog-v2-0-2-released

**Improvements**

* Improved user form. `Graylog2/graylog2-server#2261 <https://github.com/Graylog2/graylog2-server/issues/2261>`_
* Improved logging of plugin list on server startup. `Graylog2/graylog2-server#2290 <https://github.com/Graylog2/graylog2-server/issues/2290>`_
* Forbid empty passwords when using LDAP. `Graylog2/graylog2-server#2214 <https://github.com/Graylog2/graylog2-server/issues/2214>`_ `Graylog2/graylog2-server#2283 <https://github.com/Graylog2/graylog2-server/issues/2283>`_
* Improved metrics page. `Graylog2/graylog2-server#2250 <https://github.com/Graylog2/graylog2-server/issues/2250>`_ `Graylog2/graylog2-server#2255 <https://github.com/Graylog2/graylog2-server/issues/2255>`_
* Improved search histogram resolution auto selection. `Graylog2/graylog2-server#2148 <https://github.com/Graylog2/graylog2-server/issues/2148>`_ `Graylog2/graylog2-server#2289 <https://github.com/Graylog2/graylog2-server/issues/2289>`_
* Improved cluster overview page. `Graylog2/graylog2-server#2291 <https://github.com/Graylog2/graylog2-server/issues/2291>`_

**Bug Fixes**

* Fixed concurrency issue with Drools. `Graylog2/graylog2-server#2119 <https://github.com/Graylog2/graylog2-server/issues/2119>`_ `Graylog2/graylog2-server#2188 <https://github.com/Graylog2/graylog2-server/issues/2188>`_ `Graylog2/graylog2-server#2231 <https://github.com/Graylog2/graylog2-server/issues/2231>`_
* Fixed problems with Internet Explorer. `Graylog2/graylog2-server#2246 <https://github.com/Graylog2/graylog2-server/issues/2246>`_
* Fixed issues with old dashboards. `Graylog2/graylog2-server#2262 <https://github.com/Graylog2/graylog2-server/issues/2262>`_ `Graylog2/graylog2-server#2163 <https://github.com/Graylog2/graylog2-server/issues/2163>`_
* Fixed changing log levels via REST API. `Graylog2/graylog2-server#1904 <https://github.com/Graylog2/graylog2-server/issues/1904>`_ `Graylog2/graylog2-server#2277 <https://github.com/Graylog2/graylog2-server/issues/2277>`_
* Fixed plugin inter-dependencies by using one class loader for all plugins. `Graylog2/graylog2-server#2280 <https://github.com/Graylog2/graylog2-server/issues/2280>`_

**Plugin: Pipeline Processor**

* Add syslog related rule functions. `Graylog2/graylog-plugin-pipeline-processor#19 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/19>`_
* Add concat rule functions. `Graylog2/graylog-plugin-pipeline-processor#20 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/20>`_
* Fixed problem with IP address function. `Graylog2/graylog-plugin-pipeline-processor#28 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/28>`_ `Graylog2/graylog-plugin-pipeline-processor#32 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/32>`_
* Properly unescape strings in raw literals. `Graylog2/graylog-plugin-pipeline-processor#30 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/30>`_ `Graylog2/graylog-plugin-pipeline-processor#31 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/31>`_


Graylog 2.0.1
=============

Released: 2016-05-11

https://www.graylog.org/blog/56-graylog-v2-0-1-released

**Improvements**

* Improved session handling. `Graylog2/graylog2-server#2157 <https://github.com/Graylog2/graylog2-server/issues/2157>`_
* Included UPGRADING file in the build artifact. `Graylog2/graylog2-server#2170 <https://github.com/Graylog2/graylog2-server/issues/2170>`_
* Added rotation/retention settings back to the config file. `Graylog2/graylog2-server#2181 <https://github.com/Graylog2/graylog2-server/issues/2181>`_
* Improved proxy setup configuration settings. `Graylog2/graylog2-server#2156 <https://github.com/Graylog2/graylog2-server/issues/2156>`_
* Forbid wildcard host in `rest_transport_uri`. `Graylog2/graylog2-server#2205 <https://github.com/Graylog2/graylog2-server/issues/2205>`_
* Improved robustness for unreachable nodes. `Graylog2/graylog2-server#2206 <https://github.com/Graylog2/graylog2-server/issues/2206>`_
* Use a more lightweight API to get all index names and aliases. `Graylog2/graylog2-server#2194 <https://github.com/Graylog2/graylog2-server/issues/2194>`_ `Graylog2/graylog2-server#2210 <https://github.com/Graylog2/graylog2-server/issues/2210>`_

**Bug Fixes**

* Fixed some documentation links.
* Fixed inverted stream rules. `Graylog2/graylog2-server#2160 <https://github.com/Graylog2/graylog2-server/issues/2160>`_ `Graylog2/graylog2-server#2172 <https://github.com/Graylog2/graylog2-server/issues/2172>`_
* Fixed swallowed LDAP authentication exception. `Graylog2/graylog2-server#2176 <https://github.com/Graylog2/graylog2-server/issues/2176>`_ `Graylog2/graylog2-server#2178 <https://github.com/Graylog2/graylog2-server/issues/2178>`_
* Fixed insecure handling of PID files. Thanks `@juergenhoetzel <https://github.com/juergenhoetzel>`_! `Graylog2/graylog2-server#2174 <https://github.com/Graylog2/graylog2-server/issues/2174>`_
* Fixed alert conditions that have been created in Graylog 1.x. `Graylog2/graylog2-server#2169 <https://github.com/Graylog2/graylog2-server/issues/2169>`_ `Graylog2/graylog2-server#2182 <https://github.com/Graylog2/graylog2-server/issues/2182>`_
* Fixed setting of application context. `Graylog2/graylog2-server#2191 <https://github.com/Graylog2/graylog2-server/issues/2191>`_ `Graylog2/graylog2-server#2208 <https://github.com/Graylog2/graylog2-server/issues/2208>`_
* Fixed setting of custom Elasticsearch analyzer. `Graylog2/graylog2-server#2209 <https://github.com/Graylog2/graylog2-server/issues/2209>`_
* Fixed masking of password config values in the web interface. `Graylog2/graylog2-server#2198 <https://github.com/Graylog2/graylog2-server/issues/2198>`_ `Graylog2/graylog2-server#2203 <https://github.com/Graylog2/graylog2-server/issues/2203>`_
* Fixed URL handling. `Graylog2/graylog2-server#2200 <https://github.com/Graylog2/graylog2-server/issues/2200>`_ `Graylog2/graylog2-server#2213 <https://github.com/Graylog2/graylog2-server/issues/2213>`_

**Plugin: Collector**

* Rotate nxlog logfiles once a day by default.
* Add GELF TCP output for nxlog.


Graylog 2.0.0
=============

Released: 2016-04-27

https://www.graylog.org/blog/55-announcing-graylog-v2-0-ga

.. note:: Please make sure to read the :ref:`Upgrade Guide <upgrade_notes_graylog-2.0>`
          before upgrading to Graylog 2.0. There are breaking changes!

**Feature Highlights**

See the release announcement for details on the new features.

* Web interface no longer a separate process
* Support for Elasticsearch 2.x
* Live tail support
* Message Processing Pipeline
* Map Widget Plugin
* Collector Sidecar
* Streams filter UI
* Search for surrounding messages
* Query range limit
* Configurable query time ranges
* Archiving (commercial feature)

**Bug Fixes**

There have been lots of bug fixes since the 1.3 releases. We only list the ones that we worked on since the 2.0 alpha phase.

* Fixed issues with search page pagination and number of returned results: `Graylog2/graylog2-server#1759 <https://github.com/Graylog2/graylog2-server/issues/1759>`_, `Graylog2/graylog2-server#1775 <https://github.com/Graylog2/graylog2-server/issues/1775>`_, and `Graylog2/graylog2-server#1802 <https://github.com/Graylog2/graylog2-server/issues/1802>`_
* Avoid creating MongoDB collection multiple times: `Graylog2/graylog2-server#1747 <https://github.com/Graylog2/graylog2-server/issues/1747>`_
* Removed number of connected nodes in login page: `Graylog2/graylog2-server#1732 <https://github.com/Graylog2/graylog2-server/issues/1732>`_
* Fix dynamic search result histogram resolution: `Graylog2/graylog2-server#1764 <https://github.com/Graylog2/graylog2-server/issues/1764>`_
* Show overlay in Graylog web interface when Graylog server is not available: `Graylog2/graylog2-server#1762 <https://github.com/Graylog2/graylog2-server/issues/1762>`_
* Fix metric types: `Graylog2/graylog2-server#1784 <https://github.com/Graylog2/graylog2-server/issues/1784>`_
* Only load all metrics on demand: `Graylog2/graylog2-server#1782 <https://github.com/Graylog2/graylog2-server/issues/1782>`_
* Activate search refresh after selecting a refresh interval: `Graylog2/graylog2-server#1796 <https://github.com/Graylog2/graylog2-server/issues/1796>`_
* Fix circular dependencies: `Graylog2/graylog2-server#1789 <https://github.com/Graylog2/graylog2-server/issues/1789>`_
* Only render input forms when input type is available: `Graylog2/graylog2-server#1798 <https://github.com/Graylog2/graylog2-server/issues/1798>`_
* Document web interface configuration settings in graylog.conf. `Graylog2/graylog2-server#1777 <https://github.com/Graylog2/graylog2-server/issues/1777>`_
* Fix roles link to documentation. `Graylog2/graylog2-server#1805 <https://github.com/Graylog2/graylog2-server/issues/1805>`_
* Fix issue with field graphs. `Graylog2/graylog2-server#1811 <https://github.com/Graylog2/graylog2-server/issues/1811>`_
* Fix search result pagination. `Graylog2/graylog2-server#1812 <https://github.com/Graylog2/graylog2-server/issues/1812>`_
* Fix add to query button on quick values. `Graylog2/graylog2-server#1797 <https://github.com/Graylog2/graylog2-server/issues/1797>`_
* Fix URL to Graylog marketplace on content pack export page. `Graylog2/graylog2-server#1817 <https://github.com/Graylog2/graylog2-server/issues/1817>`_
* Fix elasticsearch node name for the Graylog client node. `Graylog2/graylog2-server#1814 <https://github.com/Graylog2/graylog2-server/issues/1814>`_ and `Graylog2/graylog2-server#1820 <https://github.com/Graylog2/graylog2-server/issues/1820>`_
* Fix widget sorting for dashboards.
* Use _ as default key separator in JSON Extractor. `Graylog2/graylog2-server#1841 <https://github.com/Graylog2/graylog2-server/issues/1841>`_
* Clarify that Graylog Collector needs access to rest_listen_uri. `Graylog2/graylog2-server#1847 <https://github.com/Graylog2/graylog2-server/issues/1847>`_
* Fix potential memory leak in GELF UDP handler. `Graylog2/graylog2-server#1857 <https://github.com/Graylog2/graylog2-server/issues/1857>`_ `Graylog2/graylog2-server#1862 <https://github.com/Graylog2/graylog2-server/issues/1862>`_
* Fix user with correct permissions not allowed to view stream: `Graylog2/graylog2-server#1887 <https://github.com/Graylog2/graylog2-server/issues/1887>`_, `Graylog2/graylog2-server#1902 <https://github.com/Graylog2/graylog2-server/issues/1902>`_
* Make pattern to check Graylog-managed indices stricter: `Graylog2/graylog2-server#1882 <https://github.com/Graylog2/graylog2-server/issues/1882>`_, `Graylog2/graylog2-server#1888 <https://github.com/Graylog2/graylog2-server/issues/1888>`_
* Fix throughput counter: `Graylog2/graylog2-server#1876 <https://github.com/Graylog2/graylog2-server/issues/1876>`_
* Fix replay search link in dashboards: `Graylog2/graylog2-server#1835 <https://github.com/Graylog2/graylog2-server/issues/1835>`_
* Render server unavailable page more reliably: `Graylog2/graylog2-server#1867 <https://github.com/Graylog2/graylog2-server/issues/1867>`_
* Fix build issue with maven. `Graylog2/graylog2-server#1907 <https://github.com/Graylog2/graylog2-server/issues/1907>`_ (Thanks @gitfrederic)
* Fix username in REST API access logs. `Graylog2/graylog2-server#1815 <https://github.com/Graylog2/graylog2-server/issues/1815>`_ `Graylog2/graylog2-server#1918 <https://github.com/Graylog2/graylog2-server/issues/1918>`_ (Thanks @mikkolehtisalo)
* Fix alert annotations in message histogram. `Graylog2/graylog2-server#1921 <https://github.com/Graylog2/graylog2-server/issues/1921>`_
* Fix problem with automatic input form reload. `Graylog2/graylog2-server#1870 <https://github.com/Graylog2/graylog2-server/issues/1870>`_ `Graylog2/graylog2-server#1929 <https://github.com/Graylog2/graylog2-server/issues/1929>`_
* Fix asset caching. `Graylog2/graylog2-server#1924 <https://github.com/Graylog2/graylog2-server/issues/1924>`_ `Graylog2/graylog2-server#1930 <https://github.com/Graylog2/graylog2-server/issues/1930>`_
* Fix issue with cursor jumps in the search bar. `Graylog2/graylog2-server#1911 <https://github.com/Graylog2/graylog2-server/issues/1911>`_
* Fix import of Graylog 1.x extractors. `Graylog2/graylog2-server#1831 <https://github.com/Graylog2/graylog2-server/issues/1831>`_ `Graylog2/graylog2-server#1937 <https://github.com/Graylog2/graylog2-server/issues/1937>`_
* Field charts will now use the stream and time range of the current search. `Graylog2/graylog2-server#1785 <https://github.com/Graylog2/graylog2-server/issues/1785>`_ `Graylog2/graylog2-web-interface#1620 <https://github.com/Graylog2/graylog2-web-interface/issues/1620>`_ `Graylog2/graylog2-web-interface#1618 <https://github.com/Graylog2/graylog2-web-interface/issues/1618>`_ `Graylog2/graylog2-web-interface#1485 <https://github.com/Graylog2/graylog2-web-interface/issues/1485>`_ `Graylog2/graylog2-server#1938 <https://github.com/Graylog2/graylog2-server/issues/1938>`_
* Improve browser validations. `Graylog2/graylog2-server#1885 <https://github.com/Graylog2/graylog2-server/issues/1885>`_
* Fix Internet Explorer support. `Graylog2/graylog2-server#1935 <https://github.com/Graylog2/graylog2-server/issues/1935>`_
* Fix issue where a user was logged out when accessing an unauthorized resource. `Graylog2/graylog2-server#1944 <https://github.com/Graylog2/graylog2-server/issues/1944>`_
* Fix issue with surrounding search. `Graylog2/graylog2-server#1946 <https://github.com/Graylog2/graylog2-server/issues/1946>`_
* Fix problem deleting dashboard widget where the plugin got removed. `Graylog2/graylog2-server#1943 <https://github.com/Graylog2/graylog2-server/issues/1943>`_
* Fix permission issue on user edit page. `Graylog2/graylog2-server#1964 <https://github.com/Graylog2/graylog2-server/issues/1964>`_
* Fix histogram time range selection via mouse. `Graylog2/graylog2-server#1895 <https://github.com/Graylog2/graylog2-server/issues/1895>`_
* Fix problems with duplicate Reflux store instances. `Graylog2/graylog2-server#1967 <https://github.com/Graylog2/graylog2-server/issues/1967>`_
* Create PID file earlier in the startup process. `Graylog2/graylog2-server#1969 <https://github.com/Graylog2/graylog2-server/issues/1969>`_ `Graylog2/graylog2-server#1978 <https://github.com/Graylog2/graylog2-server/issues/1978>`_
* Fix content type detection for static assets. `Graylog2/graylog2-server#1982 <https://github.com/Graylog2/graylog2-server/issues/1982>`_ `Graylog2/graylog2-server#1983 <https://github.com/Graylog2/graylog2-server/issues/1983>`_
* Fix caching of static assets. `Graylog2/graylog2-server#1982 <https://github.com/Graylog2/graylog2-server/issues/1982>`_ `Graylog2/graylog2-server#1983 <https://github.com/Graylog2/graylog2-server/issues/1983>`_
* Show error message on malformed search query. `Graylog2/graylog2-server#1896 <https://github.com/Graylog2/graylog2-server/issues/1896>`_
* Fix parsing of GELF chunks. `Graylog2/graylog2-server#1986 <https://github.com/Graylog2/graylog2-server/issues/1986>`_
* Fix problems editing reader users profile. `Graylog2/graylog2-server#1984 <https://github.com/Graylog2/graylog2-server/issues/1984>`_ `Graylog2/graylog2-server#1987 <https://github.com/Graylog2/graylog2-server/issues/1987>`_
* Fix problem with lost extractors and static fields on input update. `Graylog2/graylog2-server#1988 <https://github.com/Graylog2/graylog2-server/issues/1988>`_ `Graylog2/graylog2-server#1923 <https://github.com/Graylog2/graylog2-server/issues/1923>`_
* Improve fetching cluster metrics to avoid multiple HTTP calls. `Graylog2/graylog2-server#1974 <https://github.com/Graylog2/graylog2-server/issues/1974>`_ `Graylog2/graylog2-server#1990 <https://github.com/Graylog2/graylog2-server/issues/1990>`_
* Properly handle empty messages. `Graylog2/graylog2-server#1584 <https://github.com/Graylog2/graylog2-server/issues/1584>`_ `Graylog2/graylog2-server#1995 <https://github.com/Graylog2/graylog2-server/issues/1995>`_
* Add 100-Continue support to HTTP inputs. `Graylog2/graylog2-server#1939 <https://github.com/Graylog2/graylog2-server/issues/1939>`_ `Graylog2/graylog2-server#1998 <https://github.com/Graylog2/graylog2-server/issues/1998>`_
* Fix setting dashboard as start page for reader users. `Graylog2/graylog2-server#2005 <https://github.com/Graylog2/graylog2-server/issues/2005>`_
* Allow dots (".") in LDAP group name mappings. `Graylog2/graylog2-server#1458 <https://github.com/Graylog2/graylog2-server/issues/1458>`_ `Graylog2/graylog2-server#2009 <https://github.com/Graylog2/graylog2-server/issues/2009>`_
* Update user edit form when username changes. `Graylog2/graylog2-server#2000 <https://github.com/Graylog2/graylog2-server/issues/2000>`_
* Fix issue with permissions in user form. `Graylog2/graylog2-server#1989 <https://github.com/Graylog2/graylog2-server/issues/1989>`_
* Update extractor example when message is loaded. `Graylog2/graylog2-server#1957 <https://github.com/Graylog2/graylog2-server/issues/1957>`_ `Graylog2/graylog2-server#2013 <https://github.com/Graylog2/graylog2-server/issues/2013>`_
* Disable log4j2 shutdown hooks to avoid exception on shutdown. `Graylog2/graylog2-server#1795 <https://github.com/Graylog2/graylog2-server/issues/1795>`_ `Graylog2/graylog2-server#2015 <https://github.com/Graylog2/graylog2-server/issues/2015>`_
* Fix styling issue with map widget. `Graylog2/graylog2-server#2003 <https://github.com/Graylog2/graylog2-server/issues/2003>`_
* Fix openstreetmap URL in map widget. `Graylog2/graylog2-server#1994 <https://github.com/Graylog2/graylog2-server/issues/1994>`_
* Fix problem with collector heartbeat validation. `Graylog2/graylog2-server#2002 <https://github.com/Graylog2/graylog2-server/issues/2002>`_ `Graylog2/graylog2-web-interface#1726 <https://github.com/Graylog2/graylog2-web-interface/issues/1726>`_ `Graylog2/graylog-plugin-collector#3 <https://github.com/Graylog2/graylog-plugin-collector/issues/3>`_
* Remove unused command line parameters. `Graylog2/graylog2-server#1977 <https://github.com/Graylog2/graylog2-server/issues/1977>`_
* Fixed timezone issues for date time processing in JSON parser. `Graylog2/graylog2-server#2007 <https://github.com/Graylog2/graylog2-server/issues/2007>`_
* Fixed JavaScript error with field truncation. `Graylog2/graylog2-server#2025 <https://github.com/Graylog2/graylog2-server/issues/2025>`_
* Fixed redirection if user is not authorized. `Graylog2/graylog2-server#1985 <https://github.com/Graylog2/graylog2-server/issues/1985>`_ `Graylog2/graylog2-server#2024 <https://github.com/Graylog2/graylog2-server/issues/2024>`_
* Made changing the sort order in search result table work again. `Graylog2/graylog2-server#2028 <https://github.com/Graylog2/graylog2-server/issues/2028>`_ `Graylog2/graylog2-server#2031 <https://github.com/Graylog2/graylog2-server/issues/2031>`_
* Performance improvements on "System/Indices" page. `Graylog2/graylog2-server#2017 <https://github.com/Graylog2/graylog2-server/issues/2017>`_
* Fixed content-type settings for static assets. `Graylog2/graylog2-server#2052 <https://github.com/Graylog2/graylog2-server/issues/2052>`_
* Fixed return code for invalid input IDs. `Graylog2/graylog2-server#1718 <https://github.com/Graylog2/graylog2-server/issues/1718>`_ `Graylog2/graylog2-server#1767 <https://github.com/Graylog2/graylog2-server/issues/1767>`_
* Improved field analyzer UI. `Graylog2/graylog2-server#2022 <https://github.com/Graylog2/graylog2-server/issues/2022>`_ `Graylog2/graylog2-server#2023 <https://github.com/Graylog2/graylog2-server/issues/2023>`_
* Fixed login with LDAP user. `Graylog2/graylog2-server#2045 <https://github.com/Graylog2/graylog2-server/issues/2045>`_ `Graylog2/graylog2-server#2046 <https://github.com/Graylog2/graylog2-server/issues/2046>`_ `Graylog2/graylog2-server#2069 <https://github.com/Graylog2/graylog2-server/issues/2069>`_
* Fixed issue with bad message timestamps to avoid data loss. `Graylog2/graylog2-server#2064 <https://github.com/Graylog2/graylog2-server/issues/2064>`_ `Graylog2/graylog2-server#2065 <https://github.com/Graylog2/graylog2-server/issues/2065>`_
* Improved handling of Elasticsearch indices. `Graylog2/graylog2-server#2058 <https://github.com/Graylog2/graylog2-server/issues/2058>`_ `Graylog2/graylog2-server#2062 <https://github.com/Graylog2/graylog2-server/issues/2062>`_
* Extractor form improvements for JSON and Grok extractors. `Graylog2/graylog2-server#1883 <https://github.com/Graylog2/graylog2-server/issues/1883>`_ `Graylog2/graylog2-server#2020 <https://github.com/Graylog2/graylog2-server/issues/2020>`_
* Used search refresh to refresh field statistics. `Graylog2/graylog2-server#1961 <https://github.com/Graylog2/graylog2-server/issues/1961>`_ `Graylog2/graylog2-server#2068 <https://github.com/Graylog2/graylog2-server/issues/2068>`_
* Fixed clicking zoom button in quick values. `Graylog2/graylog2-server#2040 <https://github.com/Graylog2/graylog2-server/issues/2040>`_ `Graylog2/graylog2-server#2067 <https://github.com/Graylog2/graylog2-server/issues/2067>`_
* Web interface styling improvements.
* Replaced . in message field keys with a _ for ES 2.x compatibility. `Graylog2/graylog2-server#2078 <https://github.com/Graylog2/graylog2-server/issues/2078>`_
* Fixed unprocessed journal messages reload in node list. `Graylog2/graylog2-server#2083 <https://github.com/Graylog2/graylog2-server/issues/2083>`_
* Fixed problems with stale sessions on the login page. `Graylog2/graylog2-server#2073 <https://github.com/Graylog2/graylog2-server/issues/2073>`_ `Graylog2/graylog2-server#2059 <https://github.com/Graylog2/graylog2-server/issues/2059>`_ `Graylog2/graylog2-server#1891 <https://github.com/Graylog2/graylog2-server/issues/1891>`_
* Fixed issue with index retention strategies. `Graylog2/graylog2-server#2100 <https://github.com/Graylog2/graylog2-server/issues/2100>`_
* Fixed password change form. `Graylog2/graylog2-server#2103 <https://github.com/Graylog2/graylog2-server/issues/2103>`_ `Graylog2/graylog2-server#2105 <https://github.com/Graylog2/graylog2-server/issues/2105>`_
* Do not show search refresh controls on the sources page. `Graylog2/graylog2-server#1821 <https://github.com/Graylog2/graylog2-server/issues/1821>`_ `Graylog2/graylog2-server#2104 <https://github.com/Graylog2/graylog2-server/issues/2104>`_
* Wait for index being available before calculating index range. `Graylog2/graylog2-server#2061 <https://github.com/Graylog2/graylog2-server/issues/2061>`_ `Graylog2/graylog2-server#2098 <https://github.com/Graylog2/graylog2-server/issues/2098>`_
* Fixed issue with sorting extractors. `Graylog2/graylog2-server#2086 <https://github.com/Graylog2/graylog2-server/issues/2086>`_ `Graylog2/graylog2-server#2088 <https://github.com/Graylog2/graylog2-server/issues/2088>`_
* Improve DataTable UI component. `Graylog2/graylog-plugin-pipeline-processor#11 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/11>`_
* Move TCP keepalive setting into AbstractTcpTransport to simplify input development. `Graylog2/graylog2-server#2112 <https://github.com/Graylog2/graylog2-server/issues/2112>`_
* Fixed issue with Elasticsearch index template update. `Graylog2/graylog2-server#2089 <https://github.com/Graylog2/graylog2-server/issues/2089>`_ `Graylog2/graylog2-server#2097 <https://github.com/Graylog2/graylog2-server/issues/2097>`_
* Ensure that tmpDir is writable when generating self-signed certs in TCP transports. `Graylog2/graylog2-server#2054 <https://github.com/Graylog2/graylog2-server/issues/2054>`_ `Graylog2/graylog2-server#2096 <https://github.com/Graylog2/graylog2-server/issues/2096>`_
* Fixed default values for plugin configuration forms. `Graylog2/graylog2-server#2108 <https://github.com/Graylog2/graylog2-server/issues/2108>`_ `Graylog2/graylog2-server#2114 <https://github.com/Graylog2/graylog2-server/issues/2114>`_
* Dashboard usability improvements. `Graylog2/graylog2-server#2093 <https://github.com/Graylog2/graylog2-server/issues/2093>`_
* Include default values in pluggable entities forms. `Graylog2/graylog2-server#2122 <https://github.com/Graylog2/graylog2-server/issues/2122>`_
* Ignore empty authentication tokens in LdapUserAuthenticator. `Graylog2/graylog2-server#2123 <https://github.com/Graylog2/graylog2-server/issues/2123>`_
* Add REST API authentication and permissions. `Graylog2/graylog-plugin-pipeline-processor#15 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/15>`_
* Require authenticated user in REST resources. `Graylog2/graylog-plugin-pipeline-processor#14 <https://github.com/Graylog2/graylog-plugin-pipeline-processor/issues/14>`_
* Lots of UI improvements in the web interface. `Graylog2/graylog2-server#2136 <https://github.com/Graylog2/graylog2-server/issues/2136>`_
* Fixed link to REST API browser. `Graylog2/graylog2-server#2133 <https://github.com/Graylog2/graylog2-server/issues/2133>`_
* Fixed CSV export skipping first chunk. `Graylog2/graylog2-server#2128 <https://github.com/Graylog2/graylog2-server/issues/2128>`_
* Fixed updating content packs. `Graylog2/graylog2-server#2138 <https://github.com/Graylog2/graylog2-server/issues/2138>`_ `Graylog2/graylog2-server#2141 <https://github.com/Graylog2/graylog2-server/issues/2141>`_
* Added missing 404 page. `Graylog2/graylog2-server#2139 <https://github.com/Graylog2/graylog2-server/issues/2139>`_


Graylog 1.3.4
=============

Released: 2016-03-16

https://www.graylog.org/blog/49-graylog-1-3-4-is-now-available

* Fix security issue which allowed redirecting users to arbitrary sites on login `Graylog2/graylog2-web-interface#1729 <https://github.com/Graylog2/graylog2-web-interface/pull/1729>`_
* Fix issue with time-based index rotation strategy `Graylog2/graylog2-server#725 <https://github.com/Graylog2/graylog2-server/issues/725>`_ `Graylog2/graylog2-server#1693 <https://github.com/Graylog2/graylog2-server/pull/1693>`_
* Fix issue with ``IndexFailureServiceImpl`` `Graylog2/graylog2-server#1747 <https://github.com/Graylog2/graylog2-server/issues/1747>`_
* Add default Content-Type to ``GettingStartedResource`` `Graylog2/graylog2-server#1700 <https://github.com/Graylog2/graylog2-server/issues/1700>`_
* Improve OS platform detection `Graylog2/graylog2-server#1737 <https://github.com/Graylog2/graylog2-server/issues/1737>`_
* Add prefixes ``GRAYLOG_`` (environment variables) and  ``graylog.`` (system properties) for overriding configuration settings `Graylog2/graylog2-server@48ed88d <https://github.com/Graylog2/graylog2-server/commit/48ed88d4a7897152f7daa16f0d77e03b824d7b48>`_
* Fix URL to Graylog Marketplace on Extractor/Content Pack pages `Graylog2/graylog2-server#1817 <https://github.com/Graylog2/graylog2-server/issues/1817>`_
* Use monospace font on message values `Graylog2/graylog2-web-interface@3cce368 <https://github.com/Graylog2/graylog2-web-interface/commit/3cce368bd7360c0e95dc0b635cb99f0a47daa6ac>`_


Graylog 1.3.3
=============

Released: 2016-01-14

https://www.graylog.org/graylog-1-3-3-is-now-available/

* Absolute and relative time spans give different results `Graylog2/graylog2-server#1572 <https://github.com/Graylog2/graylog2-server/issues/1572>`_ `Graylog2/graylog2-server#1463 <https://github.com/Graylog2/graylog2-server/issues/1463>`_ `Graylog2/graylog2-server#1672 <https://github.com/Graylog2/graylog2-server/issues/1672>`_ `Graylog2/graylog2-server#1679 <https://github.com/Graylog2/graylog2-server/pull/1679>`_
* Search result count widget not caching `Graylog2/graylog2-server#1640 <https://github.com/Graylog2/graylog2-server/issues/1640>`_ `Graylog2/graylog2-server#1681 <https://github.com/Graylog2/graylog2-server/pull/1681>`_
* Field Value Condition Alert, does not permit decimal values `Graylog2/graylog2-server#1657 <https://github.com/Graylog2/graylog2-server/issues/1657>`_
* Correctly handle null values in nested structures in JsonExtractor `Graylog2/graylog2-server#1676 <https://github.com/Graylog2/graylog2-server/issues/1676>`_ `Graylog2/graylog2-server#1677 <https://github.com/Graylog2/graylog2-server/pull/1677>`_
* Add ``Content-Type`` and ``X-Graylog2-No-Session-Extension`` to CORS headers `Graylog2/graylog2-server#1682 <https://github.com/Graylog2/graylog2-server/issues/1682>`_ `Graylog2/graylog2-server#1685 <https://github.com/Graylog2/graylog2-server/pull/1685>`_
* Discard Message Output `Graylog2/graylog2-server#1688 <https://github.com/Graylog2/graylog2-server/pull/1688>`_


Graylog 1.3.2
=============

Released: 2015-12-18

https://www.graylog.org/graylog-1-3-2-is-now-available/

* Deserializing a blacklist filter (``FilterDescription``) leads to ``StackOverflowError`` `Graylog2/graylog2-server#1641 <https://github.com/Graylog2/graylog2-server/issues/1641>`_


Graylog 1.3.1
=============

Released: 2015-12-17

https://www.graylog.org/graylog-1-3-1-is-now-available/

* Add option to AMQP transports to bind the queue to the exchange `Graylog2/graylog2-server#1599 <https://github.com/Graylog2/graylog2-server/issues/1599>`_ `Graylog2/graylog2-server#1633 <https://github.com/Graylog2/graylog2-server/pull/1633>`_
* Install a Graylog index template instead of set mappings on index creation `Graylog2/graylog2-server#1624 <https://github.com/Graylog2/graylog2-server/issues/1624>`_ `Graylog2/graylog2-server#1628 <https://github.com/Graylog2/graylog2-server/pull/1628>`_


Graylog 1.3.0
=============

Released: 2015-12-09

https://www.graylog.org/graylog-1-3-ga-is-ready/

* Allow index range calculation for a single index. `Graylog2/graylog2-server#1451 <https://github.com/Graylog2/graylog2-server/issues/1451>`_ `Graylog2/graylog2-server#1455 <https://github.com/Graylog2/graylog2-server/issues/1455>`_
* Performance improvements for index ranges.
* Make internal server logs accessible via REST API. `Graylog2/graylog2-server#1452 <https://github.com/Graylog2/graylog2-server/issues/1452>`_
* Make specific configuration values accessible via REST API. `Graylog2/graylog2-server#1484 <https://github.com/Graylog2/graylog2-server/issues/1484>`_
* Added Replace Extractor. `Graylog2/graylog2-server#1485 <https://github.com/Graylog2/graylog2-server/issues/1485>`_
* Added a default set of Grok patterns. `Graylog2/graylog2-server#1495 <https://github.com/Graylog2/graylog2-server/issues/1495>`_
* Log operating system details on server startup. `Graylog2/graylog2-server#1244 <https://github.com/Graylog2/graylog2-server/issues/1244>`_ `Graylog2/graylog2-server#1553 <https://github.com/Graylog2/graylog2-server/issues/1553>`_
* Allow reader users to set a dashboard as start page. `Graylog2/graylog2-web-interface#1681 <https://github.com/Graylog2/graylog2-web-interface/issues/1681>`_
* Auto content pack loader – download and install content packs automatically
* Appliance pre-configured for log ingestion and analysis
* Show a getting started guide on first install. `Graylog2/graylog2-web-interface#1662 <https://github.com/Graylog2/graylog2-web-interface/issues/1662>`_
* Include role permissions in “/roles/{rolename}/members” REST API endpoint. `Graylog2/graylog2-server#1549 <https://github.com/Graylog2/graylog2-server/issues/1549>`_
* Fixed NullPointerException in GELF output. `Graylog2/graylog2-server#1538 <https://github.com/Graylog2/graylog2-server/issues/1538>`_
* Fixed NullPointerException in GELF input handling. `Graylog2/graylog2-server#1544 <https://github.com/Graylog2/graylog2-server/issues/1544>`_
* Use the root user’s timezone for LDAP users by default. `Graylog2/graylog2-server#1000 <https://github.com/Graylog2/graylog2-server/issues/1000>`_ `Graylog2/graylog2-server#1554 <https://github.com/Graylog2/graylog2-server/issues/1554>`_
* Fix display of JSON messages. `Graylog2/graylog2-web-interface#1686 <https://github.com/Graylog2/graylog2-web-interface/issues/1686>`_
* Improve search robustness with missing Elasticsearch indices. `Graylog2/graylog2-server#1547 <https://github.com/Graylog2/graylog2-server/issues/1574>`_ `Graylog2/graylog2-server#1533 <https://github.com/Graylog2/graylog2-server/issues/1533>`_
* Fixed race condition between index creation and index mapping configuration. `Graylog2/graylog2-server#1502 <https://github.com/Graylog2/graylog2-server/issues/1502>`_ `Graylog2/graylog2-server#1563 <https://github.com/Graylog2/graylog2-server/issues/1563>`_
* Fixed concurrency problem in GELF input handling. `Graylog2/graylog2-server#1561 <https://github.com/Graylog2/graylog2-server/issues/1561>`_
* Fixed issue with widget value calculation. `Graylog2/graylog2-server#1588 <https://github.com/Graylog2/graylog2-server/issues/1588>`_
* Do not extend user sessions when updating widgets. `Graylog2/graylog2-web-interface#1655 <https://github.com/Graylog2/graylog2-web-interface/issues/1655>`_
* Fixed compatibility mode for Internet Explorer. `Graylog2/graylog2-web-interface#1661 <https://github.com/Graylog2/graylog2-web-interface/issues/1661>`_ `Graylog2/graylog2-web-interface#1668 <https://github.com/Graylog2/graylog2-web-interface/issues/1668>`_
* Fixed whitespace issue in extractor example. `Graylog2/graylog2-web-interface#1650 <https://github.com/Graylog2/graylog2-web-interface/issues/1650>`_
* Fixed several issues on the indices page. `Graylog2/graylog2-web-interface#1691 <https://github.com/Graylog2/graylog2-web-interface/issues/1691>`_ `Graylog2/graylog2-web-interface#1692 <https://github.com/Graylog2/graylog2-web-interface/issues/1692>`_
* Fixed permission issue for stream alert management. `Graylog2/graylog2-web-interface#1659 <https://github.com/Graylog2/graylog2-web-interface/issues/1659>`_
* Fixed deletion of LDAP group mappings when updating LDAP settings. `Graylog2/graylog2-server#1513 <https://github.com/Graylog2/graylog2-server/issues/1513>`_
* Fixed dangling role references after deleting a role `Graylog2/graylog2-server#1608 <https://github.com/Graylog2/graylog2-server/issues/1608>`_
* Support LDAP Group Mapping for Sun Directory Server (new since beta.2) `Graylog2/graylog2-server#1583 <https://github.com/Graylog2/graylog2-server/issues/1583>`_


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
* Fixed role assignment when updating user via REST API. `Graylog2/graylog2-server#1456 <https://github.com/Graylog2/graylog2-server/issues/1456>`_, `Graylog2/graylog2-server#1507 <https://github.com/Graylog2/graylog2-server/issues/1507>`_


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
* Unable to unpause streams, despite editing permissions. `Graylog2/graylog2-web-interface#1456 <https://github.com/Graylog2/graylog2-web-interface/issues/1456>`_
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
* Unable to unpause streams, despite editing permissions. `Graylog2/graylog2-web-interface#1456 <https://github.com/Graylog2/graylog2-web-interface/issues/1456>`_
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
