***********
Ingest GELF 
***********

The Graylog Extended Log Format (GELF) is a log format that avoids the shortcomings of classic plain syslog and is perfect
to logging from your application layer. It comes with optional compression, chunking and most importantly a clearly defined
structure. There are `dozens of GELF libraries <http://marketplace.graylog.org>`__ for many frameworks and
programming languages to get you started.

Read more about :doc:`GELF in the specification <gelf>`.

GELF via HTTP
-------------

You can send in all GELF types via HTTP, including uncompressed GELF that is just a plain JSON string.

After launching a GELF HTTP input you can use the following endpoints to send messages::

  http://graylog.example.org:[port]/gelf (POST)

Try sending an example message using curl::

  curl -XPOST http://graylog.example.org:12202/gelf -p0 -d '{"short_message":"Hello there", "host":"example.org", "facility":"test", "_foo":"bar"}'

Both keep-alive and compression are supported via the common HTTP headers. The server will return a ``202 Accepted`` when the message
was accepted for processing.