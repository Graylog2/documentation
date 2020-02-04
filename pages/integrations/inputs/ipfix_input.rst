.. _ipfix_input:

***********
IPFIX Input
***********

.. note:: This input is available since Graylog version 3.2 Installation of an additional ``graylog-integrations-plugins`` package is required. See the :doc:`Integrations Setup <../setup>` page for more info.

This input allows Graylog to read ipfix logs.


IPFIX Field Definitions
=======================


Example of JSON file
^^^^^^^^^^^^^^^^^^^^
This plugin supports IPFIX as per `RFC 7011 <https://tools.ietf.org/html/rfc7011>`_.
For a complete list of the elements see `IPFIX Information Elements page <https://www.iana.org/assignments/ipfix/ipfix.xhtml>`_.

::

  {
    "enterprise_number": PRIVATE ENTERPRISE NUMBER,
    "information_elements": [
      {
        "element_id": ELEMENT ID NUMBER,
        "name": "NAME OF DEFINITION",
        "data_type": "ABSTRACT DATA TYPE"
      },
      ...
      ...
      ...
    {
      "element_id": ELEMENT ID NUMBER,
      "name": "NAME OF DEFINITIONt",
      "data_type": "basiclist"
    }
    ]
  }




.. image:: /images/ipfix.png


