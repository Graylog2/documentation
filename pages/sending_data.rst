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

Supported log formats
=====================

Syslog
------

Graylog is able to accept and parse `RFC 5424 <http://www.ietf.org/rfc/rfc5424.txt>`_ and
`RFC 3164 <http://www.ietf.org/rfc/rfc3164.txt>`_  compliant syslog messages and supports TCP transport with both
the octet counting or termination character methods. UDP is also supported and the recommended way to send log messages
in most architectures.

**Many devices, especially routers and firewalls, do not send RFC compliant syslog messages.** This might result
in wrong or completely failing parsing. In that case you might have to go with a combination of *raw/plaintext* message inputs that
do not attempt to do any parsing and :doc:`extractors`.

Rule of thumb is that messages forwarded by `rsyslog` or `syslog-ng` are usually parsed flawlessly.

Follow our specific [syslog guide](/resources/documentation/sending/syslog) to learn how to configure your daemons.

### GELF

The Graylog Extended Log Format (GELF) is a log format that avoids the shortcomings of classic plain syslog and is perfect
to logging from your application layer. It comes with optional compression, chunking and most importantly a clearly defined
structure. There are [dozens of GELF libraries](/supported-sources) for many frameworks and programming languages to get
you started.

Read more about GELF [here](/resources/gelf).

### Others

The built-in *raw/plaintext* inputs allow you to parse any text that you can send via TCP or UDP. No parsing is applied at
all by default until you build your own parser using custom [extractors](/resources/documentation/general/extractors). This
is a good way to support any text-based logging format.

You can also [write your own message input plugin](/resources/documentation/general/plugins) if you need extreme flexibility.

## Reading from files

Graylog2 is currently not providing an out-of-the-box way to read log messages from files. We do however recommend two
fantastic tools to do that job that both come with native Graylog2 (GELF) outputs:

  * [fluentd](http://www.fluentd.org/guides/recipes/graylog2)
  * [logstash](http://logstash.net/docs/1.4.2/outputs/gelf)

## graylog2-radio

Our `graylog2-radio` component is a lightweight `graylog2-server` instance that is, just like any fully featured
`graylog2-server` instance, controlled from the Graylog2 web interface. It is spawning message inputs and writing
received messages to a message broker like RabbitMQ or Kafka without doing any further processing. Connected
`graylog2-server` instances will read the queued messages and process them like any other received log message. This
is great to buffer load spikes or distribute load evenly across multiple `graylog2-server` instances.

The message inputs spawned on `graylog2-radio` are not different to those spawned on `graylog2-server` instances. Read
more about this topic [here](/resources/documentation/setup/radio).
