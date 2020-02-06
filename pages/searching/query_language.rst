Search query language
---------------------

Syntax
^^^^^^

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

  type:(ssh OR login)

.. note:: Elasticsearch 2.x and 5.x split queries on whitespace, so the query ``type:(ssh login)`` was equivalent to ``type:(ssh OR login)``.
  This is no longer the case in `Elasticsearch 6.0 <https://www.elastic.co/guide/en/elasticsearch/reference/6.6/breaking-changes-6.0.html#_changes_to_queries>`__
  and you must now include an ``OR`` operator between each term.

Messages where the field *type* includes the exact phrase *ssh login*::

  type:"ssh login"

Messages that have the field *type*::

  _exists_:type

Messages that do not have the field *type*::

  NOT _exists_:type

.. note:: Elasticsearch 2.x allows to use ``_missing_:type`` instead of ``NOT _exists_:type``. This query syntax has been removed in `Elasticsearch 5.0 <https://www.elastic.co/guide/en/elasticsearch/reference/5.0/breaking_50_search_changes.html#_deprecated_queries_removed>`__.

Messages that match regular expression ``ethernet[0-9]+``::

  /ethernet[0-9]+/

.. note:: Please refer to the Elasticsearch documentation about the `Regular expression syntax <https://www.elastic.co/guide/en/elasticsearch/reference/5.6/query-dsl-regexp-query.html#regexp-syntax>`_ for details about the supported regular expression dialect.


By default all terms or phrases are OR connected so all messages that have at least one hit are returned. You can use
**Boolean operators and groups** for control over this::

  "ssh login" AND source:example.org
  ("ssh login" AND (source:example.org OR source:another.example.org)) OR _exists_:always_find_me

You can also use the NOT operator::

  "ssh login" AND NOT source:example.org
  NOT example.org

**Note that AND, OR, and NOT are case sensitive and must be typed in all upper-case.**

**Wildcards:** Use `?` to replace a single character or `*` to replace zero or more characters::

  source:*.org
  source:exam?le.org
  source:exam?le.*

**Note that leading wildcards are disabled to avoid excessive memory consumption!** You can enable them in
your Graylog configuration file::

  allow_leading_wildcard_searches = true

Also note that ``message``, ``full_message``, and ``source`` are the only fields that are being analyzed by default.
While wildcard searches (using ``*`` and ``?``) work on all indexed fields, analyzed fields will behave a little bit different.
See `wildcard and regexp queries <https://www.elastic.co/guide/en/elasticsearch/guide/2.x/_wildcard_and_regexp_queries.html>`_ for details.

**Fuzziness:** You can search for similar terms::

  ssh logni~
  source:exmaple.org~

This example is using the `Damerau–Levenshtein distance <http://en.wikipedia.org/wiki/Damerau-Levenshtein_distance>`_ with a default
distance of *2* and will match "ssh login" and "example.org" (intentionally misspelled in the query).

You can change the distance like this::

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

It is possible make a **range query** on the date field. It is important that the selected period of time at the timepicker fits the range you want to search in. If you search in the last 5 minutes, but the searched time is a week in the past the query will not return anything. The dates needs to be UTC and the format needs to be like Graylog displays them.::

  timestamp:["2019-07-23 09:53:08.175" TO "2019-07-23 09:53:08.575"]

Escaping
^^^^^^^^

The following characters must be escaped with a backslash::

  & | : \ / + - ! ( ) { } [ ] ^ " ~ * ?

Example::

  resource:\/posts\/45326

