.. _ipfix_input:

***********
IPFIX Input
***********

.. note:: This input is available since Graylog version 3.2 Installation of an additional ``graylog-integrations-plugins`` package is required. See the :doc:`Integrations Setup <../setup>` page for more info.

This input allows Graylog to read ipfix logs. By default the input supports all the standard `IANA fields <https://www.iana.org/assignments/ipfix/ipfix.xhtml>`_ .

IPFIX Field Definitions
=======================
Any additional field that are being collected that are vendor/hardware specific need to be defined in a json file.
This file needs to provide the `private enterprise number <https://www.iana.org/assignments/enterprise-numbers/enterprise-numbers>`_ , as well as the additional field definitions that are being collected.
The example below is how the json file needs to be structured.

Example of JSON file
^^^^^^^^^^^^^^^^^^^^
The filepath of the json file with the additional field being collected need to be provided in the IPFIX field definitions option when creating the input.

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
      "data_type": "ABSTRACT DATA TYPE"
    }
    ]
  }

`IPFIX Data Types <https://www.iana.org/assignments/ipfix/ipfix.xhtml#ipfix-information-element-data-types>`_

.. image:: /images/ipfix_data_types.png
    :width: 500


.. image:: /images/ipfix.png



