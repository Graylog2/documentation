.. _output_tcp_raw:

************************
Raw/Plaintext TCP Output
************************

This Output allows you to send data as UTF-8 encoded text to an arbitrary TCP endpoint 
(server and port).

.. note:: This is an Enterprise Integrations feature and is only available since Graylog 
          version 3.3.3, thus an Enterprise license is required. See the 
          :doc:`Integrations Setup <../setup>` page for more info.
          
Output Configuration
--------------------

The Raw/Plaintext TCP Output supports all of the standard Enterprise Output Framework 
`configuration options <../output_framework.html#general-configuration>`__.


TCP Configuration
^^^^^^^^^^^^^^^^^

- ``Destination IP Address``
   - The IP address of the system which will receive the messages.
- ``Destination Port``
   - The port on which the destination system will listen for messages.
- ``Frame Delimiting Method``
   - The method which will be used to separate individual messages  in the stream.
   - Frame delimiting methods are defined in Sections 3.4.1 and 3.4.2 of `IETF RFC 6587 <https://tools.ietf.org/html/rfc6587>`_.
      - ``Newline Character`` A newline character will be appended to each message to mark the end of the message. Any newline characters within the message will be escaped prior to sending.
      - ``Null Character`` A null character will be appended to each message to mark the end of  the message. Any null characters within the message will be escaped prior to sending.
      - ``Octet Counting`` The length of the message (in bytes) and a space character for separation will be prepended to the message.  The contents of the message will not be altered.
