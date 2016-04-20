.. _configuring_webif:

***************************************
Configuring and using the web interface
***************************************

When your Graylog instance/cluster is up and running, the next thing you usually want to do is check out our web interface, which offers you great capabilities for searching and analyzing your indexed data and configuring your Graylog environment. Per default you can access it using your browser on ``http://<graylog-server>:9000``.

Overview
========

The Graylog web interface was rewritten in JavaScript for 2.0 to be a client-side single-page browser application. This means its code is running solely in your browser, fetching all data via HTTP(S) from the REST API of your Graylog server. Therefore there is a second HTTP listener which is serving the assets for the web interface (all JavaScript, fonts, images, CSS files) to the clients.

**Both the web interface port (defaulting to 9000) and the REST API port (defaulting to 12900) must be accessible by everyone using the web interface.**

Configuration Options
=====================

If our default settings do not work for you, there is a number of options in the Graylog server configuration file which you can change to influence its behavior:

+-------------------------+-------------------------+----------------------------------------------------------------------+
| Setting                 | Default                 | Explanation                                                          |
+=========================+=========================+======================================================================+
| ``web_enable``          | true                    | Determines if the web interface endpoint is started or not.          |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_listen_uri``      | http://127.0.0.1:9000/  | Default address the web interface listener binds to.                 |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_endpoint_uri``    | If not set,             | This is the external address of the REST API of the Graylog server.  |
|                         | ``rest_transport_uri``  | Web interface clients need to be able to connect to this for the web |
|                         | will be used.           | interface to work.                                                   |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_enable_cors``     | false                   | Support Cross-Origin Resource Sharing for the web interface assets.  |
|                         |                         | Not required, because no REST calls are made to this listener.       |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_enable_gzip``     | true                    | Serve web interface assets using compression.                        |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_enable_tls``      | false                   | Should the web interface serve assets using encryption or not.       |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_tls_cert_file``   | (no default)            | Path to TLS certificate file, if TLS is enabled.                     |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_tls_key_file``    | (no default)            | Path to private key for certificate, used if TLS is enabled.         |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_tls_key_password``| (no default)            | Password for TLS key (if it is encrypted).                           |
+-------------------------+-------------------------+----------------------------------------------------------------------+
| ``web_thread_pool_size``| 16                      | Number of threads used for web interface listener.                   |
+-------------------------+-------------------------+----------------------------------------------------------------------+

.. _webif_connecting_to_server:

How does the web interface connects to the Graylog server?
==========================================================

The web interface is fetching all information it is showing from the REST API of the Graylog server. Therefore it needs to connect to it using HTTP(S). There are several ways how you can define which way the web interface connects to the Graylog server:

  - If the HTTP(S) client going to the web interface port sends a ``X-Graylog-Server-URL`` header, which contains a valid URL, then this is overriding everything else.
  - If ``web_endpoint_uri`` is defined in the Graylog configuration file, this is used if the aforementioned header is not set.
  - If both are not defined, ``rest_transport_uri`` is used.

Browser Compatibility
=====================


SSL Setup
=========

We highly recommend securing your Graylog installation using SSL/TLS to make sure that no sensitive data is sent over the wire in plain text. To make this work, you need to do two things:

  - Enable TLS for the Graylog REST API (``rest_enable_tls``)
  - Enable TLS for the web interface endpoint (``web_enable_tls``)

You also need to make sure that you have proper certificates in place, which are valid and trusted by the clients. Not enabling TLS for either one of them will result in a browser error about mixed content and the web interface will cease to work.

Certificate/Key file format
---------------------------

When you are configuring TLS, you need to make sure that your certificate/key files are in the right format, which is X.509 for certificates and PKCS#8 for the private keys. Both must to be stored in PEM format.

Making the web interface work with load balancers/proxies
=========================================================

If you want to run a load balancer/reverse proxy in front of Graylog, you need to make sure that:

  - The REST API port is still accessible for clients
  - The address for the Graylog server's REST API is properly set (as explained in :ref:`webif_connecting_to_server`), so it is resolvable and accessible for any client of the web interface.
  - You are either using only HTTP or only HTTPS (no mixed content) for both the web interface endpoint and the REST API endpoint.
  - If you use SSL, your certificates must be valid and trusted by your clients.

To help you with your specific environment, these are some example configurations for common scenarios:

NGINX:
------

AWS Elastic Load Balancing:
---------------------------
