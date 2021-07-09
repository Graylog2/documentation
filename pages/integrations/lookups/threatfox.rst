.. _lookups_threatfox:

**********************************
ThreatFox IOC Tracker Data Adapter
**********************************

ThreatFox is a project from `abuse.ch <https://threatfox.abuse.ch>`_ which tracks
indicators of compromise (IOCs) associated with malware.  This Data Adapter
supports lookups by the following key types:

* URL
* Domain
* IP:port
* MD5 hash
* SHA256 hash

When the data adapter is created, the appropriate data set will be downloaded
and stored in MongoDB.  New data sets will be fetched based on the configured
``Refresh Interval``.

.. note:: This is a Graylog Enterprise Integrations feature and is only available since
  Graylog version 4.1.1. A valid Graylog Enterprise license is required.

Sample Lookup Data
------------------

A lookup for the file hash ``923fa80da84e45636a62f779913559a07420a1c6e21f093d87ddfe04bda683c4``
might produce the following output::

  {
    "first_seen_utc": "2021-07-07T17:03:57.000+0000",
    "ioc_id": "158365",
    "ioc_value": "923fa80da84e45636a62f779913559a07420a1c6e21f093d87ddfe04bda683c4",
    "ioc_type": "sha256_hash",
    "threat_type": "payload",
    "fk_malware": "win.agent_tesla",
    "malware_alias": [
      "AgenTesla",
      "AgentTesla",
      "Negasteal"
    ],
    "malware_printable": "Agent Tesla",
    "confidence_level": 50,
    "reference": "https://twitter.com/RedBeardIOCs/status/1412819661419433988",
    "tags": [
      "agenttesla"
    ],
    "anonymous": false,
    "reporter": "Virus_Deck"
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
- ``Include IOCs Older Than 90 Days``
   - In order to avoid false positives, IOCs older than 90 days should be handled carefully. By default, IOCs older than 90 days will not be included in the Data Adapter's data.  When this option is selected, IOCs older than 90 days will be included.
- ``Refresh Interval``
  - Determines how often new data will be fetched.  The minimum refresh interval is 3600 seconds (1 hour) because that is how often the source data is updated.
- ``Case Insensitive Lookups``
  - When selected, this will allow the data adapter to perform case insensitive lookups.
