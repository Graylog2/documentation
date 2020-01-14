.. _server/.conf:

***********
server.conf
***********

The file ``server.conf`` is the Graylog configuration file.

.. note:: Check :ref:`default_file_location` to locate it in your installation.

It has to use ISO 8859-1/Latin-1 character encoding.
Characters that cannot be directly represented in this encoding can be written using Unicode escapes as defined in `Java SE Specifications <https://docs.oracle.com/javase/specs/jls/se8/html/jls-3.html#jls-3.3>`_, using the \u prefix.
For example, \u002c.

* Entries are generally expected to be a single line of the form, one of the following:
    * ``propertyName=propertyValue``
    * ``propertyName:propertyValue``

* White space that appears between the property name and property value is ignored, so the following are equivalent:
    * ``name=Stephen``
    * ``name = Stephen``
* White space at the beginning of the line is also ignored.
* Lines that start with the comment characters ``!`` or ``#`` are ignored. Blank lines are also ignored.
* The property value is generally terminated by the end of the line. White space following the property value is not ignored, and is treated as part of the property value.

* A property value can span several lines if each line is terminated by a backslash (``\``) character. For example::

      targetCities=\
             Detroit,\
             Chicago,\
             Los Angeles

  This is equivalent to ``targetCities=Detroit,Chicago,Los Angeles`` (white space at the beginning of lines is ignored).

* The characters newline, carriage return, and tab can be inserted with characters ``\n``, ``\r``, and ``\t``, respectively.
* The backslash character must be escaped as a double backslash. For example::

    path=c:\\docs\\doc1

Properties
----------

General
^^^^^^^

* ``is_master = true``
    * If you are running more than one instances of Graylog server you have to select only one ``graylog-server`` node as the master. This node will perform periodical and maintenance actions that slave nodes won't.
    * Every slave node will accept messages just as the master nodes. Nodes will fall back to slave mode if there already is a master in the cluster.
* ``node_id_file = /etc/graylog/server/<node-id>``
    * The auto-generated node ID will be stored in this file and read after restarts. It is a good idea to use an absolute file path here if you are starting Graylog server from init scripts or similar.
* ``password_secret = <secret>``
    * You MUST set a secret that is used for password encryption and salting. The server will refuse to start if it's not set. Use at least 64 characters.  If you run multiple ``graylog-server`` nodes, make sure you use the same ``password_secret`` for all of them!

    .. note:: Generate a secret with for example ``pwgen -N 1 -s 96``
* ``root_username = admin``
    * The default root user is named **admin**.
* ``root_password_sha2 = <SHA2>``
    * A SHA2 hash of a password you will use for your initial login. Set this to a SHA2 hash generated with ``echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1`` and you will be able to log in to the web interface with username **admin** and password **yourpassword**.

    .. caution:: You MUST specify a hash password for the root user (which you only need to initially set up the system and in case you lose connectivity to your authentication backend). This password cannot be changed using the API or via the web interface. If you need to change it, modify it in this file.
* ``root_email = ""``
    * The email address of the root user. Default is empty.
* ``root_timezone = UTC``
    * The time zone setting of the root user. See this `list of valid time zones <http://www.joda.org/joda-time/timezones.html>`_. Default is UTC.
* ``bin_dir = bin``
    * This directory contains binaries that are used by the Graylog server. (relative or absolute)
* ``data_dir = data``
    * This directory is used to store Graylog server state. (relative or absolute)  
* ``plugin_dir = plugin``
    * Set plugin directory here (relative or absolute)


.. _web_rest_api_options:

Web & REST API
^^^^^^^^^^^^^^

* ``http_bind_address = 127.0.0.1:9000``
    * The network interface used by the Graylog HTTP interface.
    * This network interface must be accessible by all Graylog nodes in the cluster and by all clients using the Graylog web interface.
    * If the port is omitted, Graylog will use port 9000 by default.
