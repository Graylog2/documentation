.. _configuring_webif:

*************
Web interface
*************

When your Graylog instance/cluster is up and running, the next thing you usually want to do is check out our web interface, which offers you great capabilities for searching and analyzing your indexed data and configuring your Graylog environment. Per default you can access it using your browser on ``http://<graylog-server>:9000/``.


Overview
========

The Graylog web interface was rewritten in JavaScript for 2.0 to be a client-side single-page browser application. This means its code is running solely in your browser, fetching all data via HTTP(S) from the REST API of your Graylog server.

.. note:: The HTTP address must be accessible by everyone using the web interface. This means that Graylog *must* listen on a public network interface *or* be exposed to one using a proxy, NAT or a load balancer!

Configuration Options
=====================

If our default settings do not work for you, there is a number of options in the Graylog server configuration file which you can change to influence its behavior:

+---------------------------+---------------------------------+----------------------------------------------------------------------+
| Setting                   | Default                         | Explanation                                                          |
+===========================+=================================+======================================================================+
| ``http_bind_address``     | 127.0.0.1:9000                  | The network interface used by the Graylog HTTP interface.            |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_publish_uri``      | If not set,                     | The HTTP URI of this Graylog node which is used to communicate with  |
|                           | ``http://$http_bind_address``   | the other Graylog nodes in the cluster and by all clients using the  |
|                           | will be used.                   | Graylog web interface.                                               |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_external_uri``     | If not set,                     | The public URI of Graylog which will be used by the Graylog web      |
|                           | ``$http_publish_uri``           | interface to communicate with the Graylog REST API.                  |
|                           | will be used.                   | Graylog web interface.                                               |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_enable_cors``      | true                            | This is necessary for JS-clients accessing the server directly.      |
|                           |                                 | If disabled, modern browsers will not be able to retrieve resources  |
|                           |                                 | from the server.                                                     |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_enable_gzip``      | true                            | Serve web interface assets using compression to reduce overall       |
|                           |                                 | roundtrip times.                                                     |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_max_header_size``  | 8192                            | The maximum size of the HTTP request headers in bytes.               |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_thread_pool_size`` | 16                              | The size of the thread pool used exclusively for serving the HTTP    |
|                           |                                 | interface.                                                           |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_enable_tls``       | false                           | This secures the communication with the HTTP interface with TLS to   |
|                           |                                 | prevent request forgery and eavesdropping.                           |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_tls_cert_file``    | (no default)                    | The X.509 certificate chain file in PEM format to use for securing   |
|                           |                                 | the HTTP interface.                                                  |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_tls_key_file``     | (no default)                    | The PKCS#8 private key file in PEM format to use for securing the    |
|                           |                                 | HTTP interface.                                                      |
+---------------------------+---------------------------------+----------------------------------------------------------------------+
| ``http_tls_key_password`` | (no default)                    | The password to unlock the private key used for securing the HTTP    |
|                           |                                 | interface. (only needed if the key is encryped)                      |
+---------------------------+---------------------------------+----------------------------------------------------------------------+

.. _webif_connecting_to_server:

How does the web interface connect to the Graylog server?
=========================================================

The web interface is fetching all information it is showing from the REST API of the Graylog server. Therefore it needs to connect to it using HTTP(S). There are several ways how you can define which way the web interface connects to the Graylog server. The URI used by the web interface is determined in this exact order:

  - If the HTTP(S) client going to the web interface port sends a ``X-Graylog-Server-URL`` header, which contains a valid URL, then this is overriding everything else.
  - If ``http_external_uri`` is defined in the Graylog configuration file, this is used if the aforementioned header is not set.
  - If ``http_publish_uri`` is defined in the Graylog configuration file, this is used if the aforementioned ``http_external_uri`` is not set.
  - If none of the above are defined, ``http://$http_bind_address`` is used.

The web interface assets (e.g. the ``index.html``, CSS and JavaScript files) are accessible at the URI root (``/`` by default) and the REST API endpoints are accessible at the ``/api`` path.

**Example:**

Setting ``http_bind_address`` to ``10.0.0.1:9000`` configures the Graylog server with the following URLs.

- Web interface: ``http://10.0.0.1:9000/``
- REST API: ``http://10.0.0.1:9000/api/``


Browser Compatibility
=====================

