.. _securing:

****************
Securing Graylog
****************

Logging user activity
=====================

Graylog follows microservices architecture model where the user interface retrieves all data via a collection of REST APIs. Thus logging relevant user activity is a simple matter of enabling built-in feature called RestAccessLogFilter. It catches all requests to REST APIs, and produces an access log augmented by user information.

Configuring RestAccessLogFilter
-------------------------------

RestAccessLog is configured by adding an appender and logger to ``log4j2.xml``. The following example demonstrates required additions on top of the normal logging configuration::

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


Resulting logs should look something like the following::


  2016-06-08 18:21:55,651 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET streams" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:55,694 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET system/fields" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:55,698 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET system/fields" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:55,780 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET system/inputs" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1
  2016-06-08 18:21:56,021 DEBUG: org.graylog2.rest.accesslog - 192.168.122.1 admin [-] "GET search/universal/relative?query=%2A&range=300&limit=150&sort=timestamp%3Adesc" Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0 200 -1


X-Forwarded-For support
-----------------------

In case there is a proxying web server, load balancer, or a network device that hides the end user's IP address from Graylog, support for reading the information from supplied ``X-Forwarded-For`` HTTP header may be configured. How to forward the required header is out of scope, and you may need to refer to the documentation of the proxying component.

Reading ``X-Forwarded-For`` is configured by adding ``trusted_proxies`` parameter to the configuration file ``graylog.conf``::

  # Comma separated list of trusted proxies that are allowed to set the client address with X-Forwarded-For
  # header. May be subnets, or hosts.
  #trusted_proxies = 127.0.0.1/32, 0:0:0:0:0:0:0:1/128




