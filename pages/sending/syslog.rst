*************
Ingest syslog 
*************

Graylog is able to accept and parse `RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`__ and
`RFC 3164 <http://www.ietf.org/rfc/rfc3164.txt>`__  compliant syslog messages and supports TCP transport with both
the octet counting or termination character methods. UDP is also supported and the recommended way to send log messages
in most architectures.

**Many devices, especially routers and firewalls, do not send RFC compliant syslog messages.** This might result
in wrong or completely failing parsing. In that case you might have to go with a combination of *raw/plaintext* message inputs that
do not attempt to do any parsing and :ref:`extractors`.

Rule of thumb is that messages forwarded by `rsyslog <https://www.rsyslog.com>`__ or `syslog-ng <https://github.com/syslog-ng/syslog-ng>`__ are usually parsed flawlessly.

Sending syslog from Linux hosts
-------------------------------

rsyslog
~~~~~~~

Sending syslog data from Linux hosts with ``rsyslog`` is done by defining an output Action that uses 
the `RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`__ format. 

The output action can be placed at the end of the ``/etc/rsyslog.conf`` or as an included file such as ``/etc/rsyslog.d/graylog.conf``.

These examples will send all syslog selectors 
to the example host ``yourgraylog.example.com`` (change this to the hostname or IP that resolves in the installed environment) on port 514 
using the predefined format of ``RSYSLOG_SyslogProtocol23Format``. 

UDP (single ``@``)::

  *.* @yourgraylog.example.org:514;RSYSLOG_SyslogProtocol23Format

TCP (double ``@@``)::

  *.* @@yourgraylog.example.org:514;RSYSLOG_SyslogProtocol23Format

This can be improved by `configuring rsyslog to use TLS <https://www.rsyslog.com/doc/v8-stable/tutorials/tls_cert_summary.html?highlight=tls>`__. 

An opinionated example configuration using a local queue, TCP with TLS, recycling connections, and using the rsyslog ``advanced`` format::

  *.*  action(
     Action.resumeInterval="10"
     RebindInterval="10000"            # cycling TCP connections allows for load balancing
     Queue.Size="100000"
     Queue.DiscardMark="97500"
     Queue.HighWaterMark="80000"
     Queue.Type="LinkedList"
     Queue.FileName="rsyslogqueue"
     Queue.CheckpointInterval="100"
     Queue.MaxDiskSpace="2g"
     Action.ResumeRetryCount="-1"
     Queue.SaveOnShutdown="on"
     Queue.TimeoutEnqueue="10"
     Queue.DiscardSeverity="0"
     type="omfwd"
     target="yourgraylog.example.org"
     protocol="tcp"
     port="514"
     template="RSYSLOG_SyslogProtocol23Format"
     StreamDriver="gtls"
     StreamDriverMode="1"               # run driver in TLS-only mode
     StreamDriverAuthMode="x509/name"   # host TLS cert CN will be used for authentication
     StreamDriverPermittedPeers="yourgraylog.example.org" # only allowed hosts
  )

For extremely old (pre-5.10 from 2010) versions of rsyslog that do no have the ``RSYSLOG_SyslogProtocol23Format`` built-in, 
a template must be defined::

  $template GRAYLOG_SyslogProtocol23Format,"<%PRI%>%PROTOCOL-VERSION% %TIMESTAMP:::date-rfc3339% %HOSTNAME% %APP-NAME% %PROCID% %MSGID% %STRUCTURED-DATA% %msg%\n"
  
  # Then referenced in the output action
  *.* @graylog.example.org:514;GRAYLOG_SyslogProtocol23Format


syslog-ng
~~~~~~~~~
 
Use the ``syslog`` function in syslog-ng to send `RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`__ formatted messages via TCP to a Graylog host::

  # Define TCP syslog destination.
  destination d_net {
      syslog("graylog.example.org" port(514));
  };
  # Send from the default source s_src to the d_net destination configured above.
  log {
      source(s_src);
      destination(d_net);
  };


Sending syslog from MacOS X hosts
---------------------------------

Sending log messages from MacOS X syslog daemons is easy. Just define a ``graylog-server`` instance as UDP log target by
adding this line in your ``/etc/syslog.conf``::

  *.* @graylog.example.org:514

Now restart ``syslogd``::

  $ sudo launchctl unload /System/Library/LaunchDaemons/com.apple.syslogd.plist
  $ sudo launchctl load /System/Library/LaunchDaemons/com.apple.syslogd.plist

**Important:** If ``syslogd`` was running as another user you might end up with multiple ``syslogd`` instances and strange
behavior of the whole system. Please check that only one ``syslogd`` process is running::

  $ ps aux | grep syslog
  lennart         58775   0.0  0.0  2432768    592 s004  S+    6:10PM   0:00.00 grep syslog
  root            58759   0.0  0.0  2478772   1020   ??  Ss    6:09PM   0:00.01 /usr/sbin/syslogd

That's it! Your MacOS X syslog messages should now appear in your Graylog system.