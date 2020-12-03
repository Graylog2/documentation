.. _enterprise-setup:

*****
License
*****

License Installation
====================

The Graylog Enterprise plugins require a valid license to use the additional features.

Once you have `obtained a license <https://www.graylog.org/enterprise/>`_
you can import it into your Graylog setup by going through the following steps.

#. As an admin user, open the "Enterprise/License" page from the menu in the web interface.
#. Click the Import new license button in the top right hand corner.
#. Copy the license text from the confirmation email and paste it into the text field.
#. The license should be valid and a preview of your license details should appear below the text field.
#. Click Import to activate the license.

The license automatically applies to all nodes in your cluster without the need to restart your server nodes.

.. note:: If there are errors, please check that you copied the entire license from the email without line breaks.
          The same license is also attached as a text file in case it is wrongly formatted in the email.

.. image:: /images/enterprise-license-1.png


License Verification
====================

Some Graylog licenses require to check their validity on a regular basis. This includes the free Graylog Enterprise license with a specific amount of traffic included.

If your network environment requires Graylog to use a proxy server in order to communicate with the external services via HTTPS, you'll have to configure the proxy server in the :ref:`Graylog configuration file<http_config>`.

The Graylog web interface shows all details about the license, but if you are still unclear about the requirements, please contact our `sales team <https://www.graylog.org/contact-sales>`_ with your questions.


Details on License Verification
-------------------------------

Graylog Enterprise periodically sends the following information to
'api.graylog.com' via HTTPS on TCP port 443 for each installed
license:

* A nonce to avoid modified reports
* The ID of the license
* The ID of the Graylog cluster
* A flag indicating if the license is violated
* A flag indicating if the license has expired
* A flag indicating if Graylog detected that the traffic measuring mechanisms have been modified
* A list of how much traffic was received and written by Graylog in the recent days, in bytes

Details on licensed traffic
---------------------------

Graylog has four counters, only the last is counted for the licensed traffic.

- ``org.graylog2.traffic.input``
   the incoming message without any decoding, what is written to the journal before any processing.
- ``org.graylog2.traffic.decoded``
   the message after the codec of the input has parsed the message (for example syslog parser)
- ``org.graylog2.traffic.system-output-traffic``
   currently, this is stored in memory only and includes the traffic from archive restores.
- ``org.graylog2.traffic.output``
   what is written to Elasticsearch after all processing is done.

Only the Elasticsearch output is measured, all other outgoing traffic does not count.  The measurement happens when the message is serialized to elasticsearch. If a message is written to multiple indices the message will count for each index. It does not matter how many copies (replicas) the index has configured as this is done in elasticsearch.

Each of the counters follows these rules:

- count the length of the field name.
- If the content of the field is a string, the length of the string is counted not the bytes of that string
- for non-string content in the field, the byte length of that content is counted
    - byte = 1 byte
    - char/short = 2 bytes
    - bool/int/floar = 4 bytes
    - long/double = 8 bytes
    - dates = 8 bytes
- all internal fields are not countent (those meta information that are created by Graylog)
