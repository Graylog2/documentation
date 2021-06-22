.. _forwarder_config_options:

###############################
Forwarder Configuration Options
###############################

The forwarder supports the following configuration options:

* ``forwarder_server_hostname``: *(required)* The Graylog Forwarder ingest hostname (eg. ``graylog`` for on-premise or ``ingest-<your-account>.graylog.cloud`` for Cloud). Provided in the Forwarder Setup Wizard in Graylog.
* ``forwarder_grpc_api_token``: *(required)* The [API Token](#forwarder-api-token) for authenticating the Forwarder. Provided in the Forwarder Setup Wizard in Graylog.
* ``forwarder_grpc_enable_tls``: *(optional - defaults to ``true``)* Enables TLS for Forwarder communication. This should always be enabled for production use.
* ``forwarder_grpc_tls_trust_chain_cert_file``: *(optional)* The full path to the trust chain certificate file (eg. cert.pem), which is used to encrypt Forwarder communication. If not provided, the Forwarder will still trust public CAs. This is not required for Cloud installations, since a public CA is used.
* ``forwarder_message_transmission_port``: *(optional - defaults to ``13301``)* The remote TCP port through which to send log messages to Graylog.
* ``forwarder_configuration_port``: *(optional - defaults to ``13302``)* The remote TCP port through which a configuration and control channel is established between the Forwarder and Graylog.
* ``forwarder_grpc_enable_compression``: *(optional - defaults to ``true``)* Enables compression for Forwarder communication.
* ``forwarder_grpc_call_timeout``: *(optional - defaults to ``60s``)* The timeout for Forwarder log message Forwarding communication.
* ``forwarder_grpc_graceful_shutdown_timeout``: *(optional - defaults to `10s`)* The time to allow ongoing log message Forwarding requests to complete on Forwarder shutdown.
* ``forwarder_grpc_message_batch_size``: *(optional - defaults to ``100KB``)* The size for batches of log messages which triggers sending from the Forwarder to Graylog. Once this batch size is reached, the batch is synchronously sent to Graylog.
* ``forwarder_grpc_max_message_size``: *(optional - defaults to ``4MB``)* The maximum log message size permitted through the Forwarder. Log messages exceeding this size will be discarded. This value must be smaller than the same property set on the Graylog server-side of the Forwarder.
* ``forwarder_grpc_message_flush_interval``: *(optional - defaults to ``1s``)* The maximum time to wait before sending a batch to Graylog if the configured batch size was not yet reached.
* ``forwarder_grpc_message_sending_thread_pool_size``: *(optional - defaults to ``5``)* The number of simultaneous batch sender threads. Each batch sender will attempt to send one batch at a time and wait for a server-side acknowledgement before proceeding.
* ``forwarder_configuration_polling_interval``: *(optional - defaults to ``10s``)* The interval at which configuration is retrieved from Graylog.
* ``forwarder_state_reporting_interval``: *(optional - defaults to ``10s``)* The interval at which input states and metrics are reported to Graylog.
* ``forwarder_heartbeat_interval``: *(optional - defaults to ``2s``)* The interval at which the Forwarder heartbeat is sent. This tells Graylog that the Forwarder is connected.
* ``forwarder_api_enabled``: *(optional - defaults to ``false``)* Enables the Forwarder REST API. If enabled, the API will listen on a Unix Domain Socket using the file indicated with ``forwarder_api_socket_path`` unless a ``forwarder_api_tcp_bind_address`` value is provided.
* ``forwarder_api_socket_path``: *(optional - defaults to ``<working-directory/data/forwarder-api.sock>``)* If the Forwarder API is enabled, it will listen on a Unix Domain Socket using this file unless a ``forwarder_api_tcp_bind_address`` value is specified.
* ``forwarder_api_socket_permissions``: *(optional - defaults to ``rw-------``)* The permissions for the Forwarder API Domain Socket file.
* ``forwarder_api_tcp_bind_address``: *(optional)* The host and optional port number to bind the Forwarder API to eg. ``192.168.1.10`` or ``192.168.1.10:9090``. If a port number is not specified with the hostname, the default port ``9001`` will be used. If specified, the API will no longer listen on a Unix Domain Socket.