* ``http_publish_uri = http://$http_bind_address/``
    * The HTTP URI of this Graylog node which is used to communicate with the other Graylog nodes in the cluster and by all clients using the Graylog web interface.
    * The URI will be published in the cluster discovery APIs, so that other Graylog nodes will be able to find and connect to this Graylog node.
    * This configuration setting has to be used if this Graylog node is available on another network interface than $http_bind_address, for example if the machine has multiple network interfaces or is behind a NAT gateway.
    * This configuration setting *must not* be configured to a wildcard address!
    * If ``http_bind_address`` contains a wildcard IPv4 address (0.0.0.0), ``http_publish_uri`` will be filled with the first non-loopback IPv4 address of this machine instead.
* ``http_external_uri = $http_publish_uri``
    * The public URI of Graylog which will be used by the Graylog web interface to communicate with the Graylog REST API.
    * The external Graylog URI usually has to be specified, if Graylog is running behind a reverse proxy or load-balancer and it will be used to generate URLs addressing entities in the Graylog REST API (see $http_bind_address).
    * When using Graylog Collector, this URI will be used to receive heartbeat messages and must be accessible for all collectors.
    * This setting can be overriden on a per-request basis with the "X-Graylog-Server-URL" HTTP request header.
* ``http_enable_cors = true``
    * Enable CORS headers for HTTP interface.
    * This is necessary for JS-clients accessing the server directly.
    * If these are disabled, modern browsers will not be able to retrieve resources from the server.
* ``http_enable_gzip = true``
    * This compresses API responses and therefore helps to reduce overall round trip times.
* ``http_max_header_size = 8192``
    * The maximum size of the HTTP request headers in bytes.
* ``http_thread_pool_size = 16``
    * The size of the thread pool used exclusively for serving the HTTP interface.
* ``http_enable_tls = false``
    * This secures the communication with the HTTP interface with TLS to prevent request forgery and eavesdropping.
* ``http_tls_cert_file = /path/to/graylog.crt``
    * The X.509 certificate chain file in PEM format to use for securing the HTTP interface.
* ``http_tls_key_file = /path/to/graylog.key``
    * The PKCS#8 private key file in PEM format to use for securing the HTTP interface.
* ``http_tls_key_password = secret``
    * The password to unlock the private key used for securing the HTTP interface. (if key is encrypted)
* ``trusted_proxies = 127.0.0.1/32, 0:0:0:0:0:0:0:1/128``
    * Comma separated list of trusted proxies that are allowed to set the client address with X-Forwarded-For header. May be subnets, or hosts.

Elasticsearch
^^^^^^^^^^^^^
* ``elasticsearch_hosts = http://node1:9200,http://user:password@node2:19200``
    * List of Elasticsearch hosts Graylog should connect to.
    * Need to be specified as a comma-separated list of valid URIs for the http ports of your elasticsearch nodes.
    * If one or more of your elasticsearch hosts require authentication, include the credentials in each node URI that requires authentication.
    * Default: ``http://127.0.0.1:9200``
* ``elasticsearch_connect_timeout = 10s``
    * Maximum amount of time to wait for successfull connection to Elasticsearch HTTP port.
    * Default: 10 seconds
* ``elasticsearch_socket_timeout = 60s``
    * Maximum amount of time to wait for reading back a response from an Elasticsearch server.
    * Default: 60 seconds
* ``elasticsearch_idle_timeout = -1s``
    * Maximum idle time for an Elasticsearch connection. If this is exceeded, this connection will be tore down.
    * Default: infinity
* ``elasticsearch_max_total_connections = 20``
    * Maximum number of total connections to Elasticsearch.
    * Default: 20
* ``elasticsearch_max_total_connections_per_route = 2``
    * Maximum number of total connections per Elasticsearch route (normally this means per elasticsearch server).
    * Default: 2
* ``elasticsearch_max_retries = 2``
    * Maximum number of times Graylog will retry failed requests to Elasticsearch.
    * Default: 2
