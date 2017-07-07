.. _securing:

****************
Securing Graylog
****************

To secure your Graylog setup, you should not use one of our pre-configured images, create your own unique installation where you understand each component and secure the environment by design. Expose only the services that are needed and secure them whenever possible with TLS/SSL and some kind of authentication. Do not use the pre-created appliances for critical production environments.

On the Graylog appliances MongoDB and Elasticsearch is listening on the external interface. This makes the creation of a cluster easier and demonstrates the way Graylog works.
Never run this in an insecure network.

When using Amazon Web Services and our pre-configured AMI, never open all ports in the security group. Do not expose the server to the internet. Access Graylog only from within your VPC. Enable encryption for the communication.

Default ports
=============

All parts of one Graylog installation will communicate over network sockets. Depending on your setup and number of nodes this might be exposed or can be bound to localhost. The :ref:`SELinux <selinux>` configuration is already covered in our step-by-step guide for CentOS Linux.

.. list-table:: Default network communication ports
    :header-rows: 1

    * - Component
      - Port
    * - Graylog (web interface / API)
      - 9000 (tcp)
    * - Graylog to Elasticsearch
      - 9200 (tcp)
    * - Elasticsearch node communication
      - 9300 (tcp)
    * - MongoDB
      - 27017 (tcp)



Each setup is unique in the requirements and ports might be changed by configuration, but you should limit who is able to connect to which service. In the :ref:`architecture description <big_production_setup>` you can see what components need to be exposed and communicate with each other.

Logging user activity
=====================

Graylog has been built using a client-server architecture model in which the user interface retrieves all data via a collection of REST APIs. Thus logging relevant user activity, in other words an access log, is simply a matter of enabling a built-in feature. It logs all requests to the Graylog REST API and produces an access log augmented by additional information, like the user name, the remote address, and the user agent.

Configuring the Access Log
--------------------------

The Access Log is configured by adding an appender and logger to the `Log4j2 configuration <https://logging.apache.org/log4j/2.x/manual/configuration.html>`_ file (``log4j2.xml``). The following example demonstrates required additions on top of the normal logging configuration::

  <?xml version="1.0" encoding="UTF-8"?>
  <Configuration packages="org.graylog2.log4j" shutdownHook="disable">
      <Appenders>
          <!-- Simple appender that writes access log to specified file -->
          <File name="RestAccessLog" fileName="/var/log/graylog/server/restaccess.log" append="true">
              <PatternLayout pattern="%d %-5p: %c - %m%n"/>
          </File>
      </Appenders>
      <Loggers>
          <!-- RestAccessLogFilter -->
          <Logger name="org.graylog2.rest.accesslog" level="debug" additivity="false">
                  <AppenderRef ref="RestAccessLog" level="debug"/>
                  <AppenderRef ref="STDOUT" level="info"/>
          </Logger>
      </Loggers>
  </Configuration>


The resulting log entries will look similar to the following messages::

  2016-06-08 18:21:55,651 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET streams" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:55,694 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET system/fields" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:55,698 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET system/fields" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:55,780 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET system/inputs" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:56,021 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET search/universal/relative?query=%2A&range=300&limit=150&sort=timestamp%3Adesc" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1


X-Forwarded-For HTTP header support
-----------------------------------

If there is a proxy server, load balancer, or a network device which hides the client's IP address from Graylog, it can read the information from a supplied ``X-Forwarded-For`` HTTP request header. Most HTTP-capable devices support setting such a (semi-) standard HTTP request header.

Since overriding the client address from a externally supplied HTTP request header opens the door for spoofing, the list of trusted proxy servers which are allowed to provide the ``X-Forwarded-For`` HTTP request header, can be configured using the ``trusted_proxies`` setting in the Graylog configuration file (``graylog.conf``)::

  # Comma separated list of trusted proxies that are allowed to set the client address with X-Forwarded-For
  # header. May be subnets, or hosts.
  trusted_proxies = 127.0.0.1/32, 0:0:0:0:0:0:0:1/128
