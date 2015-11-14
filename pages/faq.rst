**************************
Frequently asked questions
**************************

General
=======

Do I need to buy a license to use Graylog?
------------------------------------------

We believe software should be open and accessible to all.  You should not have to pay to analyze your own data, no matter how much you have.

Graylog is licensed under the `GNU General Public License <http://www.gnu.org/licenses/gpl-3.0.en.html>`_.  We do not require license fees for production or non-production use.

How long do you support older versions of the Graylog product?
--------------------------------------------------------------

For our commercial support customers, we support older versions of Graylog up to 12 months after the next major release is available. So if you’re using 1.X, you will continue to receive 1.X support up to a full year after 2.0 has been released.

Architecture
============

What is MongoDB used for?
-------------------------

Graylog uses MongoDB to store your configuration data, not your log data. Only metadata is stored, such as user information or stream configurations. None of your log messages are ever stored in MongoDB. This is why MongoDB does not have a big system impact, and you won’t have to worry too much about scaling it. With our recommended setup architecture, MongoDB will simply run alongside your graylog-server processes and use almost no resources.

We have plans to introduce a database abstraction layer in the future. This will give you the flexibility to run MongoDB, MySQL or any other database to store metadata.

Can you guide me on how to replicate MongoDB for High Availability?
-------------------------------------------------------------------

MongoDB actually supplies this information as part of their documentation.  Check out
:

* About `MongoDB Replica Sets <https://docs.mongodb.org/manual/replication/>`_.

* How to `convert a standalone MongoDB node to a replica set <https://docs.mongodb.org/manual/tutorial/convert-standalone-to-replica-set/>`_.

I have datacenters across the world and do not want logs forwarding from everywhere to a central location due to bandwidth, etc.  How do I handle this?
---------------------------------------------------------------------------------------------------------------------------

You can have multiple graylog-server instances in a federated structure, and forward select messages to a centralized GL server.

Which load balancers do you recommend we use with Graylog?
----------------------------------------------------------

You can use any.  We have clients running AWS ELB, HAProxy, F5 BIG-IP, and KEMP.

Isn’t Java slow? Does it need a lot of memory?
-----------------------------------------------

This is a concern that we hear from time to time. We understand Java has a bad reputation from slow and laggy desktop/GUI applications that eat a lot of memory. However, we are usually able to prove this assumption wrong. Well written Java code for server systems is very efficient and does not need a lot of memory resources.

Give it a try, you might be surprised!

Installation / Setup
====================

Should I download the OVA appliances or the separate packages?
--------------------------------------------------------------

If you are downloading Graylog for the first time to evaluate it, go for the appliance.  It is really easy, and can be quickly setup so you can understand if Graylog is right for you.  If you are wanting to use Graylog at some scale in production, and do things like high availabilty (Mongo replication) we recommend you go for the separate packages.

How do I find out if a specific log source is supported?
--------------------------------------------------------

We support many log sources – and more are coming everyday.  For a complete list, check out `Graylog Marketplace <https://marketplace.graylog.org/>`_, the central repository of Graylog extensions. There are 4 types of content on the Marketplace:

* Plug-Ins: Code that extends Graylog to support a specific use case that it doesn’t support out of the box.

* Content Pack: A file that can be uploaded into your Graylog system that sets up streams, inputs, extractors, dashboards, etc. to support a given log source or use case.

* GELF Library: A library for a programming language or logging framework that supports sending log messages in GELF format for easy integration and pre-structured messages.

* Other Solutions: Any other content or guide that helps you integrate Graylog with an external system or device. For example, how to configure a specific device to support a format Graylog understands out of the box.

Can I install the Graylog Server on Windows?
--------------------------------------------

Even though our engineers say it is “technically possible”, don’t do it.  The Graylog server is built using Java, so technically it can run anywhere. But we currently have it optimized to run better on other operating systems. If you don’t feel comfortable running your own Linux system, we recommend you use our Linux virtual appliance which will run under VMWare.

Functionality
============

Can Graylog automatically clean old data?
-----------------------------------------

Absolutely we have data retention features, please see `here <http://docs.graylog.org/en/1.2/pages/index_model.html?highlight=retention>`_.

Does Graylog support LDAP / AD and its groups?
----------------------------------------------

