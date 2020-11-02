.. _lookuptables:

*************
Lookup Tables
*************

Graylog 2.3 introduced the lookup tables feature. It allows you to lookup/map/translate
message field values into new values and write them into new message fields or
overwrite existing fields.
A simple example is to use a static CSV file to map IP addresses to host names.

Components
----------

The lookup table systems consists of four components.

- Data adapters
- Caches
- Lookup tables
- Lookup results

Data Adapters
^^^^^^^^^^^^^

Data adapters are used to do the actual lookup for a value. They might read
from a CSV file, connect to a database or execute HTTP requests to receive
the lookup result.

Data adapter implementations are pluggable and new ones can be added through plugins.

Caches
^^^^^^

The caches are responsible for caching the lookup results to improve the lookup
performance and/or to avoid overloading databases and APIs. They are separate
entities to make it possible to reuse a cache implementation for different
data adapters. That way, the data adapters do not have to care about caching
and do not have to implement it on their own.

Cache implementations are pluggable and new ones can be added through plugins.

.. important:: The CSV file adapter reads the entire contents of the file into
               HEAP memory. Ensure that you size the HEAP accordingly.

.. note:: The CSV file adapter refreshes its contents within each check interval
          if the file was changed. If the cache was purged but the check interval
          has not elapsed, lookups might return expired values.

Lookup Tables
^^^^^^^^^^^^^

The lookup table component ties together a data adapter instance and a cache
instance. It is needed to actually enable the usage of the lookup table in
extractors, converters, pipeline functions and decorators.

Lookup Results
^^^^^^^^^^^^^^

The lookup result is returned by a lookup table through the data adapter and
can contain two types of data. A **single value** and a **multi value**.

The **single value** can be a string, number or boolean and will be used in
extractors, converters, decorators and pipeline rules. In our CSV example to
lookup host names for IP addresses, this would be the host name string.

A **multi value** is a map/dictionary-like data structure and can contain
several different values. This is useful if the data adapter can provide
multiple values for a key. A good example for this would be the geo-ip data
adapter which does not only provide the latitude and longitude for an IP
address, but also information about the city and country of the location.
Currently, the multi value can only be used in a pipeline rule when using the
``lookup()`` pipeline function.

**Example 1:** Output for a CSV data adapter including a single value
and a multi value.

.. image:: /images/lookuptables/example-single-value.png

**Example 2:** Output for the geo-ip data adapter including a single value
and a multi value.

.. image:: /images/lookuptables/example-multi-value.png

.. _lookuptables_setup:

Setup
-----

The lookup tables can be configured on the "System/Lookup Tables" page.

You need to create at least one data adapter and one cache before you can
create your first lookup table. The following example setup creates a
lookup table with a CSV file data adapter and an in-memory cache.


Create Data Adapter
^^^^^^^^^^^^^^^^^^^

Navigate to "System/Lookup Tables" and click the "Data Adapters" button in the
top right corner. Then you first have to select a data adapter type.

Every data adapter form includes data adapter specific documentation that
helps you to configure it correctly.

.. image:: /images/lookuptables/setup-data-adapter.png

Create Cache
^^^^^^^^^^^^

Navigate to "System/Lookup Tables" and click the "Caches" button in the
top right corner. Then you first have to select a cache type.

Every cache form includes cache specific documentation that helps you to
configure it correctly.

.. image:: /images/lookuptables/setup-cache.png

Create Lookup Table
^^^^^^^^^^^^^^^^^^^

Now you can create a lookup table with the newly created data adapter and
cache by navigating to "System/Lookup Tables" and clicking "Create lookup table".

Make sure to select the data adapter and cache instances in the creation form.

.. image:: /images/lookuptables/setup-table.png

Default Values
~~~~~~~~~~~~~~

Every lookup table can optionally be configured with default values which will
be used if a lookup operation does not return any result.

.. image:: /images/lookuptables/setup-table-defaults.png


.. _lookuptables_usage:

Usage
-----

Lookup tables can be used with the following Graylog components.

- Extractors
- Converters
- Decorators
- Pipeline rules

