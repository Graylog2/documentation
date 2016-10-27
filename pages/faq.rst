**************************
Frequently asked questions
**************************

General
=======

Do I need to buy a license to use Graylog?
------------------------------------------

We believe software should be open and accessible to all.  You should not have to pay to analyze your own data, no matter how much you have.

Graylog is licensed under the `GNU General Public License <http://www.gnu.org/licenses/gpl-3.0.en.html>`__.  We do not require license fees for production or non-production use.

How long do you support older versions of the Graylog product?
--------------------------------------------------------------

For our commercial support customers, we support older versions of Graylog up to 12 months after the next major release is available. So if you’re using 1.X, you will continue to receive 1.X support up to a full year after 2.0 has been released.

Architecture
============

What is MongoDB used for?
-------------------------

Graylog uses MongoDB to store your configuration data, not your log data. Only metadata is stored, such as user information or stream configurations. None of your log messages are ever stored in MongoDB. This is why MongoDB does not have a big system impact, and you won’t have to worry too much about scaling it. With our recommended setup architecture, MongoDB will simply run alongside your graylog-server processes and use almost no resources.

Can you guide me on how to replicate MongoDB for High Availability?
-------------------------------------------------------------------

MongoDB actually supplies this information as part of their documentation.  Check out
:

* About `MongoDB Replica Sets <https://docs.mongodb.org/manual/replication/>`__.

* How to `convert a standalone MongoDB node to a replica set <https://docs.mongodb.org/manual/tutorial/convert-standalone-to-replica-set/>`__.

After you've done this, add all MongoDB nodes into the replica_set configuration in all graylog-server.conf files.

I have datacenters across the world and do not want logs forwarding from everywhere to a central location due to bandwidth, etc.  How do I handle this?
-------------------------------------------------------------------------------------------------------------------------------------------------------

You can have multiple graylog-server instances in a federated structure, and forward select messages to a centralized GL server.

Which load balancers do you recommend we use with Graylog?
----------------------------------------------------------

You can use any.  We have clients running AWS ELB, HAProxy, F5 BIG-IP, and KEMP.

Isn’t Java slow? Does it need a lot of memory?
----------------------------------------------

This is a concern that we hear from time to time. We understand Java has a bad reputation from slow and laggy desktop/GUI applications that eat a lot of memory. However, we are usually able to prove this assumption wrong. Well written Java code for server systems is very efficient and does not need a lot of memory resources.  

Give it a try, you might be surprised!

Does Graylog encrypt log data?
------------------------------

All log data is stored in Elasticsearch. `Elastic recommends <https://discuss.elastic.co/t/how-should-i-encrypt-data-at-rest-with-elasticsearch/96>`__ you use *dm-crypt* at the file system level.

Where are the log files Graylog produces?
-----------------------------------------

You can find the log data for Graylog under the below directory with timestamps and levels and exeception messages. This is useful for debugging or when the server won't start.

     /var/log/graylog-server/server.log

If you use the pre-build appliances, take a look into

    /var/log/graylog/<servicename>/current

Installation / Setup
====================

Should I download the OVA appliances or the separate packages?
--------------------------------------------------------------

If you are downloading Graylog for the first time to evaluate it, go for the appliance.  It is really easy, and can be quickly setup so you can understand if Graylog is right for you.  If you are wanting to use Graylog at some scale in production, and do things like high availabilty (Mongo replication) we recommend you go for the separate packages.

How do I find out if a specific log source is supported?
--------------------------------------------------------

We support many log sources – and more are coming everyday.  For a complete list, check out `Graylog Marketplace <https://marketplace.graylog.org/>`__, the central repository of Graylog extensions. There are 4 types of content on the Marketplace:

* Plug-Ins: Code that extends Graylog to support a specific use case that it doesn’t support out of the box.

* Content Pack: A file that can be uploaded into your Graylog system that sets up streams, inputs, extractors, dashboards, etc. to support a given log source or use case.

* GELF Library: A library for a programming language or logging framework that supports sending log messages in GELF format for easy integration and pre-structured messages.

