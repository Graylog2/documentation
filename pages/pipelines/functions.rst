*********
Functions
*********

**Warning: this documentation is work in progress**

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
        let new_date = parse_date(tostring($message.transaction_date), "yyyy-MM-dd HH:mm:ss");
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
                            tostring($message.transaction_date),
                            "yyyy-MM-dd HH:mm:ss",
                            tostring($message.transaction_timezone)
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
                            value: tostring($message.transaction_date),
                            pattern: "yyyy-MM-dd HH:mm:ss",
                            timezone: tostring($message.transaction_timezone)
                    );
        set_field("transaction_year", new_date.year);
    end

All parameters in Graylog's processing functions are named, please refer to the function index.

Function Index
==============

The following list describes the built in functions that ship with Graylog. Additional third party functions are available via
other plugins in the marketplace.

**Function index table forthcoming**