Extractors
^^^^^^^^^^

A lookup table extractor can be used to lookup the value of a message field
in a lookup table and write the result into a new field or overwrite an
existing field.

.. image:: /images/lookuptables/usage-extractor.png

Converters
^^^^^^^^^^

When you use an extractor to get values out of a text message, you can use a
lookup table converter to do a lookup on the extracted value.

.. image:: /images/lookuptables/usage-converter.png

Decorators
^^^^^^^^^^

A lookup table decorator can be used to enrich messages by looking up values
at search time.

.. image:: /images/lookuptables/usage-decorator.png

Pipeline Rules
^^^^^^^^^^^^^^

There are two lookup functions that can be used in a pipeline rule,
``lookup()`` and ``lookup_value()``. The first returns the **multi value** data
of the lookup result, the second returns the **single value**.

.. image:: /images/lookuptables/usage-pipeline-rule.png

Built-in Data Adapters
----------------------

The following Data Adapters are shipped with Graylog by default. Detailed on-screen documentation for each is available
on the Add/Edit Data Adapter page in Graylog.

CSV File Adapter
^^^^^^^^^^^^^^^^

Performs key/value lookups from a CSV file.

DNS Lookup Adapter
^^^^^^^^^^^^^^^^^^

Provides the ability to perform the following types of DNS resolutions:

- Resolve hostname to IPv4 address (A records)
- Resolve hostname to IPv6 address (AAAA records)
- Resolve hostname to IPv4 and IPv6 address (A and AAAA records)
- Reverse lookup (PTR record)
- Text lookup (TXT records)

DSV File from HTTP Adapter
^^^^^^^^^^^^^^^^^^^^^^^^^^

Performs key/value from a DSV file. This adapter supports more advanced customization than the
CSV File adapter (such a custom delimiter and customizable key/value columns).

HTTP JSONPath Adapter
^^^^^^^^^^^^^^^^^^^^^

Executes HTTP GET requests to lookup a key and parses the result based on configured JSONPath expressions.

Geo IP - MaxMind Databases
^^^^^^^^^^^^^^^^^^^^^^^^^^

Provides the ability to extract geolocation information of IP addresses
from MaxMind ASN, Country and City databases.


.. _lookuptable_enterprise:

Enterprise Data Adapters
------------------------

Graylog Enterprise brings another Lookup Table Data Adapter.

.. _lookuptable_mongodb:

MongoDB
-------

This data adapter stores its keys and values in the Graylog configuration database.
The entries of the database can be altered via pipeline functions and HTTP Rest API calls.
That way you can alter the result of the lookup table call based on incoming logs or
from an external source.

Alter from HTTP Rest API
^^^^^^^^^^^^^^^^^^^^^^^^
For a detail look on how to interact with the MongoDB Data Adapter please have a look
at the :ref:`API browser<configuring_api>` at ``api/api-browser/#!/Plugins/MongoDBDataAdapter``.
There you can see that you can add, update, list and delete key value pairs of the data adapter.

Here an example on how to add a key to an mongodb adapter with an api token::

    curl -u d2tirtpunshmgdsbq5k3j0g4ku230ggruhsqpa0iu7mj1lia55i:token \
      -H 'X-Requested-By: cli' -H 'Accept: application/json' \
      -X POST 'http://127.0.0.1:9000/api/plugins/org.graylog.plugins.lookup/lookup/adapters/mongodb/mongodb-data-name' \
      -H 'Content-Type: application/json' \
      --data-binary $'{\n"key": "myIP",\n"values": ["12.34.42.99"],\n"data_adapter_id":"5e578606cdda4779dd9f2611"\n}'

Alter from Pipeline Function
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A reference of the pipeline functions handling the lookup table values can be found in
the :ref:`pipeline rules functions<pipeline_functions>` section of the documentation.

Alter from GUI
^^^^^^^^^^^^^^
The values of the mongodb adapter can also be altered directly via the GUI.

.. image:: /images/alter-mongodb-data-adapter.png

.. attention:: To add multiple values for one key, you need to separate the values by new lines.