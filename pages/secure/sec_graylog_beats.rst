*******************************
Secured Graylog and Beats input
*******************************

The goal of this guide is to have a secured Graylog interface and API and  filebeat (or winlogbeat) communicate via secure connection and authenticate by certificate that only trusted collectors can deliver messages.

SSL/TLS prework
===============

Create a CA with our `shadowCA <https://github.com/graylog-labs/shadowCA>`__ or use your already given CA. We need that to create all certificates. The examples will take the given names from our helper. 

The CA need to be imported on all machines that are part of the setup using the `documented steps <https://github.com/graylog-labs/shadowCA/blob/master/docs/add_ca_to_truststore.md>`__. Depending on your Browser you might need to add the ``.der`` to your Browser to trust your CA. In addition the CA ``.der`` file is added to a JVM Keystore that is used by Graylog.

adding of DER to JVM Keystore
-----------------------------

Graylog need to know the CA that is used to veify the certificates. In addition only the CA certificate::

	# test the der file
	keytool -v -printcert -file shadowCA.der
	 
	# copy cacert into Graylog Folder (ubuntu / debian and CENTOS openJDK )
	[ -f /usr/lib/jvm/jre/lib/security/cacerts ] && cp /usr/lib/jvm/jre/lib/security/cacerts /etc/graylog/server/cacerts.jks
	[ -f /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts ] && cp /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts /etc/graylog/server/cacerts.jks
	 
	 
	# import CA der into keystore
	# will only work if the default password&user is not changed.
	keytool -importcert -alias shadowCA -keystore /etc/graylog/server/cacerts.jks -storepass changeit -file shadowCA.der

custom JVM Keystore for Graylog
-------------------------------

Modify the :ref:`JVM Setting <default_file_location>` to include ``-Djavax.net.ssl.trustStore=/etc/graylog/server/cacerts.jks`` in the ``GRAYLOG_JAVA_OPTS``.

create certificates
-------------------

Create certificates for each server, all hostnames and IPs that might be used later to connect from and to this server should be included in the certificates. See `README of shadowCA <https://github.com/graylog-labs/shadowCA#create-certificates>`__ for the possible options. The most common error is that the certificate name does not match the hostname that is used for the connection.