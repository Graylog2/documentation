*****************************
Message rewriting with Drools
*****************************

Graylog can optionally use `Drools Expert <http://www.jboss.org/drools/drools-expert>`_ to evaluate all incoming messages against a user defined
rules file. Each message will be evaluated prior to being written to the outputs.

The rule file location is defined in the Graylog configuration file::

  # Drools Rule File (Use to rewrite incoming log messages)
  rules_file = /etc/graylog.d/rules/graylog.drl

The rules file is located on the file system with a ``.drl`` file extension. The rules file can contain multiple rules, queries and functions,
as well as some resource declarations like imports, globals, and attributes that are assigned and used by your rules and queries.

For more information on the DRL rules syntax please read the `Drools User Guide <http://docs.jboss.org/drools/release/5.5.0.Final/drools-expert-docs/html/ch04.html>`_.

Getting Started
===============

  #. Uncomment the ``rules_file`` line in the Graylog configuration file.
  #. Copy the `sample rules file <https://github.com/Graylog2/graylog2-server/blob/1.0.0/misc/graylog2.drl>`_ to the location specified in your Graylog configuration file.
  #. Modify the rules file to parse/rewrite/filter messages as needed.

Example rules file
==================

This is an example rules file::

  import org.graylog2.plugin.Message

  rule "Rewrite localhost host"
      when
          m : Message( source == "localhost" )
      then
          m.addField("source", "localhost.example.com" );
          System.out.println( "[Overwrite localhost rule fired] : " + m.toString() );
  end

  rule "Drop UDP and ICMP Traffic from firewall"
      when
          m : Message( getField("full_message") matches "(?i).*(ICMP|UDP) Packet(.|\n|\r)*" && source == "firewall" )
      then
          m.setFilterOut(true);
          System.out.println("[Drop all syslog ICMP and UDP traffic] : " + m.toString() );
  end

Parsing Message and adding fields
=================================

In the following script we turn the PID and the src IP into additional fields::

  import org.graylog2.plugin.Message
  import java.util.regex.Matcher
  import java.util.regex.Pattern

  // Raw Syslog Apr 18 15:34:58 server01 smtp-glass[3371]: NEW (1/0) on=1.1.1.1:9100, src=2.2.2.2:38776, ident=, dst=3.3.3.3:25, id=1303151698.3371
  rule "SMTP Glass Logging to GELF"
    when
        m : Message( message matches "^smtp-glass.*" )
    then
        Matcher matcher = Pattern.compile("smtp-glass\\\[(\\\d+)].* src (\\\d+.\\\d+.\\\d+.\\\d+)").matcher(m.getMessage());
        if (matcher.find()) {
           m.addField("_pid", Long.valueOf(matcher.group(1)));
           m.addField("_src", matcher.group(2));
        }
  end

Another example: Adding additional fields and changing the message itself
-------------------------------------------------------------------------

We send Squid access logs to Graylog using Syslog. The problem is that the *host* field of the message was set to the
IP addrress of the Squid proxy, which not very useful. This rule overwrites the source and adds other fields::

  import org.graylog2.plugin.Message
  import java.util.regex.Matcher
  import java.util.regex.Pattern
  import java.net.InetAddress;

  /*
  Raw Syslog: squid[2099]: 1339551529.881  55647 1.2.3.4 TCP_MISS/200 22 GET http://www.google.com/

  squid\[\d+\]: (\d+\.\d+) *(\d+) *(\d+.\d+.\d+.\d+) *(\w+\/\w+) (\d+) (\w+) (.*)
  matched: 13:1339551529.881
  matched: 29:55647
  matched: 35:1.2.3.4
  matched: 47:TCP_MISS/200
  matched: 60:22
  matched: 64:GET
  matched: 68:http://www.google.com/
  */

  rule "Squid Logging to GELF"
      when
          m : Message( getField("facility") == "local5" )
      then
          Matcher matcher = Pattern.compile("squid\\[\\d+\\]: (\\d+.\\d+) *(\\d+) *(\\d+.\\d+.\\d+.\\d+) *(\\w+\\/\\w+) (\\d+) (\\w+) (.*)").matcher(m.getMessage());

          if (matcher.find()) {
              m.setFacility("squid");
              InetAddress addr = InetAddress.getByName(matcher.group(3));
              String host = addr.getHostName();
              m.addField("source",host);
              m.addField("message",matcher.group(6) + " " + matcher.group(7));
              m.addField("_status",matcher.group(4));
              m.addField("_size",matcher.group(5));
          }
  end
