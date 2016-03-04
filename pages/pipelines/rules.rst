*****
Rules
*****

**Warning: this documentation is work in progress**

Overview
========

Rules are the cornerstone of the processing pipelines. They contain the logic about how to change, enrich route and drop messages.

To avoid the complexities of a complete programming language, Graylog supports a small rule language to express the processing logic.
The rule language is limited on purpose to allow for easier understanding, better runtime optimization and fast learning.

The real work of rules is done in *functions* which are completely pluggable. Graylog already ships with a great number of built-in functions
that range from converting data types over string processing, like ``substring``, ``regex`` etc, to JSON parsing.

We expect that special purpose functions will be written and shared by the community, allow for faster innovation and problem solving than previously possible.

Rule structure
==============

Picking up from the previous example in the :doc:`pipelines` section, let's look at examples of some of the rules we've referenced::

    rule "has firewall fields"
    when
        has_field("src_ip") && has_field("dst_ip")
    then
    end


::

    rule "from firewall subnet"
    when
        cidr_match("10.10.10.0/24", toip($message.gl2_remote_ip))
    then
    end

Firstly, apart from naming the rule, their structure follows a simple *if, then* pattern. In the *when* clause we specify
a boolean expression which is evaluated in the context of the current message in the pipeline. These are the conditions
that are being used by the pipeline processor to determine whether to run a rule and collectively whether to continue in a
pipeline.

Note that we are already calling the built-in function ``has_field`` with a field name. In the rule *has firewall fields*
we make sure the message contains both ``src_ip`` as well as ``dst_ip`` as we want to use them in a later stage.

The rule has no actions to run, because we are only interested in using it as a condition at this point.

The second rule uses another built-in function `cidr_match`. That functions takes a `CIDR pattern <https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation>`_
and an IP address. In this case we reference a field from the currently processed message using the message reference syntax ``$message``.

The field ``gl2_remote_ip`` is always set by Graylog upon receiving a messages, so we do not check whether that field exists, otherwise
we would have used another ``has_field`` function call to make sure it is there.

However, note the call to ``toip`` around the field reference. This is necessary because the field is stored as a *string* internally.
In order to successfully match the CIDR pattern, we need to convert it to an IP address.

This is an important feature of Graylog's rule language, it enforces type safety to ensure that you end up with the data in the
correct format. All too often everything is treated as a string, which wastes enormous amounts of cycles to convert data all the time
as well as preventing to do proper analysis over the data.

Again we have no actions to immediately run, so the *then* block is empty.

Data Types
==========

As we have seen in the previous section, we need to make sure to use the proper data types when calling functions.

Graylog's rule language parser rejects invalid use of types, making it safe to write rules.

The six built-in types in Graylog are ``string`` (a UTF-8 string), ``double`` (corresponds to Java's ``Double``),
``long`` (Java's ``Long``), ``boolean`` (``Boolean``), ``void`` (indicating a function has no return value to prevent it
being used in a condition) and ``ip`` (a subset of ``InetAddress``), but plugins are free
to add additional types as they see fit. The rule processor takes care of ensuring that values and functions agree on the types
being used.

Conventionally functions that convert types start with the prefix ``to``, please refer to the :doc:`functions` for a list.
