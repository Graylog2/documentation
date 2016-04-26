.. _blacklisting:

************
Blacklisting
************

.. note:: Since Graylog 2.0 you can use the :doc:`processing pipelines <pipelines>` for blacklisting.

If you have messages coming into Graylog that should be discarded before being written to Elasticsearch
or forwarded to another system you can use :ref:`Drools rules <drools>` to perform custom filtering.

The rule file location is defined in the Graylog configuration file::

  # Drools Rule File (Use to rewrite incoming log messages)
  rules_file = /etc/graylog.d/rules/graylog.drl

The rules file is located on the file system with a ``.drl`` file extension. The rules file can contain multiple rules, queries and functions,
as well as some resource declarations like imports, globals, and attributes that are assigned and used by your rules and queries.

For more information on the DRL rules syntax please read the `Drools User Guide <http://docs.jboss.org/drools/release/5.5.0.Final/drools-expert-docs/html/ch04.html>`_.

How to
======

The general idea is simple: Any ``Message`` marked with ``setFilterOut(true)`` will be discarded when processed in the Graylog filter chain.
You can either :ref:`write and load your own filter plugin <plugins>` that can execute any Java code to mark messages or just use
the :ref:`Drools rules <drools>`. The following example shows how to do this.

Based on regular expressions
============================

Put this into your ``rules_file``::

    import org.graylog2.plugin.Message
    import java.util.regex.Matcher
    import java.util.regex.Pattern

    rule "Blacklist all messages that start with 'firewall'"
      when
          m : Message( message matches "^firewall.*" )
      then
          System.out.println("DEBUG: Blacklisting message."); // Don't do this in production.
          m.setFilterOut(true);
    end

This rule will blacklist any message that starts with the string "firewall" (``matches "^firewall.*"``).
