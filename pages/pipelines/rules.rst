*****
Rules
*****

Overview
========

Rules are the cornerstone of processing pipelines. They contain the logic about how to change, enrich, route, and drop messages.

To avoid the complexities of a complete programming language, Graylog supports a small rule language to express processing logic.
The rule language is intentionally limited to allow for easier understanding, faster learning, and better runtime optimization.

The real work of rules is done in *functions*, which are completely pluggable. Graylog already ships with a great number of built-in functions,
providing data conversion, string manipulation, data retrieval using :ref:`lookup tables <lookuptables>`, JSON parsing, and much more.

We expect that special purpose functions will be written and shared by the community, enabling faster innovation and problem solving than previously possible.

Rule Structure
==============

Building upon the previous example in the :doc:`pipelines` section, let's look at examples of some of the rules we've referenced::

    rule "has firewall fields"
    when
        has_field("src_ip") && has_field("dst_ip")
    then
    end


::

    rule "from firewall subnet"
    when
        cidr_match("10.10.10.0/24", to_ip($message.gl2_remote_ip))
    then
    end

Firstly, apart from naming the rule structure follows a simple *when, then* pattern. In the *when* clause we specify
a boolean expression which is evaluated in the context of the current message in the pipeline. These are the conditions
used by the pipeline processor to determine whether to run a rule, and collectively (when evaluating the containing stage's
``match all`` or ``match any`` requirement) whether to continue in a pipeline.

Note that the *has firewall fields* rule uses the built-in function ``has_field`` to check whether the message has
the ``src_ip`` and ``dst_ip`` fields, as we want to use them in a later stage of the pipeline.  This rule has
no actions to run in its *then* clause, since we only want to use it to determine whether subsequent stages should run.

The second rule, *from firewall subnet*, uses the built-in function `cidr_match`, which takes a `CIDR pattern <https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation>`_
and an IP address. In this case we reference a field from the currently-processed message using the message reference syntax ``$message``.

Graylog always sets the ``gl2_remote_ip`` field on messages, so we don't need to check whether that field exists.  If we wanted to use a
field that might not exist on all messages we'd first use the ``has_field`` function to ensure its presence.

Note the call to ``to_ip`` around the ``gl2_remote_ip`` field reference. This is necessary since the field is stored as a *string* internally, and ``cidr_match``
requires an IP address object for its ``ip`` parameter.

Requiring an explicit conversion to an IP address object demonstrates an important feature of Graylog's rule language: enforcement of type safety to
ensure that you end up with the data in the correct format. All too often everything is treated as a string, which wastes enormous amounts of cycles
on data conversion and prevents proper analysis of the data.

We again have no actions to run, since we're just using the rule to manage the pipeline's flow, so the *then* block is empty.

You might be wondering why we didn't just combine the *has firewall fields* and *from firewall subnet* rules, since they seem to be serving the same purpose.
While we could absolutely do so, recall that rules are intended to be reusable building blocks.  Imagine you have a another pipeline for a different
firewall subnet.  Rather than duplicating the logic to check for ``src_ip`` and ``dst_ip``, and updating each rule if anything ever changes (e.g. additional fields),
you can simply add the *has firewall fields* rule to your new stage. With this approach you only need to update a single rule, with the change immediatedly
taking effect for all pipelines referencing it. Nice!

Data Types
==========

As we have seen in the previous section, we need to make sure to use the proper data types when calling functions.

Graylog's rule language parser rejects invalid use of types, making it safe to write rules.

The six built-in types in Graylog are ``string`` (a UTF-8 string), ``double`` (corresponds to Java's ``Double``),
``long`` (Java's ``Long``), ``boolean`` (``Boolean``), ``void`` (indicating a function has no return value to prevent it
being used in a condition), and ``ip`` (a subset of ``InetAddress``), but plugins are free
to add additional types as they see fit. The rule processor takes care of ensuring that values and functions agree on the types
being used.

By convention, functions that convert types start with the prefix ``to_``.  Please refer to the :doc:`functions` index for a list.

Conditions
==========

In Graylog's rules the **when** clause is a boolean expression, which is evaluated against the processed message.

Expressions support the common boolean operators ``AND`` (or ``&&``), ``OR`` (``||``), ``NOT`` (``!``), and comparison operators
(``<``, ``<=``, ``>``, ``>=``, ``==``, ``!=``).

Any function that returns a value can be called in the **when** clause, but it must eventually evaluate to a boolean.  For example: we were
able to use ``to_ip`` in the *from firewall subnet* since it was being passed to ``cidr_match``, which returns a boolean, but could not
use ``route_to_stream`` since it doesn't return a value.

The condition must not be empty, but can simply consist of the boolean literal ``true``.  This is useful when you always want to execute a rule's actions.

If a condition calls a function which is not present (perhaps due to a typo or missing plugin) the call evaluates to ``false``.


Actions
=======

A rule's **then** clause contains a list of actions which are evaluated in the order they appear.

There are two different types of actions:

- Function calls
- Variable assignments

Function calls look exactly like they do in conditions.  All functions, including those which do not return a value, may be used in the **then** clause.

Variable assignments have the following form::

    let name = value;

Variables are useful to avoid recomputing expensive parsing of data, holding on to temporary values, or making rules more readable.

Variables need to be defined before they can be used.  Their fields (if any) can be accessed using the ``name.field`` notation in any place
where a value of the field's type is required.

The list of actions can be empty, in which case the rule is essentially a pluggable condition to help manage a pipeline's processing flow.