Writing the web interface as a single-page application is a challenging task. We want to provide the best possible experience to everyone, which often means using modern web technology only available in recent browsers, while keeping a reasonable compatibility with old and less-capable browsers. These browsers are officially supported in Graylog 3.0:

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

  - The HTTP port of the load balancer/reverse proxy is accessible for clients
  - The HTTP address for the Graylog server is properly set (as explained in :ref:`webif_connecting_to_server`), so it is resolvable and accessible for the load balancer/reverse proxy.
  - If you use SSL, your certificates must be valid and trusted by your clients.

.. NOTE:: To help you with your specific environment, we show some example configuration use cases.

For the configuration use cases below we assume the following:

- Your Graylog server configuration contains ``http_bind_address = 127.0.0.1:9000``
- The hostname for the setup is ``graylog.example.org``
- The IP address for that hostname is ``192.168.0.10``


Using a Layer 3 load balancer (forwarding TCP Ports)
----------------------------------------------------

#. Configure your load balancer to forward connections going to ``192.168.0.10:80`` to ``127.0.0.1:9000``.
#. Start the Graylog server as usual.
#. Access the web interface on ``http://graylog.example.org``.
#. Read up on :ref:`ssl_setup`.

NGINX
-----

**Proxy web interface and API traffic using HTTP**::

    server
    {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        server_name graylog.example.org;

        location / {
          proxy_set_header Host $http_host;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Server $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Graylog-Server-URL http://$server_name/;
          proxy_pass       http://127.0.0.1:9000;
        }
    }


NGINX can be used for SSL Termination, you would only need to modify the ``server listen`` directive and add all Information about your certificate.

If you are running multiple Graylog Server you might want to use HTTPS/SSL to connect to the Graylog Servers (on how to Setup read :ref:`ssl_setup`) and use HTTPS/SSL on NGINX. The configuration for TLS certificates, keys and ciphers is omitted from the sample config for brevity's sake.

**Proxy web interface and API traffic using HTTPS (TLS)**::

    server
    {
        listen      443 ssl spdy;
        server_name graylog.example.org;
        # <- your SSL Settings here!

        location /
        {
          proxy_set_header Host $http_host;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Server $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Graylog-Server-URL https://$server_name/;
          proxy_pass       http://127.0.0.1:9000;
        }
    }

If you want to serve serveral different applications under one domain name, you can also serve the Graylog web interface using a path prefix.

**Proxy web interface and API traffic under a path prefix using HTTP**::


    server
    {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        server_name applications.example.org;

        location /graylog/
        {
          proxy_set_header Host $http_host;
          proxy_set_header X-Forwarded-Host $host;
          proxy_set_header X-Forwarded-Server $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Graylog-Server-URL http://$server_name/graylog/;
          rewrite          ^/graylog/(.*)$  /$1  break;
          proxy_pass       http://127.0.0.1:9000;
        }
    }

This makes your Graylog setup available under the following URLs:

- Web interface: ``http://applications.example.org/graylog/``
- REST API: ``http://applications.example.org/graylog/api/``

Apache httpd 2.x
----------------

**Proxy web interface and API traffic using HTTP**::

    <VirtualHost *:80>
        ServerName graylog.example.org
        ProxyRequests Off
        <Proxy *>
            Order deny,allow
            Allow from all
        </Proxy>

        <Location />
            RequestHeader set X-Graylog-Server-URL "http://graylog.example.org/"
            ProxyPass http://127.0.0.1:9000/
            ProxyPassReverse http://127.0.0.1:9000/
        </Location>

    </VirtualHost>

**Proxy web interface and API traffic using HTTPS (TLS)**::

    <VirtualHost *:443>
        ServerName graylog.example.org
        ProxyRequests Off
        SSLEngine on
        # <- your SSL Settings here!

        <Proxy *>
            Order deny,allow
            Allow from all
        </Proxy>

        <Location />
            RequestHeader set X-Graylog-Server-URL "https://graylog.example.org/"
            ProxyPass http://127.0.0.1:9000/
            ProxyPassReverse http://127.0.0.1:9000/
        </Location>

    </VirtualHost>


HAProxy 1.6
-----------

**Proxy web interface and API traffic using HTTP**::

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
        http-request set-header X-Graylog-Server-URL http://graylog.example.org/
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
        http-request set-header X-Graylog-Server-URL http://graylog.example.org/
        server graylog1 192.168.0.10:9000 maxconn 20 check
        server graylog2 192.168.0.11:9000 maxconn 20 check
        server graylog3 192.168.0.12:9000 maxconn 20 check
