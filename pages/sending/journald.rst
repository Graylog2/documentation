***************
Ingest journald 
***************

Many Linux environments have journald configured to write the traditional log files to disk via Syslog. That enables us to use the Syslog to ingest the messages to Graylog. 

The better solution would be to write directly from journald to Graylog. As this is not supported by journald at the time of writing, we need to use the collector  `journalbeat <https://www.elastic.co/guide/en/beats/journalbeat/current/journalbeat-overview.html>`__ that allows to read the journal from systemd and use the beats framework to transport the messages.

In Graylog, create a beats input and configure the journalbeat with the logstash output pointing to the beats input in Graylog. The following configuration can be seen as example journalbeat configuration::

			journalbeat.inputs:
			  # Paths that should be crawled and fetched. Possible values files and directories.
			  # When setting a directory, all journals under it are merged.
			  # When empty starts to read from local journal.
			- paths: []

			  # The number of seconds to wait before trying to read again from journals.
			  #backoff: 1s
			  # The maximum number of seconds to wait before attempting to read again from journals.
			  #max_backoff: 20s

			  # Position to start reading from journal. Valid values: head, tail, cursor
			  seek: cursor
			  # Fallback position if no cursor data is available.
			  #cursor_seek_fallback: head

			  # Exact matching for field values of events.
			  # Matching for nginx entries: "systemd.unit=nginx"
			  #include_matches: []

			output.logstash:
			  # Boolean flag to enable or disable the output module.
			  enabled: true

			  # Graylog host and the beats input
			  hosts: ["graylog:5044"]

			  # Number of workers per Graylog host.
			  #worker: 1

			  # Set gzip compression level.
			  #compression_level: 3

			  # Configure escaping HTML symbols in strings.
			  #escape_html: false

			  # Optional maximum time to live for a connection to Graylog, after which the
			  # connection will be re-established.  A value of `0s` (the default) will
			  # disable this feature.
			  #
			  # Not yet supported for async connections (i.e. with the "pipelining" option set)
			  #ttl: 30s

			  # Optionally load-balance events between Graylog hosts. Default is false.
			  #loadbalance: false

			  # If enabled only a subset of events in a batch of events is transferred per
			  # transaction.  The number of events to be sent increases up to `bulk_max_size`
			  # if no error is encountered.
			  slow_start: true

			  # The number of seconds to wait before trying to reconnect to Graylog
			  # after a network error. After waiting backoff.init seconds, the Beat
			  # tries to reconnect. If the attempt fails, the backoff timer is increased
			  # exponentially up to backoff.max. After a successful connection, the backoff
			  # timer is reset. The default is 1s.
			  #backoff.init: 1s

			  # The maximum number of seconds to wait before attempting to connect to
			  # Graylog after a network error. The default is 60s.
			  #backoff.max: 60s

			  # SOCKS5 proxy server URL
			  #proxy_url: socks5://user:password@socks5-server:2233

			  # Resolve names locally when using a proxy server. Defaults to false.
			  #proxy_use_local_resolver: false

			  # Enable SSL support. SSL is automatically enabled if any SSL setting is set.
			  #ssl.enabled: true

			  # Configure SSL verification mode. If `none` is configured, all server hosts
			  # and certificates will be accepted. In this mode, SSL based connections are
			  # susceptible to man-in-the-middle attacks. Use only for testing. Default is
			  # `full`.
			  #ssl.verification_mode: full

			  # List of supported/valid TLS versions. By default all TLS versions from 1.1
			  # up to 1.3 are enabled.
			  #ssl.supported_protocols: [TLSv1.1, TLSv1.2, TLSv1.3]

			  # Optional SSL configuration options. SSL is off by default.
			  # List of root certificates for HTTPS server verifications
			  #ssl.certificate_authorities: ["/etc/pki/root/ca.pem"]

			  # Certificate for SSL client authentication
			  #ssl.certificate: "/etc/pki/client/cert.pem"

			  # Client certificate key
			  #ssl.key: "/etc/pki/client/cert.key"

			  # Optional passphrase for decrypting the Certificate Key.
			  #ssl.key_passphrase: ''

			  # Configure cipher suites to be used for SSL connections
			  #ssl.cipher_suites: []

			  # Configure curve types for ECDHE-based cipher suites
			  #ssl.curve_types: []

			  # Configure what types of renegotiation are supported. Valid options are
			  # never, once, and freely. Default is never.
			  #ssl.renegotiation: never

			  # Configure a pin that can be used to do extra validation of the verified certificate chain,
			  # this allow you to ensure that a specific certificate is used to validate the chain of trust.
			  #
			  # The pin is a base64 encoded string of the SHA-256 fingerprint.
			  #ssl.ca_sha256: ""

			  # The number of times to retry publishing an event after a publishing failure.
			  # After the specified number of retries, the events are typically dropped.
			  # Some Beats, such as Filebeat and Winlogbeat, ignore the max_retries setting
			  # and retry until all events are published.  Set max_retries to a value less
			  # than 0 to retry until all events are published. The default is 3.
			  #max_retries: 3

			  # The maximum number of events to bulk in a single Graylog request. The
			  # default is 2048.
			  bulk_max_size: 2048

			  # The number of seconds to wait for responses from the Graylog server before
			  # timing out. The default is 30s.
			  #timeout: 30s
