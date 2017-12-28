*********
Functions
*********

Overview
========

Functions are the means of interacting with the messages Graylog processes.

Functions are written in Java and are pluggable, allowing Graylog's pipeline processing capabilities to be easily extended.

Conceptually a function receives parameters, the current message context, and (potentially) returns a value. The data types of its
return value and parameters determine where it can be used in a rule. Graylog ensures the rules are sound
from a data type perspective.

A function's parameters can either be passed as named pairs or position, as long as optional parameters are declared as coming
last. The functions' documentation below indicates which parameters are optional by wrapping them in square brackets.

Let's look at a small example to illustrate these properties::

    rule "function howto"
    when
        has_field("transaction_date")
    then
        // the following date format assumes there's no time zone in the string
        let new_date = parse_date(to_string($message.transaction_date), "yyyy-MM-dd HH:mm:ss");
        set_field("transaction_year", new_date.year);
    end

In this example, we check if the current message contains the field ``transaction_date`` and then, after converting it to a string,
try to parse it according to the format string ``yyyy-MM-dd HH:mm:ss``, so for example the string ``2016-03-05 14:45:02``
would match. The ``parse_date`` function returns a ``DateTime`` object from the Java Joda-Time library, allowing easier access to the date's
components.

We then add the transaction's year as a new field, ``transaction_year`` to the message.

You'll note that we didn't specify a time zone for our date, but Graylog still had to pick one. Graylog never
relies on the local time of your server, as that makes it nearly impossible to figure out why date handling came up with its result.

The reason Graylog knows which timezone to use is because ``parse_date`` actually takes four parameters, rather than
the two we've given it in this example. The other two parameters are a ``String`` called ``timezone`` (default value: ``"UTC"``)
and a ``String`` called ``locale`` (default value: the default locale of the system running Graylog) which both are optional.

Let's assume we have another message field called ``transaction_timezone``, which is sent by the application and
contains the time zone ID the transaction was done in (hopefully no application in the world sends its data like this, though)::

    rule "function howto"
    when
        has_field("transaction_date") && has_field("transaction_timezone")
    then
        // the following date format assumes there's no time zone in the string
        let new_date = parse_date(
                            to_string($message.transaction_date),
                            "yyyy-MM-dd HH:mm:ss",
                            to_string($message.transaction_timezone)
                    );
        set_field("transaction_year", new_date.year);
    end

Now we're passing the ``parse_date`` function its ``timezone`` parameter the string value of the message's ``transaction_timezone`` field.

In this case we only have a single optional parameter, which makes it easy to simply omit it from the end of the function
call. However, if there are multiple optional parameters, or if there are so many parameters that it gets difficult to keep track of which
positions correspond to which parameters, you can also use the named parameter variant of function calls. In this mode
the order of the parameters does not matter, but all required ones still need to be there.

In our case the alternative version of calling ``parse_date`` would look like this::

    rule "function howto"
    when
        has_field("transaction_date") && has_field("transaction_timezone")
    then
        // the following date format assumes there's no time zone in the string
        let new_date = parse_date(
                            value: to_string($message.transaction_date),
                            pattern: "yyyy-MM-dd HH:mm:ss",
                            timezone: to_string($message.transaction_timezone)
                    );
        set_field("transaction_year", new_date.year);
    end

All parameters in Graylog's processing functions, listed below, are named.

Function Index
==============

The following list describes the built-in functions that ship with Graylog. Additional third party functions are available via
plugins in the marketplace.