Yup, we’re all over this too with read/write roles and group permissions.  To start, see `this <http://docs.graylog.org/en/1.2/pages/users_roles.html?highlight=ldap#external-authentication>`_.  If you want to get very granular, you can go through our Rest API.

Do we have a user audit log for compliance?
-------------------------------------------

Coming soon in a future release – stay tuned!

It seems like Graylog has no reporting functionality?
-----------------------------------------------------

That’s correct. We currently don’t have built-in reporting functionality that sends automated reports. However, you can use our REST API to generate and send you own reports. A cron job and the scripting language of your choice should do the trick.

Can I filter inbound messages before they are processed by the Graylog server?
------------------------------------------------------------------------------

Yes, check out our page on how to use `blacklisting <http://docs.graylog.org/en/latest/pages/blacklisting.html>`_.

Graylog & Integrations
======================

What is the best way to integrate my applications to Graylog?
-------------------------------------------------------------
We recommend that you use `GELF <http://docs.graylog.org/en/latest/pages/sending_data.html?highlight=gelf#gelf-sending-from-applications>`_.  It's easy for your application developers and eliminates the need to store the messages locally.  Also, GELF can just send what app person wants so you don't have to build extractors or do any extra processing in Graylog.

I have a log source that creates dynamic syslog messages based on events and subtypes and grok patterns are difficult to use - what is the best way to handle this?
----------------------------------------------------------------------------------------------------------------------------
Not a problem!  Use our `key=value extractor <http://docs.graylog.org/en/1.2/pages/extractors.html#automatically-extract-all-key-value-pairs>`_.

I want to archive my log data. Can I write to another database, for example HDFS / Hadoop, from Graylog?
--------------------------------------------------------------------------------------------------------

Yes, you can output data from Graylog to a different database. We currently have an HDFS output `plug-in <https://marketplace.graylog.org/addons/99259226-6ba3-48c8-a710-9598b65eda0e>`_ in the Marketplace - thank you `sivasamyk <https://github.com/sivasamyk>`_!

It’s also easy and fun to `write your own <http://docs.graylog.org/en/1.2/pages/plugins.html#creating-a-plugin-skeleton>`_, which you can then add to Graylog Marketplace for others to use.

I don’t want to use Elasticsearch as my backend storage system – can I use another database, like MySQL, Oracle, etc?
---------------------------------------------------------------------------------------------------------------------

You can, but we don’t suggest you do. You will not be able to use our query functionality or our analytic engine on the dataset outside the system. We only recommend another database if you want it for secondary storage.

Troubleshooting
===============

I’m sending in messages, and I can see they are being accepted by Graylog, but I can’t see them in the search.  What is going wrong?
--------------------------------------------------------------------------------------------------------

A common reason for this issue is that the timestamp in the message is wrong. First, confirm that the message was received by selecting ‘all messages’ as the time range for your search. Then identify and fix the source that is sending the wrong timestamp.

Have another troubleshooting question?
--------------------------------------

See below for some additional support options where you can ask your question.

Support
============

I think I’ve found a bug, how do I report it?
----------------------------------------------

Think you spotted a bug? Oh no! Please report it in our issue trackers so we can take a look at it.  All issue trackers are hosted on `GitHub <https://github.com/Graylog2>`_, tightly coupled to our code and milestones. Don’t hesitate to open issues – we’ll just close them if there is nothing to do. We have GitHub repos for the `web interface <https://github.com/Graylog2/graylog2-web-interface/issues>`_ and the `server <https://github.com/Graylog2/graylog2-server/issues>`_.

I’m having issues installing or configuring Graylog, where can I go for support?
--------------------------------------------------------------------------------

Check out our Google Group `mailing list <https://groups.google.com/forum/?hl=en#!forum/graylog2>`_ – you can search for your problem which may already have an answer, or post a new question.

Another source is the `#Graylog IRC chat channel on Freenode <https://webchat.freenode.net/?channels=%23graylog>`_.  Our developers and a lot of community members hang out here. Just join the channel and add any questions, suggestions or general topics you have.

If you’re looking for professional commercial support from the Graylog team, we do that too.  Please `get in touch here <https://www.graylog.org/support-packages/>`_ for more details.
