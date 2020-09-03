.. _output_tcp_syslog:

****************************
Enterprise TCP Syslog Output
****************************

This Output allows you to send data as UTF-8 encoded text to an arbitrary TCP Syslog 
receiver.  The formatted payload will be sent as as the ``MSG`` portion of a standard 
Syslog message per section 6.4 of the `Syslog specification <https://tools.ietf.org/html/rfc5424>`_.

.. note:: This is an Enterprise Integrations feature and is only available since Graylog 
          version 3.3.3, thus an Enterprise license is required. See the 
          :doc:`Integrations Setup <../setup>` page for more info.
          
Output Configuration
--------------------

The TCP Syslog Output supports all of the standard Enterprise Output Framework 
`configuration options <../output_framework.html#general-configuration>`__.

TCP Configuration
^^^^^^^^^^^^^^^^^
 See: `TCP Configuration <output_tcp_raw.html#tcp-configuration>`__

TCP Syslog Configuration
^^^^^^^^^^^^^^^^^^^^^^^^

- ``Syslog Facility``
   - A numeric value in the range of 0 - 23 (inclusive)
   - Defined in `Section 6.2.1 <https://tools.ietf.org/html/rfc5424#section-6.2.1>`_ of the Syslog specification.
- ``Syslog Severity``
   - A numeric value in the range of 0 - 7 (inclusive)
   - Defined in `Section 6.2.1 <https://tools.ietf.org/html/rfc5424#section-6.2.1>`_ of the Syslog specification.