* ``elasticsearch_discovery_enabled = false``
    * Enable automatic Elasticsearch node discovery through Nodes Info, see `Elasticsearch Reference » Cluster APIs » Nodes Info <https://www.elastic.co/guide/en/elasticsearch/reference/5.4/cluster-nodes-info.html>`_.
    * Default: ``false``

    .. warning:: Automatic node discovery does not work if Elasticsearch requires authentication, e. g. with Shield.

    .. warning:: This setting must be false on AWS Elasticsearch Clusters (the hosted ones) and should be used carefully. In case of trouble with connections to ES this should be the first option to be disabled. See :ref:`automatic_node_discovery` for more details.


* ``elasticsearch_discovery_filter = rack:42``
    * Filter for including/excluding Elasticsearch nodes in discovery according to their custom attributes, see `Elastic Search Reference » Cluster APIs » Node Specification <https://www.elastic.co/guide/en/elasticsearch/reference/5.4/cluster.html#cluster-nodes>`_.
    * Default: empty
* ``elasticsearch_discovery_frequency = 30s``
    * Frequency of the Elasticsearch node discovery.
    * Default: 30 seconds
* ``elasticsearch_compression_enabled = false``
    * Enable payload compression for Elasticsearch requests.
    * Default: false

Rotation
^^^^^^^^

.. attention:: The following settings identified with *!* in this section have been moved to the database in Graylog 2.0. When you upgrade, make sure to set these to your previous 1.x settings so they will be migrated to the database!

* ``rotation_strategy = count`` *!*
    * Graylog will use multiple indices to store documents in. You can configured the strategy it uses to determine when to rotate the currently active write index.
    * It supports multiple rotation strategies:
      - ``count`` of messages per index, use ``elasticsearch_max_docs_per_index``
      - ``size`` per index, use ``elasticsearch_max_size_per_index``
    * valid values are ``count``, ``size`` and ``time``, default is ``count``.
* ``elasticsearch_max_docs_per_index = 20000000`` *!*
    * (Approximate) maximum number of documents in an Elasticsearch index before a new index is being created, also see no_retention and ``elasticsearch_max_number_of_indices``.
    * Configure this if you used ``rotation_strategy = count`` above.
* ``elasticsearch_max_size_per_index = 1073741824`` *!*
    * (Approximate) maximum size in bytes per Elasticsearch index on disk before a new index is being created, also see ``no_retention`` and ```elasticsearch_max_number_of_indices```. Default is 1GB.
    * Configure this if you used ``rotation_strategy = size`` above.
* ``elasticsearch_max_time_per_index = 1d`` *!*
    * (Approximate) maximum time before a new Elasticsearch index is being created, also see ``no_retention`` and ``elasticsearch_max_number_of_indices``. Default is 1 day.
    * Configure this if you used ``rotation_strategy = time`` above.
    * Please note that this rotation period does not look at the time specified in the received messages, but is using the real clock value to decide when to rotate the index!
    * Specify the time using a duration and a suffix indicating which unit you want:
        * ``1w``  = 1 week
        * ``1d``  = 1 day
        * ``12h`` = 12 hours
    * Permitted suffixes are: ``d`` for day, ``h`` for hour, ``m`` for minute, ``s`` for second.
* ``elasticsearch_max_number_of_indices = 20`` *!*
    * How many indices do you want to keep?
* ``retention_strategy = delete`` *!*
    * Decide what happens with the oldest indices when the maximum number of indices is reached.
    * The following strategies are availble:
        - ``delete`` -  Deletes the index completely (Default)
        - ``close`` - Closes the index and hides it from the system. Can be re-opened later.

================================

* ``elasticsearch_disable_version_check = true``
    * Disable checking the version of Elasticsearch for being compatible with this Graylog release.

    .. warning:: Using Graylog with unsupported and untested versions of Elasticsearch may lead to data loss!
