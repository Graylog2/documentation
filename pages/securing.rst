.. _securing:

****************
Securing Graylog
****************

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
  
  
Using ModSecurity
=================

`ModSecurity <https://modsecurity.org/>`_ is a popular open source web application firewall that can be used in conjuction with the Apache and Nginx web servers. When Graylog is configured behind a web server that uses ModSecurity, certain configuration changes must be made. The following examples are for version 2.x rules.

Some distributions (for example RHEL 7.x) ship with older rule sets that do not allow the MIME type ``application/json`` to be used in requests. This can be fixed by modifying the variable ``tx.allowed_request_content_type``::

	# Allow application/json
	SecRule REQUEST_URI "@beginsWith /" \
	  "id:'000001', \
	  phase:1, \
	  t:none, \
	setvar:'tx.allowed_request_content_type=application/x-www-form-urlencoded|multipart/form-data|text/xml|application/xml|application/x-amf|application/json|application/octet-stream', \
	  nolog, \
	  pass"

Load balancers accessing ``/system/lbstatus`` rarely provide the ordinary HTTP headers ``Host``, ``Accept``, or ``User-Agent``. The default rules disallow requests that are missing the mentioned headers. They should be explicitly allowed::

	# Host header
	SecRule REQUEST_URI "@beginsWith /system/lbstatus" \
	  "id:'000002', \
	  phase:2, \
	  t:none, \
	  ctl:ruleRemoveById=960008, \
	  nolog, \
	  pass"
	# Accept header
	SecRule REQUEST_URI "@beginsWith /system/lbstatus" \
	  "id:'000003', \
	  phase:2, \
	  t:none, \
	  ctl:ruleRemoveById=960015, \
	  nolog, \
	  pass"
	# User agent header
	SecRule REQUEST_URI "@beginsWith /system/lbstatus" \
	  "id:'000004', \
	  phase:2, \
	  t:none, \
	  ctl:ruleRemoveById=960009, \
	  nolog, \
	  Pass"

The HTTP verb DELETE is usually forbidden by default. It should be explicitly allowed for requests to ``/api/``::

	# Enable DELETE for /api/
	SecRule REQUEST_URI "@beginsWith /api/" \
	  "id:'000005', \
	  phase:1, \
	  t:none, \
	  setvar:'tx.allowed_methods=GET HEAD POST OPTIONS DELETE', \
	  nolog, \
	  pass"
 
ModSecurity ships by default with strict rules against SQL injection. The query strings used in Graylog searches trigger those rules, breaking all search functionality. It should be noted that Graylog ships with no SQL based products.  The offending rules can usually be safely removed, for example::

	# Disable SQL injection rules
	SecRuleRemoveById 981173
	SecRuleRemoveById 960024
	SecRuleRemoveById 981318
	SecRuleRemoveById 981257
	

