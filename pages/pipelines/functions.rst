*********
Functions
*********

.. warning:: This documentation is work in progress

Overview
========

Functions are the means of how to interact with the messages Graylog processes.

They are written in Java and are pluggable, allowing extending the capabilities of Graylog in a simple manner.

Conceptually a function receives parameters, the current message context and returns a value. The data types of its
return value and parameters determines where in the rules it can be used. Graylog makes sure the rules are sound
from a data type perspective.

A function's parameters can be passed as named pairs or by position, as long as optional parameters are declared as coming
last. The function's documentation below indicates which parameters are optional.

Let's look at a small example to illustrate these properties::

    rule "function howto"
    when
        has_field("transaction_date")
    then
        // the following date format assumes there's no time zone in the string
        let new_date = parse_date(to_string($message.transaction_date), "yyyy-MM-dd HH:mm:ss");
        set_field("transaction_year", new_date.year);
    end

In this example, we check if the current message contains the field ``some_date`` and then, after converting it to a string,
try to parse it according to the format string ``yyyy-MM-dd HH:mm:ss``, so for example the string ``2016-03-05 14:45:02``
would match. Parse date returns a ``DateTime`` object from the Java Joda-Time library, allowing easier access to the date's
components.

We then add the transaction's year as a new field to the message.

You'll note that we haven't said in which time zone the timestamp is in, but still Graylog had to pick one (Graylog never
relies on the local time of your server as that makes it nearly impossible to figure out why date handling came up with its
result).

The reason Graylog knows which timezone to pick is because ``parse_date`` actually takes three parameters rather than
the two we've given it in this example. The third one is a ``String`` called ``timezone`` and is optional. It has a default value of
``"UTC"``.

Let's assume we have another field in the message, called ``transaction_timezone``. It is send by the application and
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

Now, if the time zone is specified in the other field, we pass it to ``parse_date``.

In this case we only have a single optional parameter, which makes it easy to simply omit it from the end of the function
call. However, if there are multiple ones, or if there are many parameters and it gets difficult to keep track of which
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

All parameters in Graylog's processing functions are named, please refer to the function index.

Function Index
==============

The following list describes the built in functions that ship with Graylog. Additional third party functions are available via
other plugins in the marketplace.


.. list-table:: Built-in Functions
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - `to_bool`_
      - Converts the single parameter to a boolean value using its string value.
    * - `to_double`_
      - Converts the first parameter to a double floating point value.
    * - `to_long`_
      - Converts the first parameter to a long integer value.
    * - `to_string`_
      - Converts the first parameter to its string representation.
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
    * - `regex`_
      - Match a regular expression against a string, with matcher groups.
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
    * - `now`_
      - Returns the current date and time.
    * - `parse_date`_
      - Parses a date and time from the given string, according to a strict pattern.
    * - `flex_parse_date`_
      - Attempts to parse a date and time using the Natty date parser.
    * - `format_date`_
      - Formats a date and time according to a given formatter pattern.
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

to_bool
-------
``to_bool(any)``

Converts the single parameter to a boolean value using its string value.

to_double
---------
``to_double(any, [default: double])``

Converts the first parameter to a double floating point value.

to_long
-------
``to_long(any, [default: long])``

Converts the first parameter to a long integer value.

to_string
---------
``to_string(any, [default: string])``

Converts the first parameter to its string representation.

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

regex
-----
``regex(pattern: string, value: string, [group_names: array[string])``

Match the regular expression in ``pattern`` against ``value``. Returns a match object, with the boolean property
``matches`` to indicate whether the regular expression matched and, if requested, the matching groups as ``groups``.
The groups can optionally be named using the ``group_names`` array. If not named, the groups names are strings starting with ``"0"``.

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

now
---
``now([timezone: string])``

Returns the current date and time. Uses the default time zone ``UTC``.

parse_date
----------
``parse_date(value: string, pattern: string, [timezone: string])``

Parses the ``value`` into a date and time object, using the ``pattern``. If no timezone is detected in the pattern, the optional
timezone parameter is used as the assumed timezone. If omitted the timezone defaults to ``UTC``.

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

Routes the ``messsage`` to the given stream. The stream can be looked up by either
specifying its ``name`` or the ``id``.

If ``message`` is omitted, this function uses the currently processed message.

This causes the message to be evaluated on the pipelines connected to that stream, unless the stream has already been
processed for this message.

create_message
--------------
``create_message([message: string], [source: string], [timestamp: DateTime])``

Creates a new message with from the given parameters. If any of them is omitted, its value is taken from the currently
processed message. If ``timestamp`` is omitted, the timestamp of the created message will be the timestamp at that moment.

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
``set_field(field: string, value: any, [message: Message])``

Sets the given field named ``field`` to the new ``value``. The ``field`` name must be valid, and specifically cannot include
a ``.`` character. It is trimmed of leading and trailing whitespace. String values are trimmed of whitespace as well.

If ``message`` is omitted, this function uses the currently processed message.

set_fields
----------
``set_fields(fields: Map<string, any>, [message: Message])``

Sets all of the given name-value pairs in ``field`` in the given message. This is a convenience function
acting like `set_field`_. It can be helpful for using the result of a function like `select_jsonpath`_ or `regex`_ in the
currently processed message especially when the key names are the result of a regular expression.

If ``message`` is omitted, this function uses the currently processed message.