* ``no_retention = false``
    * Disable message retention on this node, i. e. disable Elasticsearch index rotation.

================================

.. attention:: The following settings identified with *!!* have been moved to the database in Graylog 2.2.0. When you upgrade, make sure to set these to your previous settings so they will be migrated to the database. This settings are read **once** at the very first startup to be the initial settings in the database.

* ``elasticsearch_shards = 4`` *!!*
    * The number of shards for your indices. A good setting here highly depends on the number of nodes in your Elasticsearch cluster. If you have one node, set it to ``1``.
* ``elasticsearch_replicas = 0`` *!!*
    * The number of replicas for your indices. A good setting here highly depends on the number of nodes in your Elasticsearch cluster. If you have one node, set it to ``0``.

  .. note:: ``elasticsearch_shards`` and ``elasticsearch_replicas`` only applies to newly created indices.
* ``elasticsearch_index_prefix = graylog`` *!!*
    * Prefix for all Elasticsearch indices and index aliases managed by Graylog.
* ``elasticsearch_template_name = graylog-internal`` *!!*
    * Name of the Elasticsearch index template used by Graylog to apply the mandatory index mapping.
    * Default: graylog-internal
* ``elasticsearch_analyzer = standard`` *!!*
    * Analyzer (tokenizer) to use for message and full_message field. The "standard" filter usually is a good idea.
    * All supported analyzers are: standard, simple, whitespace, stop, keyword, pattern, language, snowball, custom
    * Elasticsearch documentation: https://www.elastic.co/guide/en/elasticsearch/reference/5.6/analysis.html
    * Note that this setting only takes effect on newly created indices.
* ``disable_index_optimization = false`` *!!*
    * Disable the optimization of Elasticsearch indices after index cycling. This may take some load from Elasticsearch on heavily used systems with large indices, but it will decrease search performance. The default is to optimize cycled indices.
* ``index_optimization_max_num_segments = 1`` *!!*
    * Optimize the index down to <= index_optimization_max_num_segments. A higher number may take some load from Elasticsearch on heavily used systems with large indices, but it will decrease search performance. The default is 1.

================================

.. _output_batch_size:

* ``allow_leading_wildcard_searches = false``
    * Do you want to allow searches with leading wildcards? This can be extremely resource hungry and should only be enabled with care.
    * See also: :ref:`queries`

* ``allow_highlighting = false``
    *  Do you want to allow searches to be highlighted? Depending on the size of your messages this can be memory hungry and should only be enabled after making sure your Elasticsearch cluster has enough memory.

* ``elasticsearch_request_timeout = 1m``
    * Global request timeout for Elasticsearch requests (e. g. during search, index creation, or index time-range calculations) based on a best-effort to restrict the runtime of Elasticsearch operations.
    * Default: 1m
* ``elasticsearch_index_optimization_timeout = 1h``
    * Global timeout for index optimization (force merge) requests.
    * Default: 1h
* ``elasticsearch_index_optimization_jobs = 20``
    * Maximum number of concurrently running index optimization (force merge) jobs.
    * If you are using lots of different index sets, you might want to increase that number.
    * Default: 20
* ``index_ranges_cleanup_interval = 1h``
    * Time interval for index range information cleanups. This setting defines how often stale index range information is being purged from the database.
    * Default: 1h
* ``output_batch_size = 500``
    * Batch size for the Elasticsearch output. This is the maximum (!) number of messages the Elasticsearch output module will get at once and write to Elasticsearch in a batch call. If the configured batch size has not been reached within ``output_flush_interval`` seconds, everything that is available will be flushed at once. Remember that every output buffer processor manages its own batch and performs its own batch write calls. (``outputbuffer_processors`` variable)
* ``output_flush_interval = 1``
    * Flush interval (in seconds) for the Elasticsearch output. This is the maximum amount of time between two batches of messages written to Elasticsearch. It is only effective at all if your minimum number of messages for this time period is less than ``output_batch_size * outputbuffer_processors``.