* Other Solutions: Any other content or guide that helps you integrate Graylog with an external system or device. For example, how to configure a specific device to support a format Graylog understands out of the box.

Can I install the Graylog Server on Windows?
--------------------------------------------

Even though our engineers say it is “technically possible”, don’t do it.  The Graylog server is built using Java, so technically it can run anywhere. But we currently have it optimized to run better on other operating systems. If you don’t feel comfortable running your own Linux system, we recommend you use our Linux virtual appliance which will run under VMWare.

Functionality
=============

Can Graylog automatically clean old data?
-----------------------------------------

Absolutely we have :doc:`data retention features <index_model>`.

Does Graylog support LDAP / AD and its groups?
----------------------------------------------

Yup, we’re all over this too with read/write roles and group permissions.  To start, see :doc:`this <users_and_roles/external_auth>`.  If you want to get very granular, you can go through the Graylog REST API.

Do we have a user audit log for compliance?
-------------------------------------------

`Graylog Enterprise <https://www.graylog.org/enterprise>`_ includes an audit log plugin. You can explore the :ref:`documentation <auditlog_toc>` for more details.

It seems like Graylog has no reporting functionality?
-----------------------------------------------------

That’s correct. We currently don’t have built-in reporting functionality that sends automated reports. However, you can use our REST API to generate and send you own reports. A cron job and the scripting language of your choice should do the trick.

Can I filter inbound messages before they are processed by the Graylog server?
------------------------------------------------------------------------------

Yes, check out our page on how to use :doc:`blacklisting <blacklisting>`.

Dedicated Partition for the Journal
-----------------------------------
If you create a dedicated Partition for your Kafka Journal, you need to watch that this is a clean directory. Even *lost+found* can break it, for `your reference <https://github.com/Graylog2/graylog2-server/issues/2348>`_.

.. _raise_java_heap:

Raise the Java Heap
-------------------
If you need to raise the Java Heap of the Graylog Server or Elasticsearch in a System that runs as virtual appliances you can use :ref:`the advanced settings <graylog_ctl_advanced>`.

On Systems that are installed with :ref:`DEB / APT <operationg_package_DEB-APT>` this setting can be made in ``/etc/default/graylog-server``. 

Systems that are installed with :ref:`RPM / YUM / DNF <operating_package_rpm-yum-dnf>` the file is found in ``/etc/sysconfig/graylog-server``. 


Graylog & Integrations
======================

What is the best way to integrate my applications to Graylog?
-------------------------------------------------------------
We recommend that you use :doc:`GELF <sending_data>`.  It's easy for your application developers and eliminates the need to store the messages locally.  Also, GELF can just send what app person wants so you don't have to build extractors or do any extra processing in Graylog.

I have a log source that creates dynamic syslog messages based on events and subtypes and grok patterns are difficult to use - what is the best way to handle this?
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
Not a problem!  Use our :doc:`key=value extractor <extractors>`.

I want to archive my log data. Can I write to another database, for example HDFS / Hadoop, from Graylog?
--------------------------------------------------------------------------------------------------------

Yes, you can output data from Graylog to a different database. We currently have an HDFS output `plug-in <https://marketplace.graylog.org/addons/99259226-6ba3-48c8-a710-9598b65eda0e>`__ in the Marketplace - thank you `sivasamyk <https://github.com/sivasamyk>`__!

It’s also easy and fun to :doc:`write your own <plugins>`, which you can then add to Graylog Marketplace for others to use.

I don’t want to use Elasticsearch as my backend storage system – can I use another database, like MySQL, Oracle, etc?
---------------------------------------------------------------------------------------------------------------------

You can, but we don’t suggest you do. You will not be able to use our query functionality or our analytic engine on the dataset outside the system. We only recommend another database if you want it for secondary storage.

How can I create a restricted user to check internal Graylog metrics in my monitoring system?
---------------------------------------------------------------------------------------------

You can create a restricted user which only has access to the ``/system/metrics`` resource on the Graylog REST API.
This way it will be possible to integrate the internal metrics of Graylog into your monitoring system.
Giving the user only restriced access will minimize the impact of these creadentials getting compromised.

