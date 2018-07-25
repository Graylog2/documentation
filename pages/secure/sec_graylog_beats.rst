*******************************
Secured Graylog and Beats input
*******************************

The goal of this guide is to have a secured Graylog interface, API and secure communication for Beats that are authenticated by certificate. This way only trusted sources are able to deliver messages into Graylog. 

This is a structured document that contains only information already given at various location in this documentation. It should give the missing connection between the different parts of the documentation.


SSL/TLS prework
===============

Create a CA with our `shadowCA <https://github.com/graylog-labs/shadowCA>`__ or use your already given CA. That is needed to create all certificates. The examples will take the given names from our shadowCA and reference to that only, please adjust this to your local needs. If in doubt check the shadowCA scripts what kind of certificate is created and used.

The CA certificate need to be imported on all machines that are part of the setup using the `documented steps <https://github.com/graylog-labs/shadowCA/blob/master/docs/add_ca_to_truststore.md>`__. Depending on your Browser you might need to add the ``.der`` to your Browser to trust the CA. In addition the CA ``.der`` file is added to a JVM Keystore that is used by Graylog.

adding of .der to JVM Keystore
-----------------------------

Graylog need to know the CA that is used to verify the certificates. The prime advantage is that it only needs the CA certificate and not all known self-signed certificates in the setup.::

	# test the .der file
	keytool -v -printcert -file shadowCA.der
	 
	# copy cacert into Graylog Folder (ubuntu / debian and CENTOS openJDK )
	[ -f /usr/lib/jvm/jre/lib/security/cacerts ] && cp /usr/lib/jvm/jre/lib/security/cacerts /etc/graylog/server/cacerts.jks
	[ -f /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts ] && cp /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts /etc/graylog/server/cacerts.jks
	 
	 
	# import CA .der into keystore
	# will only work if the default password & user is not changed.
	keytool -importcert -alias shadowCA -keystore /etc/graylog/server/cacerts.jks -storepass changeit -file shadowCA.der

custom JVM Keystore for Graylog
-------------------------------

Modify the :ref:`JVM Setting <default_file_location>` to include ``-Djavax.net.ssl.trustStore=/etc/graylog/server/cacerts.jks`` in the ``GRAYLOG_JAVA_OPTS``.

create certificates
===================

Create certificates for each server, all hostnames and IPs that might be used later to connect from and to this server should be included in the certificates. See `README of shadowCA <https://github.com/graylog-labs/shadowCA#create-certificates>`__ for the possible options. The most common error is that the certificate name does not match the hostname that is used for the connection.

The shadowCA uses the same settings that can be found :ref:`in the SSL <ssl_setup>` documentation, but easy up the process. 


Deploy and configure
====================

Graylog
-------

HTTPS
^^^^^

Place the ``.key`` and ``.crt file`` to your Graylog server in the configuration dir (/etc/graylog/server/) and add them to the Graylog server.conf. In addition change the ``rest_listen_uri`` and ``web_listen_uri`` to **https**. You might need to cover other settings in a multinode cluster or special setups - just read the comments of the settings inside of the server.conf.

When using the collector-sidecar, use the **https** URI in the ``sidecar_configuration.yml``.

After restart of Graylog the web interface and the API is served via https only. No automatically redirect from http to https is made.

TLS Beats Input
^^^^^^^^^^^^^^^

To enable TLS on the input one certificate - the certificate file and the private key file - that can be used for the input. We recommend to use the same certificate that is already used to secure the webinterface. Just reference the files `TLS cert file` and `TLS private key file` in the Beats Input configuration and restart the input. 

The ingesting client will verify the presented certificate against his know CA certificates, if that is successfull communication will be establised using TLS. 


Add client authentication to beats input
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create one directory (``/etc/graylog/server/trusted_clients``) that will hold all client certificates you allow to connect to the beats input - that must be available on all Graylog server that have the input enabled. Write that path in the beats input configuration `TLS Client Auth Trusted Certs` and select **required** for the option `TLS client authentication`.

After this setting is saved only clients that provide a certificate that is trusted by the CA and is placed inside the configured directory (``/etc/graylog/server/trusted_clients``) can deliver messages to Graylog.

Beats
-----

Stock
^^^^^

When using the stock beat that is `provided by elastic <https://www.elastic.co/downloads/beats>`__ configure a `logstash output <https://www.elastic.co/guide/en/beats/filebeat/6.x/logstash-output.html#logstash-output>`__. The SSL configuration can be found as the second point in the `description by elastic <https://www.elastic.co/guide/en/beats/filebeat/6.x/configuring-ssl-logstash.html>`__ . This is::

	output.logstash:
  		hosts: ["logs.mycompany.com:5044"]
  		ssl.certificate_authorities: ["/etc/ca.pem"]
  		ssl.certificate: "/etc/client.crt"
  		ssl.key: "/etc/client.key"


Place your previous create certificates on the server where you installed beats and adjust the configuration to your needs.

The certificate (``.crt``) file of the beat need to be placed at the Graylog server in the configured directory for trusted clients, only if you have enabled that feature at the beats input in Graylog and want client authentication.


Collector-Sidecar
^^^^^^^^^^^^^^^^^ 

Place the certificate and key on the server where the collector-sidecar is running (e.g. place it in ``/etc/graylog/collector-sidecar/ssl``). Then reference those files in the beats output configuration at the Graylog web interface. The :ref:`description how to secure sidecar <sidecar_secure>` only refers to self signed certificates not how to use your own CA. 

You need to place the ``shadowCA.pem`` and the ``.crt`` and ``.key`` in the directory at the collector-sidecar server.  
