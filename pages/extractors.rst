**********
Extractors
**********

The problem to solve
********************

Syslog (`RFC3146 <http://tools.ietf.org/html/rfc3146>`_, `RFC5424 <http://tools.ietf.org/html/rfc5424>`_) is the de facto
standard logging protocol since the 80s and was originally developed as part of the sendmail project. It comes with some
annoying shortcomings that we tried to improve in `GELF <http://www.graylog.org/gelf>`_ for application logging.

Because syslog has a clear specification in its RFCs it should be possible to parse it relatively easy. Unfortunately
there are a lot of devices (especially routers and firewalls) out there that send logs looking like syslog but actually
breaking several rules stated in the RFCs. We tried to write a parser that reads all of them as good as possible and
failed. Such a loosely defined text message usually breaks the compatibility in the first date field already. Some
devices leave out hostnames completely, some use localized timezone names (MESZ instead of CEST) and some just omit the
current year.

Then there are devices out there that at least do not claim to send syslog when they don't but have another completely
separate log format that needs to be parsed specifically.

We decided not to write custom message inputs and parsers for all those thousands of devices, formats, firmwares and
configuration parameters out there but came up with the concept of *Extractors* in the *v0.20.0* series of Graylog.

Graylog extractors explained
****************************

The extractors allow you to instruct ``graylog-server`` nodes about how to extract data from any text in the received
message (no matter from which format or if an already extracted field) to message fields. You may already know why
structuring data into fields is important if you are using Graylog: There are a lot of analysis possibilities with
full text searches but the real power of log analytics unveils when you can run queries like
``http_response_code:>=500 AND user_id:9001`` to get all HTTP 500s that were triggered by a specific user.

Wouldn't it be nice to be able to search for all blocked packages of a given source IP or to get a quickterms analysis
of recently failed SSH login usernames? Hard to do when all you have is just a single long text message.

Creating extractors is possible via either Graylog REST API calls or directly from the web interface using a wizard. Select
a message input and hit *Manage extractors* in the actions menu. The wizard allows you to load a message to try your extractor
configuration against. You can extract data using for example regular expressions, grok patterns, substrings or even
by splitting the message into tokens by separator characters. The wizard looks like this and should be pretty intuitive:

.. image:: /images/extractors_1.png

You can also choose to apply so called *converters* on the extracted value to for example convert a string consisting
of numbers to an integer/double (important for range searches later), anonymize IP addresses, lowercase/uppercase a
string, build a hash value or much more.

The extractor directory
***********************

The `data source library <https://www.graylog2.org/supported-sources>`_ contains a lot of extractors that you can easily
import into your Graylog setup.

Just copy the JSON extractor export into the import dialog of an input of the fitting type (Every extractor set entry in
the directory tells you what type of input to spawn. For example syslog, GELF or plaintext.) and you are good to go.
The next message coming in should already include the extracted fields with possibly converted values.

A message sent by Heroku and received by Graylog with the imported *Heroku* extractor set on a plaintext TCP input
looks like this: (look at the extracted fields in the message detail view)

.. image:: /images/extractors_2.png

Using regular expressions to extract data
*****************************************

Extractors support matching field values using regular expressions.
Graylog uses the `Java Pattern class <http://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html>`_ to
evaluate regular expressions.

For the individual elements of regular expression syntax, please refer to Oracle's documentation, however the syntax
largely follows the familiar regular expression languages in widespread use today and will be familiar to most.

However, one key question that is often raised is matching a string in case insensitive manner. Java regular expressions
are case sensitive by default. Certain flags, such as the one to ignore case sensitivity can either be set in the code,
or as an inline flag in the regular expression.

To for example create an extractor that matches the browser name in the following user agent string::

  Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.107 Safari/537.36

the regular expression ``(applewebkit)`` will not match because it is case sensitive.
In order to match the expression using any combination of upper- and lowercase characters use the ``(?i)`` flag as such::

  (?i)(applewebkit)

Most of the other flags supported by Java are rarely used in the context of matching stream rules or extractors, but if
you need them their use is documented on the same Javadoc page by Oracle. One common reason to use regular expression flags
in your regular expression is to make use of what is called non-capturing groups. Those are parentheses which only group
alternatives, but do not make Graylog extract the data they match and are indicated by ``(?:)``.

Using Grok patterns to extract data
***********************************

Graylog also supports the extracting data using the popular Grok language to allow you to make use of your existing patterns.

Grok is a set of regular expressions that can be combined to more complex patterns, allowing to name different parts of the
matched groups.

By using Grok patterns, you can extract multiple fields from a message field in a single extractor, which often simplifies
specifying extractors.

Simple regular expressions are often sufficient to extract a single word or number from a log line, but if you know the entire
structure of a line beforehand, for example for an access log, or the format of a firewall log, using Grok is advantageous.

For example a firewall log line could contain::

  len=50824 src=172.17.22.108 sport=829 dst=192.168.70.66 dport=513

