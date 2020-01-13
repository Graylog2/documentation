.. _ssl_setup:
.. _tls_setup:
.. _https_setup:

***********
Using HTTPS
***********

We highly recommend securing your Graylog installation using SSL/TLS to make sure that no sensitive data is sent over the wire in plain text. To make this work, you need to enable the ``http_enable_tls`` setting in your Graylog server configuration.

You also need to make sure that you have proper certificates in place, which are valid and trusted by the clients.

.. note:: If you're operating a single-node setup and would like to use HTTPS for the Graylog web interface and the Graylog REST API, it's possible to use :ref:`NGINX or Apache as a reverse proxy <configuring_webif_nginx>`.

Things to consider
==================

You have multiple options to ensure that your connection is secure and safe. The first would be to create a self-signed certificate, add that to the previously  copied java keystore and use this keystore with your Graylog java options.
Since you will need to do this for every certificate and every trust store, this quickly becomes unmanageable in a clustered architecture. Each node needs to trust all certificates from all other nodes.

The second option would be to create your own certificate authority. You only add the certificate authority once to the key store and all certificates that are created with this authority will be trusted.

The same can be done if you have already your own certificate authority, you only need the certificates and keys in the format that can be used with Graylog. Add the certificate authority key to the keystore and all certificates that are signed by this certificate authority will be trusted.  
Same when you pay for certificates or use a free Certificate authority like let's encrypt to get the server certificates.

Just add the certificate authority to the keystore and all certificates are trusted.

Certificate/Key file format
===========================

When you are configuring TLS, you need to make sure that your certificate/key files are in the right format, which is X.509 for certificates and PKCS#8 for the private keys. Both must to be stored in PEM format.


.. _creating-a-self-signed-private-key-certificate:

Creating a self-signed private key/certificate
==============================================

Create a file named ``openssl-graylog.cnf`` with the following content (customized to your needs)::

  [req]
  distinguished_name = req_distinguished_name
  x509_extensions = v3_req
  prompt = no
  
  # Details about the issuer of the certificate
  [req_distinguished_name]
  C = US
  ST = Some-State
  L = Some-City
  O = My Company
  OU = My Division
  CN = graylog.example.com

  [v3_req]
  keyUsage = keyEncipherment, dataEncipherment
  extendedKeyUsage = serverAuth
  subjectAltName = @alt_names

  # IP addresses and DNS names the certificate should include
  # Use IP.### for IP addresses and DNS.### for DNS names,
  # with "###" being a consecutive number.
  [alt_names]
  IP.1 = 203.0.113.42
  DNS.1 = graylog.example.com


Create PKCS#5 private key and X.509 certificate::

  $ openssl version
  OpenSSL 0.9.8zh 14 Jan 2016
  $ openssl req -x509 -days 365 -nodes -newkey rsa:2048 -config openssl-graylog.cnf -keyout pkcs5-plain.pem -out cert.pem
  Generating a 2048 bit RSA private key
  ............................+++
  .+++
  writing new private key to 'pkcs5-plain.pem'
  -----

Convert PKCS#5 private key into a *unencrypted* PKCS#8 private key::

  $ openssl pkcs8 -in pkcs5-plain.pem -topk8 -nocrypt -out pkcs8-plain.pem

Convert PKCS#5 private key into an *encrypted* PKCS#8 private key (using the passphrase ``secret``)::

  $ openssl pkcs8 -in pkcs5-plain.pem -topk8 -out pkcs8-encrypted.pem -passout pass:secret


Converting a PKCS #12 (PFX) file to private key and certificate pair
====================================================================

PKCS #12 key stores (PFX files) are commonly used on Microsoft Windows. This needs to be done only if you have to convert PKCS #12 Keys to be used with Graylog.

In this example, the PKCS #12 (PFX) file is named ``keystore.pfx``::

  $ openssl pkcs12 -in keystore.pfx -nokeys -out graylog-certificate.pem
  $ openssl pkcs12 -in keystore.pfx -nocerts -out graylog-pkcs5.pem
  $ openssl pkcs8 -in graylog-pkcs5.pem -topk8 -out graylog-key.pem

The resulting ``graylog-certificate.pem`` and ``graylog-key.pem`` can be used in the Graylog configuration file.


Converting an existing Java Keystore to private key/certificate pair
====================================================================

