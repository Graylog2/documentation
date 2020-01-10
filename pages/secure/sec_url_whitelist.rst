.. _sec_url_whitelist:

*******************************
The URL whitelist
*******************************

There are certain components in Graylog which will perform outgoing HTTP requests. Among those, are event notifications
and HTTP-based data adapters.

Allowing Graylog to interact with resources using arbitrary URLs may pose a security risk. HTTP requests are executed
from Graylog servers and might therefore be able to reach more sensitive systems than an external user would have
access to, including AWS EC2 metadata, which can contain keys and other secrets, Elasticsearch and others.

It is therefore advisable to restrict access by explicitly whitelisting URLs which are considered safe. HTTP requests
will be validated against the whitelist and are prohibited if there is no whitelist entry matching the URL.

Configuring the whitelist
=========================

The whitelist configuration is located at ``System/Configurations``.

.. image:: /images/url_whitelist.png

Disabling the whitelist
-----------------------

If the security implications mentioned above are of no concern, the whitelist can be disabled. When disabled, HTTP
requests will not be restricted.

"Exact match" whitelist entries
-------------------------------

Whitelist entries of type ``Exact match`` contain a string which will be matched against a URL by direct comparison. If
the URL is equal to this string, it is considered to be whitelisted.

"Regex" whitelist entries
-------------------------

Whitelist entries of type ``Regex`` contain a regular expression. If a URL matches the regular expression, the URL is
considered to be whitelisted. Graylog uses the
`Java Pattern class <http://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html>`_ to evaluate regular
expressions.
