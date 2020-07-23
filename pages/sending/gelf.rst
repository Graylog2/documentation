***********
Ingest GELF 
***********

The Graylog Extended Log Format (GELF) is a log format that avoids the shortcomings of classic plain Syslog and is perfect
for logging from your application layer. It comes with optional compression, chunking, and, most importantly, a clearly defined
structure. 
The Input of GELF messages can be UDP, TCP, or HTTP. Additional a queue is possible. 

Some applications like `Docker can send GELF messages <https://docs.docker.com/config/containers/logging/gelf/>`__ native. Also, `fluentd speaks GELF <https://docs.fluentbit.io/manual/pipeline/outputs/gelf>`__. 

There are `dozens of GELF libraries <https://marketplace.graylog.org/addons?kind=gelf>`__ for many frameworks and
programming languages to get you started. Read more about :doc:`GELF in the specification <gelf>`.

GELF via HTTP
-------------

You can send in all GELF types via HTTP, including uncompressed GELF that is just a plain JSON string.

After launching a GELF HTTP input you can use the following endpoints to send messages::

  http://graylog.example.org:[port]/gelf (POST)

Try sending an example message using curl::

  curl -XPOST http://graylog.example.org:12202/gelf -p0 -d '{"short_message":"Hello there", "host":"example.org", "facility":"test", "_foo":"bar"}'

Both keep-alive and compression are supported via the common HTTP headers. The server will return a ``202 Accepted`` when the message
was accepted for processing.