* ``output_fault_count_threshold = 5``
* ``output_fault_penalty_seconds = 30``
    * As stream outputs are loaded only on demand, an output which is failing to initialize will be tried over and over again. To prevent this, the following configuration options define after how many faults an output will not be tried again for an also configurable amount of seconds.
* ``processbuffer_processors = 5``
* ``outputbuffer_processors = 3``
    * The number of parallel running processors.
    * Raise this number if your buffers are filling up.


* ``outputbuffer_processor_keep_alive_time = 5000``
* ``outputbuffer_processor_threads_core_pool_size = 3``
* ``outputbuffer_processor_threads_max_pool_size = 30``
* ``udp_recvbuffer_sizes = 1048576``
    * UDP receive buffer size for all message inputs (e. g. SyslogUDPInput).

* ``processor_wait_strategy = blocking``
    * Wait strategy describing how buffer processors wait on a cursor sequence. (default: sleeping)
    * Possible types:
        - ``yielding`` - Compromise between performance and CPU usage.
        - ``sleeping`` - Compromise between performance and CPU usage. Latency spikes can occur after quiet periods.
        - ``blocking`` -  High throughput, low latency, higher CPU usage.
        - ``busy_spinning`` - Avoids syscalls which could introduce latency jitter. Best when threads can be bound to specific CPU cores.
* ``ring_size = 65536``
    * Size of internal ring buffers. Raise this if raising ``outputbuffer_processors`` does not help anymore.
    * For optimum performance your LogMessage objects in the ring buffer should fit in your CPU L3 cache.
    * Must be a power of 2. (512, 1024, 2048, ...)
* ``inputbuffer_ring_size = 65536``
* ``inputbuffer_processors = 2``
* ``inputbuffer_wait_strategy = blocking``
* ``message_journal_enabled = true``
    * Enable the disk based message journal.

* ``message_journal_dir = data/journal``
      * The directory which will be used to store the message journal. The directory must me exclusively used by Graylog and must not contain any other files than the ones created by Graylog itself.

  .. attention:: If you create a seperate partition for the journal files and use a file system creating directories like 'lost+found' in the root directory, you need to create a sub directory for your journal. Otherwise Graylog will log an error message that the journal is corrupt and Graylog will not start.
* ``message_journal_max_age = 12h``
* ``message_journal_max_size = 5gb``
    * Journal hold messages before they could be written to Elasticsearch.
    * For a maximum of 12 hours or 5 GB whichever happens first.
    * During normal operation the journal will be smaller.
* ``message_journal_flush_age = 1m``
    * This setting allows specifying a time interval at which we will force an fsync of data written to the log. For example if this was set to 1000 we would fsync after 1000 ms had passed.
* ``message_journal_flush_interval = 1000000``
    * This setting allows specifying an interval at which we will force an fsync of data written to the log. For example if this was set to 1 we would fsync after every message; if it were 5 we would fsync after every five messages.
* ``message_journal_segment_age = 1h``
     * This configuration controls the period of time after which Graylog will force the log to roll even if the segment file isn’t full to ensure that retention can delete or compact old data.
* ``message_journal_segment_size = 100mb``

.. attention:: When the journal is full and it keeps receiving messages, it will start dropping messages as a FIFO queue: The first dropped message will be the first inserted and so on (and not some random).

* ``async_eventbus_processors = 2``
    * Number of threads used exclusively for dispatching internal events. Default is 2.
* ``lb_recognition_period_seconds = 3``
    * How many seconds to wait between marking node as DEAD for possible load balancers and starting the actual shutdown process. Set to 0 if you have no status checking load balancers in front.
* ``lb_throttle_threshold_percentage = 95``
    * Journal usage percentage that triggers requesting throttling for this server node from load balancers. The feature is disabled if not set.
