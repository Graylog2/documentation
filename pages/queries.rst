*************************
The search query language
*************************

Syntax
======

The search syntax is very close to the Lucene syntax. By default all message fields are included in the search if you don't specify a message
field to search in.

Messages that include the term *ssh*::

  ssh

Messages that include the term *ssh* or *login*::

  ssh login

Messages that include the exact phrase *ssh login*::

  "ssh login"

Messages where the field *type* includes *ssh*::

  type:ssh

Messages where the field *type* includes *ssh* or *login*::

  type:(ssh login)

Messages where the field *type* includes the exact phrase *ssh login*::

  type:"ssh login"

Messages that do not have the field *type*::

  _missing_:type

Messages that have the field *type*::

  _exists_:type

By default all terms or phrases are OR connected so all messages that have at least one hit are returned. You can use
**Boolean operators and groups** for control over this::

  "ssh login" AND source:example.org
  ("ssh login" AND (source:example.org OR source:another.example.org)) OR _exists_:always_find_me

You can also use the NOT operator::

  "ssh login" AND NOT source:example.org
  NOT example.org

**Wildcards:** Use `?` to replace a single character or `*` to replace zero or more characters::

  source:*.org
  source:exam?le.org
  source:exam?le.*

**Note that leading wildcards are disabled to avoid excessive memory consumption!** You can enable them in
your ``graylog-server.conf``: ``allow_leading_wildcard_searches = true``

**Fuzziness:** You can search for similar but not equal terms::

  ssh logni~
  source:exmaple.org~

This is using the `Damerau–Levenshtein distance <http://en.wikipedia.org/wiki/Damerau-Levenshtein_distance>`_ with a default
distance of *2*. You can change the distance like this::

  source:exmaple.org~1

You can also use the fuzzyness operator to do a **proximity** search where the terms in a phrase can have different/fuzzy
distances from each other and don't have to be in the defined order::

  "foo bar"~5

Numeric fields support **range queries**. Ranges in square brackets are inclusive, curly brackets are exclusive and can
even be combined::

  http_response_code:[500 TO 504]
  http_response_code:{400 TO 404}
  bytes:{0 TO 64]
  http_response_code:[0 TO 64}

You can also do searches with one side unbounded::

  http_response_code:>400
  http_response_code:<400
  http_response_code:>=400
  http_response_code:<=400

It is also possible to combine unbounded range operators::

  http_response_code:(>=400 AND <500)

Escaping
========

The following characters must be escaped with a backslash::

  && || : \ / + - ! ( ) { } [ ] ^ " ~ * ?

Example::

  resource:\/posts\/45326

Time frame selector
===================

The time frame selector defines in what time range to search in. It offers three different ways of selecting a time range and
is vital for search speed: If you know you are only interested in messages of the last hour, only search in that time frame.
This will make Graylog search in relevant indices only and greatly reduce system load and required resources. You can read
more about this here: :doc:`index_model`

Keyword time frame selector
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Graylog offers a keyword time frame selector that allows you to specify the time frame for the search in natural language like *last hour* or *last 90 days*. The web interface shows a preview of the two actual timestamps that will be used for the search.

.. image:: /images/queries_keyword_time_selector.png

Here are a few examples for possible values.

* "last month" searches between one month ago and now
* "4 hours ago" searches between four hours ago and now
* "1st of april to 2 days ago" searches between 1st of April and 2 days ago
* "yesterday midnight +0200 to today midnight +0200" searches between yesterday midnight and today midnight in timezone +0200 - will be 22:00 in UTC

The time frame is parsed using the `natty natural language parser <http://natty.joestelmach.com/>`_. Please consult its documentation for details.

Search result highlighting
==========================

Graylog supports search result highlighting since v0.20.2:

.. image:: /images/search_result_highlighting.png

Enabling/Disabling search result highlighting
---------------------------------------------

Using search result highlighting will result in slightly higher resource consumption of searches. You can enable and disable
it using a configuration parameter in the ``graylog.conf`` of your ``graylog-server`` nodes::

    allow_highlighting = true
