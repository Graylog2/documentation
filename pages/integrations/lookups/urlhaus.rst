.. _urlhaus:

********************************
URLhaus Malware URL Data Adapter
********************************

URLhaus is a project from `abuse.ch <https://urlhaus.abuse.ch>`_ which maintains
a database of malicious URLs being used for malware distribution.  When the data
adapter is created, the appropriate data set will be downloaded and stored in
MongoDB.  New data sets will be fetched based on the configured ``Refresh Interval``.

.. note:: This is a Graylog Enterprise Integrations feature and is only available since
  Graylog version 4.1. A valid Graylog Enterprise license is required.

Sample Lookup Data
------------------

A lookup for the URL ``http://192.168.100.100:35564/Mozi.m`` might produce the
following output::

  {
    "single_value": "malware_download",
    "multi_value": {
      "date_added": "2021-06-22T17:53:07.000+0000",
      "url_status": "online",
      "threat_type": "malware_download",
      "tags": "elf,Mozi",
      "url": "http://192.168.100.100:35564/Mozi.m",
      "urlhaus_link": "https://urlhaus.abuse.ch/url/1234567/"
    },
    "string_list_value": null,
    "has_error": false,
    "ttl": 9223372036854776000
  }

Data Adapter Configuration
--------------------------

- ``Title``
   - A short title for the data adapter
- ``Description``
   - A description of the data adapter
- ``Name``
   - A unique name which will be used to refer to the data adapter
- ``Custom Error TTL``
   - Optional custom TTL for caching erroneous results.  If no value is specified, the default value of 5 seconds will be used.
- ``URLhaus Feed Type``
	- This determines which URLhaus feed the data adapter will use
	- ``Online URLs`` is the smaller data set and includes only URLs that have been detected to be currently online
  - ``Recently Added URLs`` is the larger data set and includes all URLs added in the last 30 days whether online or offline
- ``Refresh Interval``
  - Determines how often new data will be fetched.  The minimum refresh interval is 300 seconds (5 minutes) because that is how often the source data can be updated
- ``Case Insensitive Lookups``
  - When selected, this will allow the data adapter to perform case insensitive lookups