* ``stream_processing_timeout = 2000``
* ``stream_processing_max_faults = 3``
    * Every message is matched against the configured streams and it can happen that a stream contains rules which take an unusual amount of time to run, for example if its using regular expressions that perform excessive backtracking.
    * This will impact the processing of the entire server. To keep such misbehaving stream rules from impacting other streams, Graylog limits the execution time for each stream.
    * The default values are noted below, the timeout is in milliseconds.
    * If the stream matching for one stream took longer than the timeout value, and this happened more than "max_faults" times that stream is disabled and a notification is shown in the web interface.

.. note:: Since 0.21 the Graylog server supports pluggable output modules. This means a single message can be written to multiple outputs. The next setting defines the timeout for a single output module, including the default output module where all messages end up.

* ``output_module_timeout = 10000``
    * Time in milliseconds to wait for all message outputs to finish writing a single message.
* ``stale_master_timeout = 2000``
    * Time in milliseconds after which a detected stale master node is being rechecked on startup.
* ``shutdown_timeout = 30000``
    * Time in milliseconds which Graylog is waiting for all threads to stop on shutdown.

MongoDB
^^^^^^^
* ``mongodb_uri = mongodb://...``
    * MongoDB connection string. Enter your MongoDB connection and authentication information here.
    * See https://docs.mongodb.com/manual/reference/connection-string/ for details.
    * Take notice that ``+``-signs in the username or password need to be replaced by ``%2B``.
    * Examples:
        - Simple: ``mongodb://localhost/graylog``
        - Authenticate against the MongoDB server: ``mongodb_uri = mongodb://grayloguser:secret@localhost:27017/graylog``
        - Use a replica set instead of a single host: ``mongodb://grayloguser:secret@localhost:27017,localhost:27018,localhost:27019/graylog?replicaSet=rs01``
        - `DNS Seedlist <https://docs.mongodb.com/manual/reference/connection-string/#dns-seedlist-connection-format>`_ is set as ``mongodb+srv://server.example.org/graylog``.
* ``mongodb_max_connections = 1000``
    * Increase this value according to the maximum connections your MongoDB server can handle from a single client if you encounter MongoDB connection problems.
* ``mongodb_threads_allowed_to_block_multiplier = 5``
    * Number of threads allowed to be blocked by MongoDB connections multiplier. Default: 5
    * If ``mongodb_max_connections`` is 100, and ``mongodb_threads_allowed_to_block_multiplier`` is 5, then 500 threads can block. More than that and an exception will be thrown.
    * http://api.mongodb.com/java/current/com/mongodb/MongoOptions.html#threadsAllowedToBlockForConnectionMultiplier

.. _email_config:

Email
^^^^^

* ``transport_email_enabled = false``
* ``transport_email_hostname = mail.example.com``
* ``transport_email_port = 587``
* ``transport_email_use_auth = true``
* ``transport_email_use_tls = true``
    * Enable SMTP with STARTTLS for encrypted connections.
* ``transport_email_use_ssl = false``
    * Enable SMTP over SSL (SMTPS) for encrypted connections.

.. attention:: Make sure to enable only *one* of these two settings because most (or all) SMTP services only support one of the encryption mechanisms on the same port. Most SMTP services support SMTP with STARTTLS while SMTPS is deprecated on most SMTP services. Setting both to ``false`` is needed when you want to sent via unencrypted connection.

* ``transport_email_auth_username = you@example.com``
* ``transport_email_auth_password = secret``
* ``transport_email_subject_prefix = [graylog]``
* ``transport_email_from_email = graylog@example.com``
* ``transport_email_web_interface_url = https://graylog.example.com``
    * Specify this to include links to the stream in your stream alert mails.
    * This should define the fully qualified base url to your web interface exactly the same way as it is accessed by your users.

.. _http_config:

HTTP
^^^^

* ``http_connect_timeout = 5s``
    * The default connect timeout for outgoing HTTP connections.
    * Values must be a positive duration (and between 1 and 2147483647 when converted to milliseconds).
    * Default: 5s
