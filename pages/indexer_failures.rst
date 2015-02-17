*********************************
Indexer failures and dead letters
*********************************

Indexer failures
================

Every ``graylog-server`` instance is constantly keeping track about every indexing
operation it performs. This is important for making sure that you are not silently
losing any messages. The web interface can show you a number of write operations
that failed and also a list of failed operations. Like any other information in the
web interface this is also available via the REST APIs so you can hook it into your
own monitoring systems.

.. image:: /images/indexerfailures_1.png

Information about the indexing failure is stored in a capped MongoDB collection that
is limited in size. A lot (many tens of thousands) of failure messages should fit in there but
it should not be considered a complete collection of all errors ever thrown.

Dead letters
============

**This is an experimental feature**. You can enable the dead letters feature in
your ``graylog-server.conf`` like this::

  dead_letters_enabled = true

Graylog will write every message that could not be written to Elasticsearch into
the MongoDB ``dead_letters`` collection. The messages will be waiting there for you
to be processed in some other way. You could write a script that reads every message
from there and transforms it in a way that will allow Graylog to accept it.

A dead letter in MongoDB has exactly the structure (in the ``message`` field) like the
message that would have been written to the indices::

  $ mongo
  MongoDB shell version: 2.4.1
  connecting to: test
  > use graylog2
  switched to db graylog2
  > db.dead_letters.find().limit(1).pretty()
  {
      "_id" : ObjectId("530a951b3004ada55961ee22"),
      "message" : {
          "timestamp" : "2014-02-24 00:40:59.121",
          "message" : "failing",
          "failure" : "haha",
          "level" : NumberLong(6),
          "_id" : "544575a0-9cec-11e3-b502-4c8d79f2b596",
          "facility" : "gelf-rb",
          "source" : "sundaysister",
          "gl2_source_input" : "52ef64d03004faafd4bb0fc2",
          "gl2_source_node" : "fb66b27e-993c-4595-940f-dd521dcdaa93",
          "file" : "(irb)",
          "line" : NumberLong(37),
          "streams" : [ ],
          "version" : "1.0"
      },
      "timestamp" : ISODate("2014-02-24T00:40:59.137Z"),
      "letter_id" : "54466000-9cec-11e3-b502-4c8d79f2b596"
  }

The ``timestamp`` is the moment in time when the message could not be written to the
indices and the ``letter_id`` references to the failed indexing attempt and its error message.

Every failed indexing attempt comes with a field called ``written`` that indicates if a
dead letter was created or not::

  > db.index_failures.find().limit(1).pretty()
  {
    "_id" : ObjectId("530a951b3004ada55961ee23"),
    "timestamp" : ISODate("2014-02-24T00:40:59.136Z"),
    "message" : "MapperParsingException[failed to parse [failure]]; nested: NumberFormatException[For input string: \"haha\"]; ",
    "index" : "graylog2_324",
    "written" : true,
    "letter_id" : "54466000-9cec-11e3-b502-4c8d79f2b596",
    "type" : "message"
  }

Common indexer failure reasons
==============================

There are some common failures that can occur under certain circumstances. Those are
explained here:

MapperParsingException
----------------------

An error message would look like this::

  MapperParsingException[failed to parse [failure]]; nested: NumberFormatException[For input string: "some string value"];

You tried to write a ``string`` into a numeric field of the index. The indexer tried
to convert it to a number, but failed because the ``string`` did contain characters
that could not be converted.

This can be triggered by for example sending GELF messages with different field
types or extractors trying to write ``strings`` without converting them to numeric
values first. **The recommended solution is to actively decide on field types**. If
you sent in a field like ``http_response_code`` with a numeric value then you should
never change that type in the future.

The same can happen with all other field types like for example booleans.

**Note that index cycling is something to keep in mind here.** The first type
written to a field per index wins. If the Graylog index cycles then the field
types are starting from scratch for that index. If the first message written to
that index has the ``http_response_code`` set as ``string`` then it will be a ``string``
until the index cycles the next time. Take a look
at :doc:`index_model` for more information.
