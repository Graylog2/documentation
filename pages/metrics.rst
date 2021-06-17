*******
Metrics
*******

Standard Metrics
================

Graylog collects metrics throughout its operation and stores those in-memory on each Graylog node. The metrics include
event counts, timers and statistics for many parts of the Graylog application and its subsystems. Standard metrics are
viewable within Graylog on the **System > Nodes** page through the **Nodes** button.

.. image:: /images/standard_metrics.png

Standard metrics are also available through the :ref:`Graylog REST API Browser <configuring_api>`.

Prometheus Metric Export
========================

Starting in Graylog 4.1, metrics can be exported to other systems VIA the Prometheus Metrics Export feature.
This is an optional feature, which must be enabled. When enabled, Graylog will export metrics VIA a standard HTTP
Prometheus exporter on port `9833`.

Configuration
-------------

To enable Prometheus metrics exporting, enable it with the following configuration property in the ``server.conf`` file.

.. code-block::

    prometheus_exporter_enabled = true

To specify a custom export IP address or hostname, the following configuration can be used (Defaults to ``127.0.0.1:9833``).
We suggest leaving the default export port `9833`, since it is already `registered with Prometheus <https://github.com/prometheus/prometheus/wiki/Default-port-allocations>`_

.. code-block::

    prometheus_exporter_bind_address = 10.0.0.1:9090

Once enabled, metrics will be exported in the standard Prometheus format at the following default URL.

.. code-block::

    http://127.0.0.1:9833/api/metrics/prometheus

Depending on the current Prometheus `scrape_config setting <https://eus.io/docs/prometheus/latest/configuration/configuration/#scrape_config>`_,
the Graylog Prometheus exporter may be discovered automatically, or an explicit scrape target might need to be
specified.

Default Core Metric Mappings
----------------------------

A `pre-defined core set of Graylog-to-Prometheus metric mappings <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/resources/prometheus-exporter.yml>`_
 are enabled by default.

All metric names are prefixed with ``gl_...`` to clearly indicate that the metrics originated from Graylog. For example,
the metric name ``gl_input_throughput``.

All metrics are automatically assigned a ``node`` `metric label <https://prometheus.io/docs/practices/naming/>`_,
which contains the Graylog Node ID where the metric
originated from. This can be very useful for visualizing the same metric across Graylog nodes.

Many metrics are exported with a consolidated name, which allows breakouts by labels to allow easier visualization of metrics.

See the `pre-defined metric mappings <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/resources/prometheus-exporter.yml>`_
for a full list of metric mappings.

Customized Metric Mappings
--------------------------

We understand that metric mapping requirements can be very specific the each per-customer use case, so we provide
the ability to override the default core mappings. We also support the ability to specify any additional needed mappings.

To completely replace the default core prometheus mappings, provide the path to a core replacement mapping file ``YML`` file
containing just the desired mappings with the following configuration property. This file is monitored for changes at
runtime, so you can customize as needed without restarting your Graylog server. The path of this file is interpreted
relative to the Graylog server working directory. Absolute paths are also supported.

.. code-block::

   prometheus_exporter_mapping_file_path_core = prometheus-exporter-mapping-core.yml

To provide mappings in addition to the core defaults, provide the path to an additional mapping file ``YML`` file
containing the additional desired mappings with the following configuration property. This file is also monitored for
changes at runtime.

.. code-block::

    prometheus_exporter_mapping_file_path_custom = prometheus-exporter-mapping-custom.yml

Custom Mappings Example 1
-------------------------
This example mapping produces the ``gl_stream_incoming_messages`` metric in Prometheus, which shows the number of
messages received by for each stream in Graylog.

The standard metric in Graylog contains the ID of the stream, and one metric is recorded for each stream.

For example::

    org.graylog2.plugin.streams.Stream.stream-1.incomingMessages
    org.graylog2.plugin.streams.Stream.stream-2.incomingMessages
    org.graylog2.plugin.streams.Stream.stream-3.incomingMessages

The mapping definition that follows provides a ``match_pattern`` with a wildcard ``*`` for the stream-id, which
provides one label for each stream id automatically. This allows for the visualization of messages received for all
streams together, but broken-out by stream-id.

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
Labels are a very effective way to consolidate and visualize like data together in Prometheus.

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
By default, custom and core mappings are refreshed (re-read from disk) every 30 seconds. You can override this with a
custom duration if desired. Use the standard Graylog duration notation (eg ``60s``, ``5m`` or ``1h``)

.. code-block::

    prometheus_exporter_mapping_file_refresh_interval = 5m