* ``http_read_timeout = 10s``
    * The default read timeout for outgoing HTTP connections.
    * Values must be a positive duration (and between 1 and 2147483647 when converted to milliseconds).
    * Default: 10s
* ``http_write_timeout = 10s``
    * The default write timeout for outgoing HTTP connections.
    * Values must be a positive duration (and between 1 and 2147483647 when converted to milliseconds).
    * Default: 10s
* ``http_proxy_uri =``
    * HTTP proxy for outgoing HTTP connections

.. attention:: If you configure a proxy, make sure to also configure the "http_non_proxy_hosts" option so internal HTTP connections with other nodes does not go through the proxy.

* ``http_non_proxy_hosts =``
    * A list of hosts that should be reached directly, bypassing the configured proxy server.
    * This is a list of patterns separated by ",". The patterns may start or end with a "*" for wildcards.
    * Any host matching one of these patterns will be reached through a direct connection instead of through a proxy.    

.. _processing_status:

Processing Status
^^^^^^^^^^^^^^^^^

.. note:: The settings for processing status usually don't need to be tweaked.

* ``processing_status_persist_interval = 1s``
    * The server is writing processing status information to the database on a regular basis. This setting controls how often the data is written to the database.
    * Values must be a positive duration and cannot be less than one second.
    * Default: 1s (one second)
* ``processing_status_update_threshold = 1m``
    * Configures the threshold for detecting outdated processing status records. Any records that haven't been updated in the configured threshold will be ignored.
    * Values must be a positive duration and cannot be less than one second.
    * Default: 1m (one minute)
* ``processing_status_journal_write_rate_threshold= 1``
    * Configures the journal write rate threshold for selecting processing status records. Any records that have a lower one minute rate than the configured value might be ignored. (dependent on number of messages in the journal)
    * Values must be a positive duration.
    * Default: 1

.. _config_script_alert:

Script alert notification
^^^^^^^^^^^^^^^^^^^^^^^^^

* ``integrations_web_interface_uri = https://graylog.example.com``
    * Specify this to include a search page link (that displays relevant alert messages) in the script arguments or standard in JSON.
    * This should define the fully qualified base url to your web interface exactly the same way as it is accessed by your users.
    * Default: none
* ``integrations_scripts_dir = /usr/share/graylog-server/scripts``
    * An absolute or relative path where scripts are permitted to be executed from.
    * If specified, this overrides the default location (see the :ref:`File Locations <scripts_dir>` document.

Others
^^^^^^

* ``gc_warning_threshold = 1s``
      * The threshold of the garbage collection runs. If GC runs take longer than this threshold, a system notification will be generated to warn the administrator about possible problems with the system. Default is 1 second.
* ``ldap_connection_timeout = 2000``
    * Connection timeout for a configured LDAP server (e. g. ActiveDirectory) in milliseconds.
* ``disable_sigar = false``
    * Disable the use of SIGAR for collecting system stats.
* ``dashboard_widget_default_cache_time = 10s``
    * The default cache time for dashboard widgets. (Default: 10 seconds, minimum: 1 second)
* ``proxied_requests_thread_pool_size = 32``
    * For some cluster-related REST requests, the node must query all other nodes in the cluster. This is the maximum number of threads available for this. Increase it, if ``/cluster/*`` requests take long to complete.
    * Should be ``http_thread_pool_size * average_cluster_size`` if you have a high number of concurrent users.
* ``default_events_index_prefix = gl-events``
    * The default index prefix for graylog events.
* ``default_system_events_index_prefix = gl-system-events``
    * The default index prefix for graylog system events.
* ``enabled_tls_protocols``
    * Configure system wide enabled TLS protocols. Only configure this if you need to support legacy systems. We will maintain a secure default. (Currently TLS 1.2 and TLS 1.3).
      (Note: The web interface cannot support TLS 1.3 with JDK 8)
