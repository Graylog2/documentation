*******************
Sending in log data
*******************

A Graylog setup is pretty worthless without any data in it. This page explains the basic principles of getting your data
into the system and also explains common fallacies.

What are Graylog message inputs?
================================

Message inputs are the Graylog parts responsible for accepting log messages. They are launched from the web interface
(or the REST API) in the *System -> Inputs* section and are launched and configured without the need to restart any
part of the system.

Content packs
=============

Content packs are bundles of Graylog input, extractor, stream, dashboard and output configurations that can provide full support
for a data source. Some content packs are shipped with Graylog by default and some are available from this web site. Packs that
were downloaded from `here <https://www.graylog.org/resources/data-sources/>`_ can be imported using the Graylog web interface.

You can load and even create own content packs from the *System -> Content Packs* section of your Graylog web interface.

Syslog
======

Graylog is able to accept and parse `RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`_ and
`RFC 3164 <http://www.ietf.org/rfc/rfc3164.txt>`_  compliant syslog messages and supports TCP transport with both
the octet counting or termination character methods. UDP is also supported and the recommended way to send log messages
in most architectures.

**Many devices, especially routers and firewalls, do not send RFC compliant syslog messages.** This might result
in wrong or completely failing parsing. In that case you might have to go with a combination of *raw/plaintext* message inputs that
do not attempt to do any parsing and :doc:`extractors`.

Rule of thumb is that messages forwarded by ``rsyslog`` or ``syslog-ng`` are usually parsed flawlessly.

Sending syslog from Linux hosts
-------------------------------

rsyslog
^^^^^^^

Forwarding syslog messages with rsyslog is easy. The only important thing to get the most out of your logs is following
`RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`_. The following examples configures your ``rsyslog`` daemon to send
RFC 5424 date to Graylog syslog inputs:

UDP::

  $template GRAYLOGRFC5424,"<%PRI%>%PROTOCOL-VERSION% %TIMESTAMP:::date-rfc3339% %HOSTNAME% %APP-NAME% %PROCID% %MSGID% %STRUCTURED-DATA% %msg%\n"
  *.* @graylog.example.org:514;GRAYLOGRFC5424

TCP::

  $template GRAYLOGRFC5424,"<%PRI%>%PROTOCOL-VERSION% %TIMESTAMP:::date-rfc3339% %HOSTNAME% %APP-NAME% %PROCID% %MSGID% %STRUCTURED-DATA% %msg%\n"
  *.* @@graylog.example.org:514;GRAYLOGRFC5424

(The difference between UDP and TCP is using ``@`` instead of ``@@`` as target descriptor.)

syslog-ng
^^^^^^^^^

Configuring syslog-ng to send syslog to Graylog2 is equally simple. Use the ``syslog`` function to send
`RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`_ formatted syslog messages via TCP to the remote Graylog host::

  # Define TCP syslog destination.
  destination d_net {
      syslog("graylog.example.org" port(514));
  };
  # Tell syslog-ng to send data from source s_src to the newly defined syslog destination.
  log {
      source(s_src); # Defined in the default syslog-ng configuration.
      destination(d_net);
  };

Sending syslog from OSX hosts
-----------------------------

Sending log messages from OSX syslog daemons is easy. Just define a ``graylog-server`` instance as UDP log target by
adding this line in your ``/etc/syslog.conf``::

  *.* @graylog.example.org:514

Now restart ``syslogd``::

  $ sudo launchctl unload /System/Library/LaunchDaemons/com.apple.syslogd.plist
  $ sudo launchctl load /System/Library/LaunchDaemons/com.apple.syslogd.plist

Important: If ``syslogd`` was running as another use you might end up with multiple ``syslogd`` instances and strange
behaviour of the whole system. Please check that only one ``syslogd`` process is running::

  $ ps aux | grep syslog
  lennart         58775   0.0  0.0  2432768    592 s004  S+    6:10PM   0:00.00 grep syslog
  root            58759   0.0  0.0  2478772   1020   ??  Ss    6:09PM   0:00.01 /usr/sbin/syslogd

That's it! Your OSX syslog messages should now appear in your Graylog system.

GELF
====

The Graylog Extended Log Format (GELF) is a log format that avoids the shortcomings of classic plain syslog and is perfect
to logging from your application layer. It comes with optional compression, chunking and most importantly a clearly defined
structure. There are `dozens of GELF libraries <https://www.graylog.org/resources/data-sources/>`_ for many frameworks and
programming languages to get you started.

Read more about GELF `on graylog2.org <https://www.graylog.org/resources/gelf-2/>`_.

GELF via HTTP
-------------

You can send in all GELF types via HTTP, including uncompressed GELF that is just a plain JSON string.

After launching a GELF HTTP input you can use the following endpoints to send messages::

  http://graylog.example.org:[port]/gelf (POST)

Try sending an example message using curl::

  curl -XPOST http://graylog.example.org:12202/gelf -p0 -d '{"short_message":"Hello there", "host":"example.org", "facility":"test", "_foo":"bar"}'

Both keep-alive and compression are supported via the common HTTP headers. The server will return a ``202 Accepted`` when the message
was accepted for processing.


Microsoft Windows
=================

Our recommended way to forward Windows log data (for example EventLog) to Graylog is to use the open source
`nxlog community edition <http://nxlog.org/products/nxlog-community-edition>`_. It comes with a native Graylog GELF
output that nicely structures your log messages.

Others
======

The built-in *raw/plaintext* inputs allow you to parse any text that you can send via TCP or UDP. No parsing is applied at
all by default until you build your own parser using custom :doc:`extractors`. This is a good way to support any text-based
logging format.

You can also write :doc:`plugins` if you need extreme flexibility.

Reading from files
==================

Graylog is currently not providing an out-of-the-box way to read log messages from files. We do however recommend two
fantastic tools to do that job for you. Both come with native Graylog (GELF) outputs:

  * `fluentd <http://www.fluentd.org/guides/recipes/graylog2>`_
  * `logstash <http://logstash.net/docs/1.4.2/outputs/gelf>`_
