.. _configuring_webif:

*************
Web interface
*************

When your Graylog instance/cluster is up and running, the next thing you usually want to do is check out our web interface, which offers you great capabilities for searching and analyzing your indexed data and configuring your Graylog environment. Per default you can access it using your browser on ``http://<graylog-server>:9000/api/``.


Overview
========

The Graylog web interface was rewritten in JavaScript for 2.0 to be a client-side single-page browser application. This means its code is running solely in your browser, fetching all data via HTTP(S) from the REST API of your Graylog server.

.. note:: Both the web interface URI (see ``web_listen_uri``) and the REST API (see ``rest_listen_uri`` and ``rest_transport_uri``) must be accessible by everyone using the web interface. This means that Graylog *must* listen on a public network interface *or* be exposed to one using a proxy or NAT!

Single or separate listeners for web interface and REST API?
============================================================

Since Graylog 2.1 you have two options when it comes to exposing its web interface:

 - Running both on the same port, using different paths (defaulting to ``http://localhost:9000/api/`` for the REST API and ``http://localhost:9000/`` for the web interface), this is the default since 2.1 and is assumed for most parts of the documentation.
 - Running on two different ports (for example ``http://localhost:12900/`` for the REST API and ``http://localhost:9000/`` for the web interface)

.. note:: When you are using the first option and you want to run the REST API and the web interface on the same host and port, the path part of both URIs (``rest_listen_uri`` & ``web_listen_uri``) must be different and the path part of ``web_listen_uri`` must be non-empty and different than ``/``.

Configuration Options
=====================

If our default settings do not work for you, there is a number of options in the Graylog server configuration file which you can change to influence its behavior:

+-------------------------+---------------------------------+----------------------------------------------------------------------+
| Setting                 | Default                         | Explanation                                                          |
+=========================+=================================+======================================================================+
| ``web_enable``          | true                            | Determines if the web interface endpoint is started or not.          |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_listen_uri``      | http://127.0.0.1:9000/          | Default address the web interface listener binds to.                 |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_endpoint_uri``    | If not set,                     | This is the external address of the REST API of the Graylog server.  |
|                         | ``rest_transport_uri``          | Web interface clients need to be able to connect to this for the web |
|                         | will be used.                   | interface to work.                                                   |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_enable_cors``     | false                           | Support Cross-Origin Resource Sharing for the web interface assets.  |
|                         |                                 | Not required, because no REST calls are made to this listener.       |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_enable_gzip``     | true                            | Serve web interface assets using compression.                        |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_enable_tls``      | false                           | Should the web interface serve assets using encryption or not.       |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_tls_cert_file``   | (no default)                    | Path to TLS certificate file, if TLS is enabled.                     |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_tls_key_file``    | (no default)                    | Path to private key for certificate, used if TLS is enabled.         |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_tls_key_password``| (no default)                    | Password for TLS key (if it is encrypted).                           |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+
| ``web_thread_pool_size``| 16                              | Number of threads used for web interface listener.                   |
|                         |                                 | This setting is ignored, if the host and port parts of               |
|                         |                                 | ``web_listen_uri`` and ``rest_listen_uri`` are identical.            |
+-------------------------+---------------------------------+----------------------------------------------------------------------+

.. _webif_connecting_to_server:

How does the web interface connect to the Graylog server?
=========================================================

The web interface is fetching all information it is showing from the REST API of the Graylog server. Therefore it needs to connect to it using HTTP(S). There are several ways how you can define which way the web interface connects to the Graylog server. The URI used by the web interface is determined in this exact order:

  - If the HTTP(S) client going to the web interface port sends a ``X-Graylog-Server-URL`` header, which contains a valid URL, then this is overriding everything else.
  - If ``web_endpoint_uri`` is defined in the Graylog configuration file, this is used if the aforementioned header is not set.
  - If both are not defined, ``rest_transport_uri`` is used.


Browser Compatibility
=====================

Writing the web interface as a single-page application is a challenging task. We want to provide the best possible experience to everyone, which often means using modern web technology only available in recent browsers, while keeping a reasonable compatibility with old and less-capable browsers. These browsers are officially supported in Graylog 2.0:

+-------------------+----------------------+-----------------+
| Browser           | OS                   | Minimum Version |
+===================+======================+=================+
| Chrome            | Windows, OS X, Linux | 50              |
+-------------------+----------------------+-----------------+
| Firefox           | Windows, OS X, Linux | 45 / 38 ESR     |
+-------------------+----------------------+-----------------+
| Internet Explorer | Windows              | 11              |
+-------------------+----------------------+-----------------+
| Microsoft Edge    | Windows              | 25              |
+-------------------+----------------------+-----------------+
| Safari            | OS X                 | 9               |
+-------------------+----------------------+-----------------+

Please take into account that you need to enable JavaScript in order to use Graylog web interface.

.. _configuring_webif_nginx:

Making the web interface work with load balancers/proxies
=========================================================

If you want to run a load balancer/reverse proxy in front of Graylog, you need to make sure that:

  - The REST API port is accessible for clients
  - The address for the Graylog server's REST API is properly set (as explained in :ref:`webif_connecting_to_server`), so it is resolvable and accessible for any client of the web interface.
  - You are either using only HTTP or only HTTPS (no mixed content) for both the web interface endpoint and the REST API endpoint.
  - If you use SSL, your certificates must be valid and trusted by your clients.

.. NOTE:: To help you with your specific environment, we have some example configurations. We take the following assumption in all examples. Your Graylog server.conf has the following settings set ``rest_listen_uri = http://127.0.0.1:9000/api/`` and ``web_listen_uri = http://127.0.0.1:9000/``. Your URL will be ``graylog.example.org`` with the IP ``192.168.0.10``.


Using a Layer 3 load balancer (forwarding TCP Ports)
----------------------------------------------------

#. Configure your load balancer to forward connections going to ``192.168.0.10:80`` to ``127.0.0.1:9000`` (``web_listen_uri``) and ``192.168.0.10:9000/api/`` to ``127.0.0.1:9000/api/`` (``rest_listen_uri``).
#. Set ``web_endpoint_uri`` in your Graylog server config to ``http://graylog.example.org:9000/api/``.
#. Start the Graylog server as usual.
#. Access the web interface on ``http://graylog.example.org``.
#. Read up on :ref:`ssl_setup`.

NGINX
-----

**REST API and Web Interface on one port (using HTTP)**::

    server
    {
      listen      80 default_server;
      listen      [::]:80 default_server ipv6only=on;
      server_name graylog.example.org;

      location /
        {
            proxy_set_header    Host $http_host;
            proxy_set_header    X-Forwarded-Host $host;
            proxy_set_header    X-Forwarded-Server $host;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    X-Graylog-Server-URL http://graylog.example.org/api;
            proxy_pass          http://127.0.0.1:9000;
        }
    }


NGINX can be used for SSL Termination, you would only need to modify the ``server listen`` directive and add all Information about your certificate.

If you are running multiple Graylog Server you might want to use HTTPS/SSL to connect to the Graylog Servers (on how to Setup read :ref:`ssl_setup`) and use HTTPS/SSL on NGINX. The configuration for TLS certificates, keys and ciphers is omitted from the sample config for brevity's sake.

**REST API and Web Interface on one port (using HTTPS/SSL)**::

    server
    {
        listen      443 ssl spdy;
        server_name graylog.example.org;
        # <- your SSL Settings here!

        location /
        {
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    Host $http_host;
            proxy_set_header    X-Graylog-Server-URL https://graylog.example.org/api;
            proxy_pass          http://127.0.0.1:9000;
        }
    }

Apache httpd 2.x
----------------

**REST API and Web Interface on one port (using HTTP)**::

    <VirtualHost *:80>
        ServerName graylog.example.org
        ProxyRequests Off
        <Proxy *>
            Order deny,allow
            Allow from all
        </Proxy>

        <Location />
            RequestHeader set X-Graylog-Server-URL "http://graylog.example.org/api/"
            ProxyPass http://127.0.0.1:9000/
            ProxyPassReverse http://127.0.0.1:9000/
        </Location>

    </VirtualHost>


HAProxy 1.6
-----------

**REST API and Web Interface on one port (using HTTP)**::

    frontend http
        bind 0.0.0.0:80

        option forwardfor
        http-request add-header X-Forwarded-Host %[req.hdr(host)]
        http-request add-header X-Forwarded-Server %[req.hdr(host)]
        http-request add-header X-Forwarded-Port %[dst_port]
        acl is_graylog hdr_dom(host) -i -m str graylog.example.org
        use_backend	graylog	if is_graylog

    backend graylog
        description	The Graylog Web backend.
        http-request set-header X-Graylog-Server-URL http://graylog.example.org/api
        use-server graylog_1
        server graylog_1 127.0.0.1:9000 maxconn 20 check


**Multiple Backends (roundrobin) with Health-Check (using HTTP)**::

    frontend graylog_http
        bind *:80
        option forwardfor
        http-request add-header X-Forwarded-Host %[req.hdr(host)]
        http-request add-header X-Forwarded-Server %[req.hdr(host)]
        http-request add-header X-Forwarded-Port %[dst_port]
        acl is_graylog hdr_dom(host) -i -m str graylog.example.org
        use_backend     graylog

    backend graylog
        description     The Graylog Web backend.
        balance roundrobin
        option httpchk HEAD /api/system/lbstatus
        http-request set-header X-Graylog-Server-URL http://graylog.example.org/api
        server graylog1 192.168.0.10:9000 maxconn 20 check
        server graylog2 192.168.0.11:9000 maxconn 20 check
        server graylog3 192.168.0.12:9000 maxconn 20 check
