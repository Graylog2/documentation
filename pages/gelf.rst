.. _gelf:

****
GELF
****

Structured events from anywhere. Compressed and chunked.
========================================================

The Graylog Extended Log Format (GELF) is a log format that avoids the shortcomings of classic plain syslog:

 * Limited to length of 1024 bytes – Not much space for payloads like backtraces
 * No data types in structured syslog. You don’t know what is a number and what is a string.
 * The RFCs are strict enough but there are so many syslog dialects out there that you cannot possibly parse all of them.
 * No compression


Syslog is okay for logging system messages of your machines or network gear. GELF is a great choice for logging from within applications.
There are libraries and appenders for many programming languages and logging frameworks so it is easy to implement. You could use GELF to
send every exception as a log message to your Graylog cluster. You don’t have to care about timeouts, connection problems or anything
that might break your application from within your logging class because GELF can be sent via UDP.

GELF via UDP
============

Chunking
--------

UDP datagrams are usually limited to a size of 8192 bytes. A lot of compressed information fits in there but you sometimes might just have
more information to send. This is why Graylog supports chunked GELF.

You can define chunks of messages by prepending a byte header to a GELF message including a message ID and sequence number to reassemble the message later.

Most GELF libraries support chunking transparently and will detect if a message is too big to be sent in one datagram.

Of course TCP would solve this problem on a transport layer but it brings other problems that are even harder to tackle:
You would have to care about slow connections, timeouts and other nasty network problems.

With UDP you may just lose a message while with TCP it could bring your whole application down when not designed with care.

Of course TCP makes sense in some (especially high volume environments) so it is your decision. Many GELF libraries support both TCP and UDP as transport. Some
do even support HTTP.

Prepend the following structure to your GELF message to make it chunked:

  * **Chunked GELF magic bytes - 2 bytes:** ``0x1e 0x0f``
  * **Message ID - 8 bytes:** Must be the same for every chunk of this message. Identifying the whole message and is used to reassemble the chunks later. Generate from millisecond timestamp + hostname for example.
  * **Sequence number - 1 byte:** The sequence number of this chunk. Starting at 0 and always less than the sequence count.
  * **Sequence count - 1 byte:** Total number of chunks this message has.

All chunks **MUST** arrive within 5 seconds or the server will discard all already arrived and still arriving chunks. A message **MUST NOT** consist of more than 128 chunks.


Compression
-----------

When using UDP as transport layer, GELF messages can be sent uncompressed or compressed with either GZIP or ZLIB.

Graylog nodes detect the compression type in the GELF magic byte header automatically.

Decide if you want to trade a bit more CPU load for saving a lot of network bandwidth. GZIP is the protocol default.


GELF via TCP
============

At the current time, GELF TCP only supports uncompressed and non-chunked payloads. Each message needs to be delimited with a null byte (``\0``) when sent in the same TCP connection.

.. attention:: GELF TCP **does not support** compression due to the use of the null byte (``\0``) as frame delimiter.


GELF Payload Specification
==========================

Version 1.1 (11/2013)

A GELF message is a JSON string with the following fields:

  * **version** ``string (UTF-8)``
      * GELF spec version – "1.1"; **MUST** be set by client library.

  * **host** ``string (UTF-8)``
      * the name of the host, source or application that sent this message; **MUST** be set by client library.

  * **short_message** ``string (UTF-8)``
      * a short descriptive message; **MUST** be set by client library.

  * **full_message** ``string (UTF-8)``
      * a long message that can i.e. contain a backtrace; optional.

  * **timestamp** ``number``
      * Seconds since UNIX epoch with optional decimal places for milliseconds; *SHOULD* be set by client library. Will be set to the current timestamp (now) by the server if absent.

  * **level** ``number``
      * the level equal to the standard syslog levels; optional, default is 1 (ALERT).

  * **facility** ``string (UTF-8)``
      * optional, deprecated. Send as additional field instead.

  * **line** ``number``
      * the line in a file that caused the error (decimal); optional, deprecated. Send as additional field instead.

  * **file** ``string (UTF-8)``
      * the file (with path if you want) that caused the error (string); optional, deprecated. Send as additional field instead.

  * **_[additional field]** ``string (UTF-8)`` or ``number``
      * every field you send and prefix with an underscore (``_``) will be treated as an additional field. Allowed characters in field names are any word character (letter, number, underscore), dashes and dots. The verifying regular expression is: ``^[\w\.\-]*$``. Libraries SHOULD not allow to send id as additional field (``_id``). Graylog server nodes omit this field automatically.


Example payload
===============

This is an example GELF message payload. Any graylog-server node accepts and stores this as a message when GZIP/ZLIB compressed or even when sent
uncompressed over a plain socket (without newlines)::

  {
    "version": "1.1",
    "host": "example.org",
    "short_message": "A short message that helps you identify what is going on",
    "full_message": "Backtrace here\n\nmore stuff",
    "timestamp": 1385053862.3072,
    "level": 1,
    "_user_id": 9001,
    "_some_info": "foo",
    "_some_env_var": "bar"
  }


Sending GELF messages via UDP using netcat
------------------------------------------

Sending an example message to a GELF UDP input (running on host ``graylog.example.com`` on port 12201)::

    echo -n '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }' | nc -w0 -u graylog.example.com 12201


Sending GELF messages via TCP using netcat
------------------------------------------

Sending an example message to a GELF TCP input (running on host ``graylog.example.com`` on port 12201)::

    echo -n -e '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }'"\0" | nc -w0 graylog.example.com 12201


Sending GELF messages via HTTP using curl
-----------------------------------------

Sending an example message to a GELF HTTP input (running on ``http://graylog.example.com:12201/gelf``)::

    curl -X POST -H 'Content-Type: application/json' -d '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }' 'http://graylog.example.com:12201/gelf'