.. list-table:: Built-in Functions
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - `debug`_
      - Print the passed value as string in the Graylog log.
    * - `to_bool`_
      - Converts the single parameter to a boolean value using its string value.
    * - `to_double`_
      - Converts the first parameter to a double floating point value.
    * - `to_long`_
      - Converts the first parameter to a long integer value.
    * - `to_string`_
      - Converts the first parameter to its string representation.
    * - `to_url`_
      - Converts a value to a valid URL using its string representation.
    * - `is_null`_
      - Checks whether a value is 'null'.
    * - `is_not_null`_
      - Checks whether a value is not 'null'.
    * - `abbreviate`_
      - Abbreviates a String using ellipses.
    * - `capitalize`_
      - Capitalizes a String changing the first letter to title case.
    * - `uncapitalize`_
      - Uncapitalizes a String changing the first letter to lower case.
    * - `uppercase`_
      - Converts a String to upper case.
    * - `lowercase`_
      - Converts a String to lower case.
    * - `swapcase`_
      - Swaps the case of a String.
    * - `contains`_
      - Checks if a string contains another string.
    * - `substring`_
      - Returns a substring of ``value`` with the given start and end offsets.
    * - `concat`_
      - Concatenates two strings.
    * - `split`_
      - Split a string around matches of this pattern (Java syntax).
    * - `regex`_
      - Match a regular expression against a string, with matcher groups.
    * - `grok`_
      - Applies a Grok pattern to a string.
    * - `key_value`_
      - Extracts key/value pairs from a string.
    * - `crc32`_
      - Returns the hex encoded CRC32 digest of the given string.
    * - `crc32c`_
      - Returns the hex encoded CRC32C (RFC 3720, Section 12.1) digest of the given string.
    * - `md5`_
      - Returns the hex encoded MD5 digest of the given string.
    * - `murmur3_32`_
      - Returns the hex encoded MurmurHash3 (32-bit) digest of the given string.
    * - `murmur3_128`_
      - Returns the hex encoded MurmurHash3 (128-bit) digest of the given string.
    * - `sha1`_
      - Returns the hex encoded SHA1 digest of the given string.
    * - `sha256`_
      - Returns the hex encoded SHA256 digest of the given string.
    * - `sha512`_
      - Returns the hex encoded SHA512 digest of the given string.
    * - `parse_json`_
      - Parse a string into a JSON tree.
    * - `select_jsonpath`_
      - Selects one or more named JSON Path expressions from a JSON tree.
    * - `to_ip`_
      - Converts the given string to an IP object.
    * - `cidr_match`_
      - Checks whether the given IP matches a CIDR pattern.
    * - `from_input`_
      - Checks whether the current message was received by the given input.
    * - `route_to_stream`_
      - Assigns the current message to the specified stream.
    * - `create_message`_
      - **Currently incomplete** Creates a new message which will be evaluated by the entire processing pipeline.
    * - `clone_message`_
      - Clones a message.
    * - `drop_message`_
      - This currently processed message will be removed from the processing pipeline after the rule finishes.
    * - `has_field`_
      - Checks whether the currently processed message contains the named field.
    * - `remove_field`_
      - Removes the named field from the currently processed message.
    * - `set_field`_
      - Sets the name field to the given value in the currently processed message.
    * - `set_fields`_
      - Sets multiple fields to the given values in the currently processed message.
    * - `rename_field`_
      - Rename a message field.
    * - `syslog_facility`_
      - Converts a syslog facility number to its string representation.
    * - `syslog_level`_
      - Converts a syslog level number to its string representation.
    * - `expand_syslog_priority`_
      - Converts a syslog priority number to its level and facility.
    * - `expand_syslog_priority_as_string`_
      - Converts a syslog priority number to its level and facility string representations.
    * - `now`_
      - Returns the current date and time.
    * - `parse_date`_
      - Parses a date and time from the given string, according to a strict pattern.
    * - `flex_parse_date`_
      - Attempts to parse a date and time using the Natty date parser.
    * - `format_date`_
      - Formats a date and time according to a given formatter pattern.
    * - `to_date`_
      - Converts a type to a date.
    * - `years`_
      - Create a period with a specified number of years.
    * - `months`_
      - Create a period with a specified number of months.
    * - `weeks`_
      - Create a period with a specified number of weeks.
    * - `days`_
      - Create a period with a specified number of days.
    * - `hours`_
      - Create a period with a specified number of hours.
    * - `minutes`_
      - Create a period with a specified number of minutes.
    * - `seconds`_
      - Create a period with a specified number of seconds.
    * - `millis`_
      - Create a period with a specified number of millis.
    * - `period`_
      - Parses an ISO 8601 period from the specified string.
    * - `lookup`_
      - Looks up a multi value in the named lookup table.
    * - `lookup_value`_
      - Looks up a single value in the named lookup table.

debug
-----
``debug(value: any)``

Print any passed value as string in the Graylog log.

Note that the debug message will only appear in the log of the Graylog node that was processing the message you are trying to debug.

Example::

    // Print: "INFO : org.graylog.plugins.pipelineprocessor.ast.functions.Function - PIPELINE DEBUG: Dropped message from <source>"
    let debug_message = concat("Dropped message from ", to_string($message.source));
    debug(debug_message);

to_bool
-------
``to_bool(value: any)``

Converts the single parameter to a boolean value using its string value.

to_double
---------
``to_double(value: any, [default: double])``

Converts the first parameter to a double floating point value.

to_long
-------
``to_long(value: any, [default: long])``

Converts the first parameter to a long integer value.

to_string
---------
``to_string(value: any, [default: string])``

Converts the first parameter to its string representation.

to_url
------
``to_url(url: any, [default: string])``

Converts the given ``url`` to a valid URL.

is_null
-------
``is_null(value: any)``

