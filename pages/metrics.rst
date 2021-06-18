*******
Metrics
*******

Standard Metrics
================

Graylog collects metrics throughout its operation and stores them in-memory on each Graylog node. The metrics include
event counts, timers and statistics for many parts of the Graylog application and its subsystems. Standard metrics are
viewable within Graylog on the **System > Nodes** page through the **Metrics** button.

.. image:: /images/metrics/standard_metrics.png

Standard metrics can also be queried through the :ref:`Graylog REST API Browser <configuring_api>`.

Prometheus Metric Exporting
===========================

Starting in Graylog 4.1, metrics can be exported to other systems VIA the Prometheus Metrics Exporting feature.
This feature can be optionally enabled. When enabled, Graylog will export metrics VIA a standard
`Prometheus HTTP exporter <https://prometheus.io/docs/instrumenting/writing_exporters>`_ on port ``9833``. Prometheus
can then scrape and ingest the metrics.

Configuration
-------------

To begin exporting Prometheus metrics, enable it with the following configuration property in the ``server.conf`` file.

.. code-block::

    prometheus_exporter_enabled = true

Once enabled, metrics are exported in the `standard export format <https://prometheus.io/docs/instrumenting/writing_exporters/>`_ on the following URI by default.

.. code-block::

    http://127.0.0.1:9833/api/metrics/prometheus

To specify a custom export hostname or IP address, the following configuration can be used.
We suggest leaving the default export port `9833`, since it is already `registered with Prometheus <https://github.com/prometheus/prometheus/wiki/Default-port-allocations>`_.

.. code-block::

    prometheus_exporter_bind_address = 10.0.0.1:9090

Depending on the current Prometheus `scrape_config setting <https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config>`_,
the Graylog Prometheus exporter may be discovered automatically, or an explicit scrape target might need to be
specified in your Prometheus target hosts file.

Default Core Metric Mappings
----------------------------

A `pre-defined core set <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/resources/prometheus-exporter.yml>`_  of Graylog-to-Prometheus metric mappings are enabled by default.

All metric names are prefixed with ``gl_...`` to clearly indicate that the metrics originated from Graylog. For example,
the metric name ``gl_input_throughput``.

.. image:: /images/metrics/prometheus_metric_names.png

All metrics are automatically assigned a ``node`` `metric label <https://prometheus.io/docs/practices/naming/>`_,
which contains the Graylog Node ID where the metric originated from. This can be useful for visualizing
the same metric across Graylog nodes.

.. image:: /images/metrics/node_id_metric.png

Many metrics are exported with a consolidated name, which allows breakouts by labels to allow easier visualization of metrics.

See the `pre-defined metric mappings <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/resources/prometheus-exporter.yml>`_
for a full list of metric mappings.


Customized Metric Mappings
--------------------------

We understand that metric mapping requirements can be very specific the each per-customer use case, so we provide
the ability to override the default core mappings. We also support the ability to specify any additional needed mappings.

Graylog metrics exports heavily utilize `Prometheus labels <https://prometheus.io/docs/concepts/data_model/#metric-names-and-labels>`_ to help you effectively visualize and analyze your metrics
data.

To completely replace the default core Prometheus mappings, provide the path to a core replacement mapping file ``YML`` file
containing just the desired mappings with the following configuration property. This file is monitored for changes at
runtime, so you can customize as needed without restarting your Graylog server. The file path is interpreted
relative to the Graylog server working directory. Absolute paths are also supported.

.. code-block::

   prometheus_exporter_mapping_file_path_core = prometheus-exporter-mapping-core.yml

To provide mappings in addition to the core defaults, provide the path to an additional mapping file ``yaml`` file
containing the additional desired mappings with the following configuration property. This file is also monitored for
changes at runtime.

.. code-block::

    prometheus_exporter_mapping_file_path_custom = prometheus-exporter-mapping-custom.yml

Custom Mappings Format Example 1
--------------------------------

This example mapping produces the ``gl_stream_incoming_messages`` metric in Prometheus, which shows the number of
messages received by for each stream in Graylog.

The standard metric name in Graylog contains the ID of the stream, and one distinct metric is recorded for each stream.

For example::

    org.graylog2.plugin.streams.Stream.stream-1.incomingMessages
    org.graylog2.plugin.streams.Stream.stream-2.incomingMessages
    org.graylog2.plugin.streams.Stream.stream-3.incomingMessages

The mapping definition that follows provides a ``match_pattern`` with a wildcard ``*`` for the ``stream-id``, which
provides one label for each stream id automatically. This allows for the visualization of messages received for all
streams together, but broken-out by stream-id VIA the labels functionality. The ``wildcard_extract_labels`` is an ordered
array, which provides the label names for any specified wildcards in the ``match_pattern``.

Mapping Definition::

  - metric_name: "stream_incoming_messages"
    match_pattern: "org.graylog2.plugin.streams.Stream.*.incomingMessages"
    wildcard_extract_labels:
      - "stream"

Custom Mappings Example 2
-------------------------
This example mapping produces the ``gl_buffer_usage`` metric in Prometheus, which provides the current usage state of
the Graylog ``input``, ``process`` and ``output`` buffers.

Note that three separate mappings are provided to consolidate three independent buffer Graylog metrics into a single
Prometheus metric with three unique labels (``input``, ``process``, ``output``) that correspond to each Graylog metric.

The ``additional_labels`` property allows for the assignment of an explicit label corresponding to the metric defined in
the ``match_pattern``.

Mapping Definition::

  - metric_name: "buffer_usage"
    match_pattern: "org.graylog2.buffers.input.usage"
    additional_labels:
      type: "input"

  - metric_name: "buffer_usage"
    match_pattern: "org.graylog2.buffers.output.usage"
    additional_labels:
      type: "output"

  - metric_name: "buffer_usage"
    match_pattern: "org.graylog2.buffers.process.usage"
    additional_labels:
      type: "process"

Custom Mappings Refresh Interval
--------------------------------
By default, custom and core mapping files are refreshed (re-read from disk) every 30 seconds. You can override this
with a custom duration if desired. Use the standard Graylog duration notation (eg ``60s``, ``5m`` or ``1h``).

.. code-block::

    prometheus_exporter_mapping_file_refresh_interval = 5m