This section describes how to export a private key and certificate from an existing Java KeyStore in JKS format. This is needed if you want to export the certificates from the Java KeyStore. 

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

  # Enable HTTPS support for the HTTP interface.
  # This secures the communication with the HTTP interface with TLS to prevent request forgery and eavesdropping.
  http_enable_tls = true

  # The X.509 certificate chain file in PEM format to use for securing the HTTP interface.
  http_tls_cert_file = /path/to/graylog-certificate.pem

  # The PKCS#8 private key file in PEM format to use for securing the HTTP interface.
  http_tls_key_file = /path/to/graylog-key.pem

  # The password to unlock the private key used for securing the HTTP interface. (if key is encrypted)
  http_tls_key_password = secret

Sample files
============

This section shows the difference between following private key formats with samples. It will help you to identify between the following private key formats and provides samples.

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


Adding a self-signed certificate to the JVM trust store
=======================================================

Graylog nodes inside a cluster need to communicate with each other using the Graylog REST API. When using HTTPS for the Graylog REST API, the X.509 certificate must be *trusted* by the JVM trust store (similar to the trusted CA bundle in an operating system), otherwise communication will fail.

.. important:: If you are using different X.509 certificates for each Graylog node, you have to add *all of them* into the JVM trust store of each Graylog node.

The default trust store of an installed Java runtime environment can be found at ``$JAVA_HOME/jre/lib/security/cacerts``. In order not to "pollute" the official trust store, we make a copy of it which we will use with Graylog instead::

  $ cp -a "${JAVA_HOME}/jre/lib/security/cacerts" /path/to/cacerts.jks

After the original key store file has been copied, we can add the self-signed certificate (``cert.pem``, see :ref:`creating-a-self-signed-private-key-certificate`) to the key store (the default password is ``changeit``)::

  $ keytool -importcert -keystore /path/to/cacerts.jks -storepass changeit -alias graylog-self-signed -file cert.pem
  Owner: CN=graylog.example.com, O="Graylog, Inc.", L=Hamburg, ST=Hamburg, C=DE
  Issuer: CN=graylog.example.com, O="Graylog, Inc.", L=Hamburg, ST=Hamburg, C=DE
  Serial number: 8c80134cee556734
  Valid from: Tue Jun 14 16:38:17 CEST 2016 until: Wed Jun 14 16:38:17 CEST 2017
  Certificate fingerprints:
  	 MD5:  69:D1:B3:01:46:0D:E9:45:FB:C6:6C:69:EA:38:ED:3E
  	 SHA1: F0:64:D0:1B:3B:6B:C8:01:D5:4D:33:36:87:F0:FB:10:E1:36:21:9E
  	 SHA256: F7:F2:73:3D:86:DC:10:22:1D:14:B8:5D:66:B4:EB:48:FD:3D:74:89:EC:C4:DF:D0:D2:EC:F8:5D:78:49:E7:2F
  	 Signature algorithm name: SHA1withRSA
  	 Version: 3
  
  Extensions:
  
  [Other details about the certificate...]
  
  Trust this certificate? [no]:  yes
  Certificate was added to keystore

To verify that the self-signed certificate has indeed been added, it can be listed with the following command::

  $ keytool -keystore /path/to/cacerts.jks -storepass changeit -list | grep graylog-self-signed -A1
  graylog-self-signed, Jun 14, 2016, trustedCertEntry,
  Certificate fingerprint (SHA1): F0:64:D0:1B:3B:6B:C8:01:D5:4D:33:36:87:F0:FB:10:E1:36:21:9E

The printed certificate fingerprint (SHA1) should match the one printed when importing the self-signed certificate.

In order for the JVM to pick up the new trust store, it has to be started with the JVM parameter ``-Djavax.net.ssl.trustStore=/path/to/cacerts.jks``. If you've been using another password to encrypt the JVM trust store than the default ``changeit``, you additionally have to set the JVM parameter ``-Djavax.net.ssl.trustStorePassword=secret``.

Most start and init scripts for Graylog provide a ``JAVA_OPTS`` variable which can be used to pass the ``javax.net.ssl.trustStore`` and (optionally) ``javax.net.ssl.trustStorePassword`` system properties.

.. note:: The default location to change the JVM parameter depends on your installation type and is documented :ref:`with all other default locations <default_file_location>`.

.. warning:: Without adding the previously created Java keystore to the JVM parameters, Graylog won't be able to verify any self-signed certificates or custom CA certificates.