Checks if the given value is ``null``.

is_not_null
-----------
``is_not_null(value: any)``

Checks if the given value is not ``null``.

abbreviate
----------
``abbreviate(value: string, width: long)``

Abbreviates a String using ellipses, the width defines the maximum length of the resulting string.

capitalize
----------
``capitalize(value: string)``

Capitalizes a String changing the first letter to title case.

uncapitalize
------------
``uncapitalize(value: string)``

Uncapitalizes a String changing the first letter to lower case.


uppercase
---------
``uppercase(value: string, [locale: string])``

Converts a String to upper case. The locale (IETF BCP 47 language tag) defaults to "en".

lowercase
---------
``lowercase(value: string, [locale: string])``

Converts a String to lower case. The locale (IETF BCP 47 language tag) defaults to "en".

swapcase
--------
``swapcase(value: string)``

Swaps the case of a String changing upper and title case to lower case, and lower case to upper case.

contains
--------
``contains(value: string, search: string, [ignore_case: boolean])``

Checks if ``value`` contains ``search``, optionally ignoring the case of the search pattern.

substring
---------
``substring(value: string, start: long, [end: long])``

Returns a substring of ``value`` starting at the ``start`` offset (zero based indices), optionally ending at
the ``end`` offset. Both offsets can be negative, indicating positions relative to the end of ``value``.

concat
------
``concat(first: string, second: string)``

Returns a new string combining the text of ``first`` and ``second``.

split
-----
``split(pattern: string, value: string, [limit: int])``

Split a ``value`` around matches of ``pattern``. Use ``limit`` to indicate the number of times the pattern
should be applied.

**Note**: Patterns have to be valid `Java String literals <https://docs.oracle.com/javase/tutorial/essential/regex/literals.html>`_,
please ensure you escape any backslashes in your regular expressions!

