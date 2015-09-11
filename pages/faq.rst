**************************
Frequently asked questions
**************************

General
=======

Isn't Java slow and needs a lot of memory?
------------------------------------------

This is a concern that we hear from time to time. We are however usually able
to prove this assumption wrong. Java has a bad reputation from slow and laggy
desktop/GUI applications that eat a lot of memory. Well written Java code for
server systems is very efficient and does not need a lot of resources.

Give it a try, you might be surprised!

I already tried to use Elasticsearch for log management and it did not work well
--------------------------------------------------------------------------------

Sorry to hear that. The good news: Graylog is working around a lot of the
log management specific shortcomings of Elasticsearch. Don't get us wrong:
Elasticsearch is a great product! It just needs some special handling by our
`graylog-server` process that you do not get if you are directly writing your logs
and reading information from Elasticsearch. Especially the journalling of Graylog
shields Elasticsearch against overloading and failing in weird ways.

What is MongoDB used for?
-------------------------

The MongoDB dependency of Graylog is there to store metadata that is not log data.
None of your messages is ever stored in Graylog but for example user information
or stream rules are. This is why you should not expect much load on MongoDB and
thus don't have to worry too much about scaling it. It will just run aside your
`graylog-server` processes and take almost no resources in our recommended setup
architectures.

There are plans to introduce a database abstraction layer in the future. This will
give you the choice to run MongoDB, MySQL or other databases for storing metadata.

It seems like Graylog has no reporting functionality?
-----------------------------------------------------

That is correct. For now there is no built-in reporting functionality that
sends automated reports. You can however use our REST API to generate and
send you own reports. A cron job and the scripting language of your choice
should do the trick.

Message parsing
===============

Does Graylog parse syslog?
--------------------------

Yes, Graylog is able to accept and parse RFC 5424 and RFC 3164 compliant syslog messages
and supports TCP transport with both the octet counting or termination character methods.
UDP is also supported and the recommended way to send log messages in most architectures.

Many devices, especially routers and firewalls, do not send RFC compliant syslog messages.
This might result in wrong or completely failing parsing. In that case you might have to
go with a combination of raw/plaintext message inputs that do not attempt to do any parsing
and :doc:`extractors`.

Rule of thumb is that messages forwarded by rsyslog or syslog-ng are usually parsed
flawlessly.
