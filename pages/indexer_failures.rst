****************
Indexer failures
****************

Every Graylog node is constantly keeping track about every indexing
operation it performs. This is important for making sure that you are not silently
losing any messages. The web interface can show you a number of write operations
that failed and also a list of failed operations. Like any other information in the
web interface this is also available via the REST APIs so you can hook it into your
own monitoring systems.

.. image:: /images/indexerfailures_1.png

Information about the indexing failure is stored in a capped MongoDB collection that
is limited in size. A lot (many tens of thousands) of failure messages should fit in there but
it should not be considered a complete collection of all errors ever thrown.


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
at :doc:`configuration/index_model` for more information.
