*********************
Initial Configuration
*********************

Once the application is installed, there are a few items that must be configured before Graylog may be started for the first time. Both the Graylog ``server.conf`` and Elasticsearch ``elasticsearch.yml`` files are configuration files that contain key details needed for initial configuration. 

This guide will provide you with the essential settings to get Graylog up and running. There are many other important settings in these files and we encourage you to review them once you are up and running. For more details, please see :ref:`server/.conf`.

.. note:: If you are using the virtual appliance, please skip this section and go directly to :ref:`connect`.

server.conf
-----------

The file ``server.conf`` is the Graylog configuration file. The default location for ``server.conf`` is: ``/etc/graylog/server/server.conf``. 

.. note:: All default file locations are listed :ref:`here<default_file_location>`.

* Entries are generally expected to be a single line of the form, one of the following:
    * ``propertyName=propertyValue``
    * ``propertyName:propertyValue``
* White space that appears between the property name and property value is ignored, so the following are equivalent:
    * ``name=Stephen``
    * ``name = Stephen``
* White space at the beginning of the line is also ignored.
* Lines that start with the comment characters ``!`` or ``#`` are ignored. Blank lines are also ignored.
* The property value is generally terminated by the end of the line. 
* White space following the property value is not ignored, and is treated as part of the property value.
* The characters newline, carriage return, and tab can be inserted with characters ``\n``, ``\r``, and ``\t``, respectively.


General Properties
^^^^^^^^^^^^^^^^^^

* ``is_master = true``
    * If you are running more than one instances of Graylog server you must designate (only) one ``graylog-server`` node as the master. This node will perform periodical and maintenance actions that slave nodes won't.
* ``password_secret = <secret>``
    * You MUST set a secret that is used for password encryption and salting. The server will refuse to start if this value is not set. Use at least 64 characters.  If you run multiple ``graylog-server`` nodes, make sure you use the same ``password_secret`` for all of them!

    .. note:: Generate a secret with for example ``pwgen -N 1 -s 96``.
	
* ``root_username = admin``
    * The default root user is named **admin**.
* ``root_password_sha2 = <SHA2>``
    * A SHA2 hash of the password you will use for your initial login. Insert a SHA2 hash generated with ``echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1`` and you will be able to log in to the web interface with username **admin** and password **yourpassword**.

    .. caution:: You MUST specify a hash password for the root user (which you only need to initially set up the system and in case you lose connectivity to your authentication backend). This password cannot be changed using the API or via the web interface. If you need to change it, modify it in this file.

Web Properties
^^^^^^^^^^^^^^

* ``http_bind_address = 127.0.0.1:9000``
        * The network interface used by the Graylog HTTP interface.
        * This address and port is used by default in the ``http_publish_uri``

* ``http_publish_uri = http://127.0.0.1:9000/``
        * Web interface listen URI.
        * The HTTP URI of this Graylog node which is used by all clients using the Graylog web interface.

Elasticsearch Properties
^^^^^^^^^^^^^^^^^^^^^^^^
* ``elasticsearch_hosts = http://node1:9200,http://user:password@node2:19200``
    * List of Elasticsearch hosts Graylog should connect to.
    * Need to be specified as a comma-separated list of valid URIs for the http ports of your elasticsearch nodes.
    * If one or more of your elasticsearch hosts require authentication, include the credentials in each node URI that requires authentication.
    * Default: ``http://127.0.0.1:9200`` You may retain the default setting only if Elasticsearch is installed on the same host as the Graylog server.



MongoDB
^^^^^^^
* ``mongodb_uri = mongdb://...``
    * MongoDB connection string. Enter your MongoDB connection and authentication information here.
    * See https://docs.mongodb.com/manual/reference/connection-string/ for details.
    * Examples:
        - Simple: ``mongodb_uri = mongodb://localhost/graylog``
        - Authenticate against the MongoDB server: ``mongodb_uri = mongodb://grayloguser:secret@localhost:27017/graylog``
        - Use a replica set instead of a single host: ``mongodb_uri = mongodb://grayloguser:secret@localhost:27017,localhost:27018,localhost:27019/graylog?replicaSet=rs01``

Outgoing HTTP
^^^^^^^^^^^^^

* ``http_proxy_uri =``
    * HTTP proxy for outgoing HTTP connections
* ``http_non_proxy_hosts =``
    * A list of hosts that should be reached directly, bypassing the configured proxy server.
    * This is a list of patterns separated by ”,”. The patterns may start or end with a “*” for wildcards.
    * Any host matching one of these patterns will be reached through a direct connection instead of through a proxy.

    


elasticsearch.yml
-----------------

``Elasticsearch.yml`` is  the Elasticsearch configuration file. The default location for elasticsearch.yml is: ``/etc/elasticsearch/elasticsearch.yml``.

Several values must be properly configured in order for elasticsearch to work properly.

* ``cluster.name: graylog``
	* This value may be set to anything the customer wishes, though we recommend using "graylog".
	* This value must be the same for every Elasticsearch node in a cluster.

* ``network.host: 172.30.4.105``
	* By default, Elasticsearch binds to loopback addresses only (e.g. 127.0.0.1). This is sufficient to run a single development node on a server. 
	* In order to communicate and to form a cluster with nodes on other servers, your node will need to bind to a non-loopback address.

* ``http.port: 9200``
	* Port Elasticsearch will listen on. We recommend using the default value.

*  ``discovery.zen.ping.unicast.hosts: ["es01.acme.org", "es02.acme.org"]``
	* Elasticsearch uses a custom discovery implementation called "Zen Discovery" for node-to-node clustering and master election. To form a cluster with nodes on other servers, you have to provide a seed list of other nodes in the cluster that are likely to be live and contactable. 
	* May be specified as IP address or FQDN.




