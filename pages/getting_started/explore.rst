Explore Graylog
---------------

Once messages are being received, you may want to poke around and explore a bit. There are several pages available, though not all pages may be visible to all users, depending on individual permissions. The following is a brief description of each page’s purpose and function.  
 
Streams
^^^^^^^

Streams are a core feature of Graylog and may be thought of as a form of tagging for incoming messages. Streams are a mechanism used to route messages into categories in real-time. Stream rules instruct Graylog which message to route into which streams. 

Streams have many uses. First, they are used to route data for storage into an index. They are also used to control access to data, route messages for parsing, enrichment or other modification and determine which messages will be archived. 

Streams may be used in conjunction with Alerts to notify users or otherwise respond when a message meets a set of conditions. 

Messages may belong to one or to multiple streams. For additional detail, please see :ref:`streams`.


Searches
^^^^^^^^

The Graylog Search page is the interface used to search logs directly. Graylog uses a simplified syntax, very similar to Lucene. Relative or absolute time ranges are configurable from drop down menus. Searches may be saved or visualized as dashboard widgets that may be added directly to dashboards from within the search screen. 

Users may configure their own views and may choose to see either summary or complete data from event messages. 

For additional detail, please see :ref:`queries`.


Dashboards
^^^^^^^^^^

Graylog Dashboards are visualizations or summaries of information contained in log events. Each dashboard is populated by one or more widgets. Widgets visualize or summarize event log data with data derived from field values such as counts, averages, or totals. Trend indicators, charts, graphs, and maps are easily created to visualize the data. 

Dashboard widgets and dashboard layouts are configurable. Dashboard access is controlled via Graylog’s role based access control. Dashboards may be imported and exported via content packs. 

For additional detail, please see :ref:`dashboards`.


Alerts
^^^^^^

Alerts are composed of two related elements, alert conditions and alert notifications. Alert conditions are tied to streams and may be based on the content of a field, the aggregated value of a field, or message count thresholds. An alert notification triggers when a condition is met, typically sending an email or HTTP call back to an analyst or another system. 

Additional output types may also be created via plugins. Alerts may be imported and exported via content packs. 

For additional detail, please see :ref:`alerts`.


.. Views
.. ^^^^^
.. **Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae luctus arcu, nec semper risus. Ut quis tellus imperdiet, euismod justo at, dignissim mauris. Ut diam nulla, semper eu ex nec, sagittis pulvinar magna. Nulla laoreet nisl id urna tristique, ac pellentesque elit lobortis. Quisque luctus iaculis ligula, a varius sem placerat a. Aenean dictum pulvinar erat eget cursus. Aenean faucibus libero vel risus consectetur laoreet. Nulla facilisi. Donec sed ex nec metus lacinia sodales et at ipsum. Pellentesque id vulputate nisl, eget condimentum enim.**

.. For more details, please see :ref:`views` 


System
^^^^^^

Overview
""""""""

The Overview page displays information relating to the administration of the Graylog instance. It contains information on system notifications, system job status, ingestion rates, Elasticsearch cluster health, indexer failures, Time configuration and the system event messages.


Configuration
"""""""""""""

The Configuration page allows users to set options or variables related to searches, message processors and plugins.

Nodes
"""""

The Nodes page contains summary status information for each Graylog node. Detailed health information and metrics are available from buttons displayed on this page.

Inputs
""""""

Usually the first thing configured after initial system setup, Inputs are used to tell Graylog on which port to listen or how to go and retrieve event logs. The Inputs page allows users to create and configure new inputs, to manage extractors, to start and stop inputs, get metrics for each input and to add static fields to incoming messages. 

Outputs
"""""""

Outputs are used to define methods of forwarding data to remote systems, including port, protocol and any other required information. Out of the box, Graylog supports STDOUT and GELF outputs, but users may write their own and more are available in the :ref:`marketplace`.

Authentication
""""""""""""""

The Authentication page is used to configure Graylog's authentication providers and manage the active users of this Graylog cluster. Graylog supports LDAP or Active Directory for both authentication and authorization.

Content Packs
"""""""""""""

Content packs accelerate the set-up process for a specific data source. A content pack can include inputs/extractors, streams, dashboards, alerts and pipeline processors. 

Any program element created within Graylog may be exported as Content Packs for use on other systems. These may be kept private by the author, for use in quick deployment of new nodes internally, or may be shared with the community via the Graylog Marketplace. For example, users may create custom Inputs, Streams, Dashboards, and Alerts to support a security use case. These elements may be exported in a content pack and then imported on a newly  installed Graylog instance to save configuration time and effort. 

Users may download content packs created and shared by other users via the :ref:`marketplace`. User created content packs are not supported by Graylog, but instead by their authors.

**List of Elements Supported in Content Packs**

* Inputs
* Grok Patterns
* Outputs
* Streams
* Dashboards
* Lookup Tables
* Lookup Caches
* Lookup Data Adapters


Indices
"""""""

An Index is the basic unit of storage for data in Elasticsearch.  Index sets provide configuration for retention, sharding, and replication of the stored data. 

Values, like retention and rotation strategy, are set on a per index basis, so different data may be subjected to different handling rules. 

For more details, please see :ref:`index_model`.

Sidecars
""""""""

Graylog created the Sidecar agent to manage fleets of log shippers like Beats or NXLog. These log shippers are used to collect OS logs from Linux and Windows servers. Log shippers are often the simplest way to read logs written locally to a flat file and send them to a centralized log management solution. Graylog supports management of any log shipper as a backend.

For more details, please see :ref:`graylog-sidecar`.



Pipelines
"""""""""

Graylog’s Processing Pipelines are a powerful feature that enables user to run a rule, or a series of rules, against a specific type of event. Tied to streams, pipelines allow for routing, blacklisting, modifying and enriching messages as they flow through Graylog. Basically, if you want to parse,
change, convert. add to, delete from or drop a message, Pipelines are the place to do it.

For more details, please see :ref:`pipelinestoc`.
