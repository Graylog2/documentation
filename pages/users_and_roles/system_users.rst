************
System users
************

The Graylog permission system is extremely flexible and allows you to create users that are only allowed to perform
certain REST calls. The :ref:`roles`  UI allows you to create roles based on stream or dashboard access but does not
expose permissions on a REST call level yet. This guide describes how to create those roles using the Graylog REST API.

Let's imagine we want to create a role that is only allowed to start or stop message processing on ``graylog-server`` nodes.


REST call permissions
=====================

Almost every REST call in Graylog has to be authenticated or it will return a HTTP 403 (Forbidden). In addition to that
the requesting user also has to have the permissions to execute the REST call. A Graylog admin user can always execute
all calls and roles based on the standard stream or dashboard permissions can execute calls related to those entities.

If you want to create a user that can only execute calls to start or stop message processing you have to find the name
of the required permission first. Until we include this functionality in the Graylog UI you'll have to look directly
into the code. The permissions are listed in the `RestPermissions class <https://github.com/Graylog2/graylog2-server/blob/2.1.0/graylog2-server/src/main/java/org/graylog2/shared/security/RestPermissions.java>`__ (make sure to select a branch that reflects your current version of Graylog).

The permission you are searching for in this case is::

  public static final String PROCESSING_CHANGESTATE = "processing:changestate";


Creating the role
=================

You can create a new role using the REST API like this::

  curl -v -XPOST -u ADMIN:PASSWORD -H 'Content-Type: application/json' 'http://graylog.example.org:9000/api/roles' -d '{"read_only": false,"permissions": ["processing:changestate"],"name": "Change processing state","description": "Permission to start or stop processing on Graylog nodes"}'

Notice the ``processing:changestate`` permission that we assigned. Every user with this role will be able to
execute only calls that start or stop processing on ``graylog-server`` nodes. (and also the standard ``reader`` permissions
that do not provide any access to data or maintenance functionalities though.)

This is the POST body in an easier to read formatting::

  {
    "name": "Change processing state",
    "description": "Permission to start or stop processing on graylog-server nodes",
    "permissions": [
      "processing:changestate"
    ],
    "read_only": false
  }


Assigning the role to a user
============================

Create a new user in the Graylog web interface and assign the new role to it:

.. image:: /images/sysuser.png

Every user needs to at least have the standard "Reader" permissions but those do not provide any access to data
or maintenance functionalities.

Now request the user information to see what permissions have been assigned::

  $ curl -XGET -u ADMIN:PASSWORD 'http://graylog.example.org:9000/api/users/maintenanceuser?pretty=true'
  {
    "id" : "563d1024d4c63709999c4ac2",
    "username" : "maintenanceuser",
    "email" : "it-ops@example.org",
    "full_name" : "Rock Solid",
    "permissions" : [
      "indexercluster:read",
      "messagecount:read",
      "journal:read",
      "inputs:read",
      "metrics:read",
      "processing:changestate",
      "savedsearches:edit",
      "fieldnames:read",
      "buffers:read",
      "system:read",
      "users:edit:maintenanceuser",
      "users:passwordchange:maintenanceuser",
      "savedsearches:create",
      "jvmstats:read",
      "throughput:read",
      "savedsearches:read",
      "messages:read"
    ],
    "preferences" : {
      "updateUnfocussed" : false,
      "enableSmartSearch" : true
    },
    "timezone" : "America/Chicago",
    "session_timeout_ms" : 300000,
    "read_only" : false,
    "external" : false,
    "startpage" : { },
    "roles" : [
      "Change processing state",
      "Reader"
    ]
  }

Now you can use this user in your maintenance scripts or automated tasks.