We can now create the following patterns on the ``System/Grok Patterns`` page in the web interface::

  BASE10NUM (?<![0-9.+-])(?>[+-]?(?:(?:[0-9]+(?:\.[0-9]+)?)|(?:\.[0-9]+)))
  NUMBER (?:%{BASE10NUM})
  IPV6 ((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?
  IPV4 (?<![0-9])(?:(?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2}))(?![0-9])
  IP (?:%{IPV6}|%{IPV4})

Then, in the extractor configuration, we can use these patterns to extract the relevant fields from the line::

  len=%{NUMBER:length} src=%{IP:srcip} sport=%{NUMBER:srcport} dst=%{IP:dstip} dport=%{NUMBER:dstport}

This will add the relevant extracted fields to our log message, allowing Graylog to search on those individual fields, which
can lead to more effective search queries by allowing to specifically look for packets that came from a specific source IP
instead of also matching destination IPs if one would only search for the IP across all fields.

There are many resources are the web with useful patterns, and one very helpful tool is the `Grok Debugger <http://grokdebug.herokuapp.com/>`_,
which allows you to test your patterns while you develop them.

Graylog uses `Java Grok <http://grok.nflabs.com/>`_ to parse and run Grok patterns.

Normalization
*************

Many log formats are similar to each other, but not quite the same. In particular they often only differ in the names attached
to pieces of information.

For example, consider different hardware firewall vendors, whose models log the destination IP in different fields of the message,
some use ``dstip``, some ``dst`` and yet others use ``destination-address``::

  2004-10-13 10:37:17 PDT Packet Length=50824, Source address=172.17.22.108, Source port=829, Destination address=192.168.70.66, Destination port=513
  2004-10-13 10:37:17 PDT len=50824 src=172.17.22.108 sport=829 dst=192.168.70.66 dport=513
  2004-10-13 10:37:17 PDT length="50824" srcip="172.17.22.108" srcport="829" dstip="192.168.70.66" dstport="513"

You can use one or more non-capturing groups to specify the alternatives of the field names, but still be able to extract the a
parentheses group in the regular expression. Remember that Graylog will extract data from the first matched group of the regular
expression. An example of a regular expression matching the destination IP field of all those log messages from above is::

    (?:dst|dstip|[dD]estination\saddress)="?(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"?

This will only extract the IP address without caring about which of the three naming schemes was used in the original log message.
This way you don't have to set up three different extractors.

The standard date converter
===========================

Date parser converters for extractors allow you to convert extracted data into timestamps - Usually used to set the timestamp of
a message based on some date it contains. Let's assume we have this message from a network device::

  <131>: foo-bar-dc3-org-de01: Mar 12 00:45:38: %LINK-3-UPDOWN: Interface GigabitEthernet0/31, changed state to down

Extracting most of the data is not a problem and can be done easily. Using the date in the message (`Mar 12 00:45:38`) as Graylog
message timestamp however needs to be done with a date parser converter.

Use a standard extractor rule to select the timestamp and apply the *Date* converter with a format string::

    MMM dd HH:mm:ss

(format string table at the end of this page)

.. image:: /images/dateparser_1.png
.. image:: /images/dateparser_2.png

The flexible date converter
===========================

Now imagine you had one of those devices that send messages that are not so easy to parse because they do not follow a strict
timestamp format. Some network devices for example like to send days of the month without adding a padding 0 for the first 9 days.
You'll have dates like ``Mar 9`` and ``Mar 10`` and end up having problems defining a parser string for that. Or maybe you have
something else that is really exotic like just *last wednesday* as timestamp. The flexible date converter is accepting any
text data and tries to build a date from that as good as it can.

Examples:

* **Mar 12**, converted at 12:27:00 local time in the year 2014: 2014-03-12T12:27:00.000
* **2014-3-12 12:27**: 2014-03-12T12:27:00.000
* **Mar 12 2pm**: 2014-03-12T14:00:00.000

Note that the flexible date converter always uses the local timezone unless you have timezone information in the parsed text.

Standard date converter format string table
-------------------------------------------

======  ============================  ============  ===================================
Symbol  Meaning                       Presentation  Examples
======  ============================  ============  ===================================
G       era                           text          AD
C       century of era (>=0)          number        20
Y       year of era (>=0)             year          1996

x       weekyear                      year          1996
w       week of weekyear              number        27
e       day of week                   number        2
E       day of week                   text          Tuesday; Tue

y       year                          year          1996
D       day of year                   number        189
M       month of year                 month         July; Jul; 07
d       day of month                  number        10

a       halfday of day                text          PM
K       hour of halfday (0~11)        number        0
h       clockhour of halfday (1~12)   number        12

H       hour of day (0~23)            number        0
k       clockhour of day (1~24)       number        24
m       minute of hour                number        30
s       second of minute              number        55
S       fraction of second            millis        978

z       time zone                     text          Pacific Standard Time; PST
Z       time zone offset/id           zone          -0800; -08:00; America/Los_Angeles

'       escape for text               delimiter
''      single quote                  literal       '
======  ============================  ============  ===================================
