.. _configuring_webif:

***************************************
Configuring and using the web interface
***************************************

When your Graylog instance/cluster is up and running, the next thing you usually want to do is check out our web interface, which offers you great capabilities for searching and analyzing your indexed data and configuring your Graylog environment. Per default you can access it using your browser on ``http://<graylog-server>:9000``.


Overview
========

The Graylog web interface was rewritten in JavaScript for 2.0 to be a client-side single-page browser application. This means its code is running solely in your browser, fetching all data via HTTP(S) from the REST API of your Graylog server. Therefore there is a second HTTP listener which is serving the assets for the web interface (all JavaScript, fonts, images, CSS files) to the clients.

.. note:: Both the web interface port (http://127.0.0.1:9000/ by default, see ``web_listen_uri``) and the REST API port (http://127.0.0.1:12900 by default, see ``rest_listen_uri`` and ``rest_transport_uri``) must be accessible by everyone using the web interface. This means that both components *must* listen on a public network interface *or* be exposed to one using a proxy or NAT!


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

.. _ssl_setup:

SSL Setup
=========

We highly recommend securing your Graylog installation using SSL/TLS to make sure that no sensitive data is sent over the wire in plain text. To make this work, you need to do two things:

  - Enable TLS for the Graylog REST API (``rest_enable_tls``)
  - Enable TLS for the web interface endpoint (``web_enable_tls``)

You also need to make sure that you have proper certificates in place, which are valid and trusted by the clients. Not enabling TLS for either one of them will result in a browser error about mixed content and the web interface will cease to work.


Certificate/Key file format
---------------------------

When you are configuring TLS, you need to make sure that your certificate/key files are in the right format, which is X.509 for certificates and PKCS#8 for the private keys. Both must to be stored in PEM format.

If no X.509 certificate and/or no PKCS#8 private key have been provided, Graylog will automatically try to generate a self-signed private key and certificate with the hostname part of ``web_listen_uri`` as Common Name (CN) of the certificate.


Creating a self-signed private key/certificate
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create PKCS#5 and X.509 certificate::

  $ openssl version
  OpenSSL 0.9.8zh 14 Jan 2016
  $ openssl req -x509 -days 365 -nodes -newkey rsa:2048 -keyout pkcs5-plain.pem -out cert.pem
  Generating a 2048 bit RSA private key
  ............................+++
  .+++
  writing new private key to 'pkcs5-plain.pem'
  -----
  [...]
  If you enter '.', the field will be left blank.
  -----
  Country Name (2 letter code) [AU]:DE
  State or Province Name (full name) [Some-State]:Hamburg
  Locality Name (eg, city) []:Hamburg
  Organization Name (eg, company) [Internet Widgits Pty Ltd]:Graylog, Inc.
  Organizational Unit Name (eg, section) []:
  Common Name (e.g. server FQDN or YOUR name) []:graylog.example.com
  Email Address []:hostmaster@graylog.example.com


Convert PKCS#5 private key into a *plaintext* PKCS#8 private key::

  $ openssl pkcs8 -in pkcs5-plain.pem -topk8 -nocrypt -out pkcs8-plain.pem

Convert PKCS#5 private key into an *encrypted* PKCS#8 private key (using DES3 and the passphrase ``secret``)::

  $ openssl pkcs8 -in pkcs5-plain.pem -topk8 -v2 des3 -out pkcs8-encrypted.pem -passout pass:secret


Converting an existing Java Keystore to private key/certificate pair
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This section describes how to export a private key and certificate from an existing Java KeyStore in JKS format.

The starting point is an existing Java KeyStore in JKS format which contains a private key and certificate which should be used in Graylog::

  $ keytool -list -v -keystore keystore.jks -alias graylog.example.com
  Enter keystore password:
  Alias name: graylog.example.com
  Creation date: May 10, 2016
  Entry type: PrivateKeyEntry
  Certificate chain length: 1
  Certificate[1]:
  Owner: CN=graylog.example.com, OU=Unknown, O="Graylog, Inc.", L=Hamburg, ST=Hamburg, C=DE
  Issuer: CN=graylog.example.com, OU=Unknown, O="Graylog, Inc.", L=Hamburg, ST=Hamburg, C=DE
  Serial number: 2b33832d
  Valid from: Tue May 10 10:02:34 CEST 2016 until: Mon Aug 08 10:02:34 CEST 2016
  Certificate fingerprints:
  	 MD5:  8A:3D:9F:ED:69:93:1B:6C:E3:29:66:EA:82:8D:42:BE
  	 SHA1: 5B:27:92:25:46:36:BC:F0:82:8F:9A:30:D8:50:D0:ED:32:4D:C6:A0
  	 SHA256: 11:11:77:F5:F6:6A:20:A8:E6:4A:5D:B5:20:21:4E:B8:FE:B6:38:1D:45:6B:ED:D0:7B:CE:B8:C8:BC:DD:B4:FB
  	 Signature algorithm name: SHA256withRSA
  	 Version: 3

  Extensions:
  
  #1: ObjectId: 2.5.29.14 Criticality=false
  SubjectKeyIdentifier [
  KeyIdentifier [
  0000: AC 79 64 9F A1 60 14 B9   51 F4 F5 0B B3 B5 02 A5  .yd..`..Q.......
  0010: B8 07 DC 7B                                        ....
  ]
  ]

The Java KeyStore in JKS format has to be converted to a PKCS#12 keystore, so that OpenSSL can work with it::

  $ keytool -importkeystore -srckeystore keystore.jks -destkeystore keystore.p12 -deststoretype PKCS12
  Enter destination keystore password:
  Re-enter new password:
  Enter source keystore password:
  Entry for alias graylog.example.com successfully imported.
  Import command completed:  1 entries successfully imported, 0 entries failed or cancelled

After the keystore has been successfully converted into PKCS#12 format, OpenSSL can export the X.509 certificate with PEM encoding::

  $ openssl pkcs12 -in keystore.p12 -nokeys -out graylog-certificate.pem
  Enter Import Password:
  MAC verified OK

The private key can only be exported in PKCS#5 format with PEM encoding::

  $ openssl pkcs12 -in keystore.p12 -nocerts -out graylog-pkcs5.pem
  Enter Import Password:
  MAC verified OK
  Enter PEM pass phrase:
  Verifying - Enter PEM pass phrase:

Graylog currently only supports PKCS#8 private keys with PEM encoding, so OpenSSL has to convert it into the correct format::

  $ openssl pkcs8 -in graylog-pkcs5.pem -topk8 -out graylog-key.pem
  Enter pass phrase for graylog-pkcs5.pem:
  Enter Encryption Password:
  Verifying - Enter Encryption Password:

The working directory should now contain the PKCS#8 private key (``graylog-key.pem``) and the X.509 certificate (``graylog-certificate.pem``) to be used with Graylog::

  $ head graylog-key.pem graylog-certificate.pem
  ==> graylog-key.pem <==
  -----BEGIN ENCRYPTED PRIVATE KEY-----
  MIIE6TAbBgkqhkiG9w0BBQMwDgQIwMhLa5bw9vgCAggABIIEyN42AeYJJNBEiqhI
  mWqJDot4Jokw2vB4abcIJ5Do4+7tjtMrecVRCDSvBZzjkXjnbumBHEoxexe5f0/z
  wgq6f/UDyTM3uKYQTG91fcqTyMDUlo3Wc8OqSqsNehOAQzA7hMCehqgNJHO0Zfny
  EFvrXHurJWi4eA9vLRup86dbm4Wp3o8pmjOLduXieHfcgVtm5jfd7XfL5cRFS8kS
  bSFH4v8xDxLNaJmKkKl9gPCACMRbO9nGk/Z9q9N8zkj+xG9lxlNRMX51SRzg20E0
  nyyKTb39tJF35zjroB2HfiFWyrPQ1uF6yGoroGvu0L3eWosjBLjdRs0eBgjJCm5P
  ic9zSVqMH6/4CPKJqvB97vP4QhpYcr9jlYJsbn6Zg4OIELpM00VLvp0yU9tqTuRR
  TDPYAlNMLZ2RrV52CEsh3zO21WHM7r187x4WHgprDFnjkXf02DrFhgCsGwkEQnb3
  vj86q13RHhqoXT4W0zugvcv2/NBLMv0HNQBAfEK3X1YBmtQpEJhwSxeszA1i7CpU
  
  ==> graylog-certificate.pem <==
  Bag Attributes
      friendlyName: graylog.example.com
      localKeyID: 54 69 6D 65 20 31 34 36 32 38 36 37 38 32 33 30 39 32
  subject=/C=DE/ST=Hamburg/L=Hamburg/O=Graylog, Inc./OU=Unknown/CN=graylog.example.com
  issuer=/C=DE/ST=Hamburg/L=Hamburg/O=Graylog, Inc./OU=Unknown/CN=graylog.example.com
  -----BEGIN CERTIFICATE-----
  MIIDkTCCAnmgAwIBAgIEKzODLTANBgkqhkiG9w0BAQsFADB5MQswCQYDVQQGEwJE
  RTEQMA4GA1UECBMHSGFtYnVyZzEQMA4GA1UEBxMHSGFtYnVyZzEWMBQGA1UEChMN
  R3JheWxvZywgSW5jLjEQMA4GA1UECxMHVW5rbm93bjEcMBoGA1UEAxMTZ3JheWxv
  Zy5leGFtcGxlLmNvbTAeFw0xNjA1MTAwODAyMzRaFw0xNjA4MDgwODAyMzRaMHkx

The resulting PKCS#8 private key (``graylog-key.pem``) and the X.509 certificate (``graylog-certificate.pem``) can now be used to enable encrypted connections with Graylog by enabling TLS for the Graylog REST API and the web interface in the Graylog configuration file::

  # Enable HTTPS support for the REST API. This secures the communication with the REST API
  # using TLS to prevent request forgery and eavesdropping.
  rest_enable_tls = true
  
  # The X.509 certificate chain file in PEM format to use for securing the REST API.
  rest_tls_cert_file = /path/to/graylog-certificate.pem
  
  # The PKCS#8 private key file in PEM format to use for securing the REST API.
  rest_tls_key_file = /path/to/graylog-key.pem
  
  # The password to unlock the private key used for securing the REST API.
  rest_tls_key_password = secret
  
  # Enable HTTPS support for the web interface. This secures the communication the web interface
  # using TLS to prevent request forgery and eavesdropping.
  web_enable_tls = true
  
  # The X.509 certificate chain file in PEM format to use for securing the web interface.
  web_tls_cert_file = /path/to/graylog-certificate.pem
  
  # The PKCS#8 private key file in PEM format to use for securing the web interface.
  web_tls_key_file = /path/to/graylog-key.pem
  
  # The password to unlock the private key used for securing the web interface.
  web_tls_key_password = secret


Sample files
^^^^^^^^^^^^

This section show the difference between following private key formats with samples.

PKCS#5 plain private key::

  -----BEGIN RSA PRIVATE KEY-----
  MIIBOwIBAAJBANxtmQ1Kccdp7HBNt8zgTai48Vv617bj4SnhkcMN99sCQ2Naj/sp
  [...]
  NiCYNLiCawBbpZnYw/ztPVACK4EwOpUy+u19cMB0JA==
  -----END RSA PRIVATE KEY-----

PKCS#8 plain private key::

  -----BEGIN PRIVATE KEY-----
  MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA6GZN0rQFKRIVaPOz
  [...]
  LaLGdd9G63kLg85eldSy55uIAXsvqQIgfSYaliVtSbAgyx1Yfs3hJ+CTpNKzTNv/
  Fx80EltYV6k=
  -----END PRIVATE KEY-----

PKCS#5 encrypted private key::

  -----BEGIN RSA PRIVATE KEY-----
  Proc-Type: 4,ENCRYPTED
  DEK-Info: DES-EDE3-CBC,E83B4019057F55E9
  
  iIPs59nQn4RSd7ppch9/vNE7PfRSHLoQFmaAjaF0DxjV9oucznUjJq2gphAB2E2H
  [...]
  y5IT1MZPgN3LNkVSsLPWKo08uFZQdfu0JTKcn7NPyRc=
  -----END RSA PRIVATE KEY-----

PKCS#8 encrypted private key::

  -----BEGIN ENCRYPTED PRIVATE KEY-----
  MIIBpjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIU9Y9p2EfWucCAggA
  [...]
  IjsZNp6zmlqf/RXnETsJjGd0TXRWaEdu+XOOyVyPskX2177X9DUJoD31
  -----END ENCRYPTED PRIVATE KEY-----


Making the web interface work with load balancers/proxies
=========================================================

If you want to run a load balancer/reverse proxy in front of Graylog, you need to make sure that:

  - The REST API port is still accessible for clients
  - The address for the Graylog server's REST API is properly set (as explained in :ref:`webif_connecting_to_server`), so it is resolvable and accessible for any client of the web interface.
  - You are either using only HTTP or only HTTPS (no mixed content) for both the web interface endpoint and the REST API endpoint.
  - If you use SSL, your certificates must be valid and trusted by your clients.

To help you with your specific environment, here are some example configurations for common scenarios:


Using a Layer 3 load balancer (forwarding TCP Ports):
-----------------------------------------------------

For the following example we're assuming that your Graylog server is running on IP 1.2.3.4. Your external IP (the one external clients are using to access the Graylog instance) is 2.3.4.5.

#. Configure your load balancer to forward connections going to ``2.3.4.5:80`` to ``1.2.3.4:9000`` and ``2.3.4.5:12900`` to ``1.2.3.4:12900``.
#. Set ``web_endpoint_uri`` in your Graylog server config to ``http://2.3.4.5:12900``.
#. Start the Graylog server as usual
#. Access the web interface on ``http://2.3.4.5``.
#. Read up on :ref:`ssl_setup`.

NGINX:
------

For the following samples we are assuming that your Graylog instance is running on ``graylog.internal.example.org`` using the default ports of 12900 for the REST API and 9000 for the web interface. SSL is disabled for both. You want to expose the Graylog web interface as ``https://graylog.example.org``. The configuration for TLS certificates, keys and ciphers is omitted from the sample config for brevity's sake.

If you want to use nginx to proxy access to a Graylog server, you have several options:

**REST API and Web Interface on one port (using HTTPS/SSL)**::

  server
  {
    listen      443 ssl spdy;
    server_name graylog.example.org;

    location /
    {
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
        proxy_set_header    X-Graylog-Server-URL https://graylog.example.org/api;
        proxy_pass          http://graylog.internal.example.org:9000;
    }

    location /api/
    {
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
        proxy_pass          http://graylog.internal.example.org:12900/;
    }
  }


**REST API and web interface on separate ports (using HTTPS/SSL)**::

  server
  {
    listen      443 ssl spdy;
    server_name graylog.example.org;

    location /
    {
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    X-Graylog-Server-URL https://graylog.example.org:12900;
        proxy_set_header    Host $http_host;
        proxy_pass          http://graylog.internal.example.org:9000;
    }
  }

  server
  {
    listen      12900 ssl spdy;
    server_name graylog.example.org;

    location /
    {
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;
        proxy_pass          http://graylog.internal.example.org:12900/;
    }
  }

Apache:
------- 

For the following samples we are assuming that your Graylog instance is running on ``graylog.internal.example.org`` using the default ports of 12900 for the REST API and 9000 for the web interface. Apache is running on the same server as Graylog. SSL is disabled for both. You want to expose the Graylog web interface as ``https://graylog.example.org``. 

**URI Configs in Graylog server conf**::

   rest_listen_uri = http://127.0.0.1:12900/
   web_listen_uri = http://127.0.0.1:9000/
   
   
**REST API and Web Interface on one port (using HTTPS/SSL)**::
   
   Listen 443
   <VirtualHost *:443>
       ServerName graylog.example.org
       # Your SSL config <-- You should change this
       <Location />
           RequestHeader set X-Graylog-Server-URL "https://graylog.example.org/api/"
           ProxyPass http://127.0.0.1:9000/
           ProxyPassReverse http://127.0.0.1:9000/
       </Location>
       <Location /api/>
           ProxyPass http://127.0.0.1:12900/
           ProxyPassReverse http://127.0.0.1:12900/
       </Location>
   </VirtualHost>