Send a POST request via the Graylog API Browser or curl to the ``/roles`` resource of the Graylog REST API::

  {
    "name": "Metrics Access",
    "description": "Provides read access to all system metrics",
    "permissions": ["metrics:*"],
    "read_only": false
   }

The following curl command will create the required role (modify the URL of the Graylog REST API, here ``http://127.0.0.1:9000/api/``, and the user credentials, here ``admin``/``admin``, according to your setup)::
  
  $ curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"name": "Metrics Access", "description": "Provides read access to all system metrics", "permissions": ["metrics:*"], "read_only": false}' 'http://127.0.0.1:9000/api/roles'


Troubleshooting
===============

I’m sending in messages, and I can see they are being accepted by Graylog, but I can’t see them in the search.  What is going wrong?
------------------------------------------------------------------------------------------------------------------------------------

A common reason for this issue is that the timestamp in the message is wrong. First, confirm that the message was received by selecting ‘all messages’ as the time range for your search. Then identify and fix the source that is sending the wrong timestamp.

I have configured an SMTP server or an output with TLS connection and receive handshake errors. What should I do?
-----------------------------------------------------------------------------------------------------------------
 
Outbound TLS connections have CA (*certification authority*) certificate verification enabled by default. In case the target server's certificate is not signed by a CA found from trust store, the connection will fail. A typical symptom for this is the following error message in the server logs::
 
  Caused by: javax.mail.MessagingException: Could not convert socket to TLS; nested exception is: javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
 
This should be corrected by either adding the missing CA certificates to the Java default trust store (typically found at ``$JAVA_HOME/jre/lib/security/cacerts``), or a custom store that is configured (by using ``-Djavax.net.ssl.trustStore``) for the Graylog server process. The same procedure applies for both missing valid CAs and self-signed certificates.

For Debian/Ubuntu-based systems using OpenJDK JRE, CA certificates may be added to the systemwide trust store. After installing the JRE (including ``ca-certificates-java``, ergo ``ca-certificates`` packages), place ``name-of-certificate-dot-crt`` (in PEM format) into ``/usr/local/share/ca-certificates/`` and run ``/usr/sbin/update-ca-certificates``. The hook script in ``/etc/ca-certificates/update.d/`` should automatically generate ``/etc/ssl/certs/java/cacerts``.

Fedora/RHEL-based systems may refer to `Shared System Certificates in the Fedora Project Wiki <https://fedoraproject.org/wiki/Features/SharedSystemCertificates>`__.

Suddenly parts of Graylog did not work as expected
--------------------------------------------------
If you notice multiple different non working parts in Graylog and found something like ``java.lang.OutOfMemoryError: unable to create new native thread`` in your Graylog Server logfile, you need to raise the process/thread limit of the graylog user. The limit can be checked with ``ulimit -u`` and you need to check how you can raise ``nproc`` in your OS.

Have another troubleshooting question?
--------------------------------------

See below for some additional support options where you can ask your question.

Support
=======

I think I’ve found a bug, how do I report it?
----------------------------------------------

Think you spotted a bug? Oh no! Please report it in our issue trackers so we can take a look at it.  All issue trackers are hosted on `GitHub <https://github.com/Graylog2>`__, tightly coupled to our code and milestones. Don’t hesitate to open issues – we’ll just close them if there is nothing to do. We have GitHub repos for the `web interface <https://github.com/Graylog2/graylog2-web-interface/issues>`__ and the `server <https://github.com/Graylog2/graylog2-server/issues>`__.

I’m having issues installing or configuring Graylog, where can I go for support?
--------------------------------------------------------------------------------

Check out our Google Group `mailing list <https://groups.google.com/forum/?hl=en#!forum/graylog2>`__ – you can search for your problem which may already have an answer, or post a new question.

Another source is the `#Graylog IRC chat channel on Freenode <https://webchat.freenode.net/?channels=%23graylog>`__.  Our developers and a lot of community members hang out here. Just join the channel and add any questions, suggestions or general topics you have.

If you’re looking for professional commercial support from the Graylog team, we do that too.  Please `get in touch here <https://www.graylog.org/professional-support>`__ for more details.