regex
-----
``regex(pattern: string, value: string, [group_names: array[string])``

Match the regular expression in ``pattern`` against ``value``. Returns a match object, with the boolean property
``matches`` to indicate whether the regular expression matched and, if requested, the matching groups as ``groups``.
The groups can optionally be named using the ``group_names`` array. If not named, the groups names are strings starting with ``"0"``.

**Note**: Patterns have to be valid `Java String literals <https://docs.oracle.com/javase/tutorial/essential/regex/literals.html>`_,
please ensure you escape any backslashes in your regular expressions!

grok
----
``grok(pattern: string, value: string, [only_named_captures: boolean])``

Applies the grok pattern ``grok`` to ``value``. Returns a match object, containing a Map of field names and values.
You can set ``only_named_captures`` to ``true`` to only return matches using named captures.

**Tip**: The result of executing the ``grok`` function can be passed as argument for `set_fields`_ to set the extracted fields
into a message.

key_value
---------
::

  key_value(
    value: string,
    [delimiters: string],
    [kv_delimiters: string],
    [ignore_empty_values: boolean],
    [allow_dup_keys: boolean],
    [handle_dup_keys: string],
    [trim_key_chars: string],
    [trim_value_chars: string]
  )

Extracts key-value pairs from the given ``value`` and returns them as a Map of field names and values. You can optionally specify:

``delimiters``
  Characters used to separate pairs. We will use each character in the string, so you do not need to separate them. Default value: ``<whitespace>``.
``kv_delimiters``
  Characters used to separate keys from values. Again, there is no need to separate each character. Default value: ``=``.
``ignore_empty_values``
  Ignores keys containing empty values. Default value: ``true``.
``allow_dup_keys``
  Indicates if duplicated keys are allowed. Default value: ``true``.
``handle_dup_keys``
  How to handle duplicated keys (if ``allow_dup_keys`` is set). It can take the values ``take_first``, which will only use the first value for the key;
  or ``take_last``, which will only use the last value for the key. Setting this option to any other value will change the handling to concatenate, which
  will combine all values given to the key, separating them with the value set in this option. For example, setting ``handle_dup_keys: ","``, would
  combine all values given to a key ``a``, separating them with a comma, such as ``1,2,foo``. Default value: ``take_first``.
``trim_key_chars``
  Characters to trim (remove from the beginning and end) from keys. Default value: no trim.
``trim_value_chars``
  Characters to trim (remove from the beginning and end) from values. Default value: no trim.

**Tip**: The result of executing the ``key_value`` function can be passed as argument for `set_fields`_ to set the extracted fields
into a message.

crc32
-----
``crc32(value: string)``

Creates the hex encoded CRC32 digest of the ``value``.

crc32c
------
``crc32c(value: string)``

Creates the hex encoded CRC32C (RFC 3720, Section 12.1) digest of the ``value``.

md5
---
``md5(value: string)``

Creates the hex encoded MD5 digest of the ``value``.

murmur3_32
----------
``murmur3_32(value: string)``

Creates the hex encoded MurmurHash3 (32-bit) digest of the ``value``.

murmur3_128
-----------
``murmur3_128(value: string)``

Creates the hex encoded MurmurHash3 (128-bit) digest of the ``value``.

sha1
----
``sha1(value: string)``

Creates the hex encoded SHA1 digest of the ``value``.

sha256
------
``sha256(value: string)``

Creates the hex encoded SHA256 digest of the ``value``.

sha512
------
``sha512(value: string)``

Creates the hex encoded SHA512 digest of the ``value``.

parse_json
----------
``parse_json(value: string)``

Parses the ``value`` string as JSON, returning the resulting JSON tree.

select_jsonpath
---------------
``select_jsonpath(json: JsonNode, paths: Map<string, string>)``

Evaluates the given ``paths`` against the ``json`` tree and returns the map of the resulting values.

to_ip
-----
``to_ip(ip: string)``

Converts the given ``ip`` string to an IpAddress object.

cidr_match
----------
``cidr_match(cidr: string, ip: IpAddress)``

Checks whether the given ``ip`` address object matches the ``cidr`` pattern.


from_input
----------
``from_input(id: string | name: string)``

Checks whether the currently processed message was received on the given input. The input can be looked up by either
specifying its ``name`` (the comparison ignores the case) or the ``id``.

route_to_stream
---------------
``route_to_stream(id: string | name: string, [message: Message])``

Routes the ``message`` to the given stream. The stream can be looked up by either
specifying its ``name`` or the ``id``.

If ``message`` is omitted, this function uses the currently processed message.

This causes the message to be evaluated on the pipelines connected to that stream, unless the stream has already been
processed for this message.

create_message
--------------
``create_message([message: string], [source: string], [timestamp: DateTime])``

Creates a new message with from the given parameters. If any of them is omitted, its value is taken from the corresponding
fields of the currently processed message. If ``timestamp`` is omitted, the timestamp of the created message will 
be the timestamp at that moment.

clone_message
-------------
``clone_message([message: Message])``

Clones a message. If ``message`` is omitted, this function uses the currently processed message.

drop_message
------------
``drop_message(message: Message)``

The processing pipeline will remove the given ``message`` after the rule is finished executing.

If ``message`` is omitted, this function uses the currently processed message.

This can be used to implement flexible blacklisting based on various conditions.

has_field
---------
``has_field(field: string, [message: Message])``

Checks whether the given ``message`` contains a field with the name ``field``.

If ``message`` is omitted, this function uses the currently processed message.

remove_field
------------
``remove_field(field: string, [message: Message])``

Removes the given field with the name ``field`` from the given ``message``, unless the field is reserved.

If ``message`` is omitted, this function uses the currently processed message.

set_field
---------
``set_field(field: string, value: any, [prefix: string], [suffix: string], [message: Message])``

Sets the given field named ``field`` to the new ``value``. The ``field`` name must be valid, and specifically cannot include
a ``.`` character. It is trimmed of leading and trailing whitespace. String values are trimmed of whitespace as well.

The optional ``prefix`` and ``suffix`` parameters specify which prefix or suffix should be added to the inserted field name.

If ``message`` is omitted, this function uses the currently processed message.

.. _set_fields:

set_fields
----------
``set_fields(fields: Map<string, any>, [prefix: string], [suffix: string], [message: Message])``

Sets all of the given name-value pairs in ``field`` in the given message. This is a convenience function
acting like `set_field`_. It can be helpful for using the result of a function like `select_jsonpath`_ or `regex`_ in the
currently processed message especially when the key names are the result of a regular expression.

The optional ``prefix`` and ``suffix`` parameters specify which prefix or suffix should be added to the inserted field names.

If ``message`` is omitted, this function uses the currently processed message.

rename_field
------------
``rename_field(old_field: string, new_field: string, [message: Message])``

Modifies the field name ``old_field`` to ``new_field`` in the given message, keeping the field value unchanged.

syslog_facility
---------------
``syslog_facility(value: any)``

Converts the `syslog facility number <https://tools.ietf.org/html/rfc3164#section-4.1.1>`_ in ``value`` to its string representation.

syslog_level
------------
``syslog_level(value: any)``

Converts the `syslog severity number <https://tools.ietf.org/html/rfc3164#section-4.1.1>`_ in ``value`` to its string representation.

expand_syslog_priority
----------------------
``expand_syslog_priority(value: any)``

Converts the `syslog priority number <https://tools.ietf.org/html/rfc3164#section-4.1.1>`_ in ``value`` to its numeric severity and facility values.

expand_syslog_priority_as_string
--------------------------------
``expand_syslog_priority_as_string(value: any)``

Converts the `syslog priority number <https://tools.ietf.org/html/rfc3164#section-4.1.1>`_ in ``value`` to its severity and facility string representations.

now
---
``now([timezone: string])``

Returns the current date and time. Uses the default time zone ``UTC``.

parse_date
----------
``parse_date(value: string, pattern: string, [locale: string], [timezone: string])``

Parses the ``value`` into a date and time object, using the ``pattern``. If no timezone is detected in the pattern, the optional
timezone parameter is used as the assumed timezone. If omitted the timezone defaults to ``UTC``.

The format used for the ``pattern`` parameter is identical to the pattern of the `Joda-Time DateTimeFormat <http://www.joda.org/joda-time/apidocs/org/joda/time/format/DateTimeFormat.html>`_.

======  ===========================  ============  ==================================
Symbol  Meaning                      Presentation  Examples
======  ===========================  ============  ==================================
``G``   era                          text          AD
``C``   century of era (>=0)         number        20
``Y``   year of era (>=0)            year          1996
``x``   weekyear                     year          1996
``w``   week of weekyear             number        27
``e``   day of week                  number        2
``E``   day of week                  text          Tuesday; Tue
``y``   year                         year          1996
``D``   day of year                  number        189
``M``   month of year                month         July; Jul; 07
``d``   day of month                 number        10
``a``   halfday of day               text          PM
``K``   hour of halfday (0~11)       number        0
``h``   clockhour of halfday (1~12)  number        12
``H``   hour of day (0~23)           number        0
``k``   clockhour of day (1~24)      number        24
``m``   minute of hour               number        30
``s``   second of minute             number        55
``S``   fraction of second           millis        978
``z``   time zone                    text          Pacific Standard Time; PST
``Z``   time zone offset/id          zone          -0800; -08:00; America/Los_Angeles
``'``   escape for text              delimiter
``''``  single quote                 literal       '
======  ===========================  ============  ==================================

The format used for the ``locale`` parameter is a valid language tag according to `IETF BCP 47 <https://tools.ietf.org/html/bcp47>`_ which can be parsed by the `Locale#forLanguageTag(String) <https://docs.oracle.com/javase/8/docs/api/java/util/Locale.html#forLanguageTag-java.lang.String->`_ method.

Also see `IANA Language Subtag Registry <https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry>`_.

If no locale was specified, the locale of the system running Graylog (the default locale) is being used.

Examples:

============  ====================================
Language Tag  Description
============  ====================================
``en``        English
``en-US``     English as used in the United States
``de-CH``     German for Switzerland
============  ====================================


flex_parse_date
---------------
``flex_parse_date(value: string, [default: DateTime], [timezone: string])``

Uses the `Natty date parser <http://natty.joestelmach.com/>`_ to parse a date and time ``value``. If no timezone is detected in
the pattern, the optional timezone parameter is used as the assumed timezone. If omitted the timezone defaults to ``UTC``.

In case the parser fails to detect a valid date and time the ``default`` date and time is being returned, otherwise the expression
fails to evaluate and will be aborted.

format_date
-----------
``format_date(value: DateTime, format: string, [timezone: string])``

Returns the given date and time ``value`` formatted according to the ``format`` string. If no timezone is given,
it defaults to ``UTC``.

to_date
-------
``to_date(value: any, [timezone: string])``

Converts ``value`` to a date. If no ``timezone`` is given, it defaults to ``UTC``.

years
-----
``years(value: long)``

Create a period with ``value`` number of years.

months
------
``months(value: long)``

Create a period with ``value`` number of months.

weeks
-----
``weeks(value: long)``

Create a period with ``value`` number of weeks.

days
----
``days(value: long)``

Create a period with ``value`` number of days.

hours
-----
``hours(value: long)``

Create a period with ``value`` number of hours.

minutes
-------
``minutes(value: long)``

Create a period with ``value`` number of minutes.

seconds
-------
``seconds(value: long)``

Create a period with ``value`` number of seconds.

millis
------
``millis(value: long)``

Create a period with ``value`` number of milliseconds.

period
------
``period(value: string)``

Parses an ISO 8601 period from ``value``.

lookup
------
``lookup(lookup_table: string, key: any, [default: any])``

Looks up a multi value in the named lookup table.

lookup_value
------------
``lookup_value(lookup_table: string, key: any, [default: any])``

Looks up a single value in the named lookup table.
