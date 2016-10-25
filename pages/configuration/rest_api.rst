.. _configuring_api:

****************
Graylog REST API
****************

The functionality Graylog REST API is very comprehensive; even the Graylog web interface is exclusively using Graylog REST API to interact with the Graylog cluster.

To connect to the Graylog REST API with a web browser, just add ``api-browser`` to your current ``rest_listen_uri`` setting or use the **API browser** button on the nodes overview page (*System / Nodes* in the web interface).

For example if your Graylog REST API is listening on ``http://192.168.178.26:9000/api/``, the API browser will be available at ``http://192.168.178.26:9000/api/api-browser/``.

.. image:: /images/api/system_nodes_overview.png

.. note:: The customized version of Swagger UI used by Graylog does currently only work in Google Chrome and Firefox.


Using the API Browser
=====================

After providing the credentials (username and password), you can browse all available HTTP resources of the Graylog REST API.

.. image:: /images/api/use_api_browser.png


Interacting with the Graylog REST API
=====================================

While having a graphical UI for the Graylog REST API is perfect for interactive usage and exploratory learning, the real power unfolds when using the Graylog REST API for automation or integrating Graylog into another system, such as monitoring or ticket systems.

Naturally, the same operations the API browser offers can be used on the command line or in scripts. A very common HTTP client being used for this kind of interaction is `curl <https://curl.haxx.se/>`__.

.. note:: In the following examples, the username ``GM`` and password ``superpower`` will be used to demonstrate how to work with the Graylog REST API running at ``http://192.168.178.26:9000/api``.


The following command displays Graylog cluster information as JSON, exactly the same information the web interface is displaying on the *System / Nodes* page::

    curl -u GM:superpower -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/cluster?pretty=true'

The Graylog REST API will respond with the following information::

    {
      "71ab6aaa-cb39-46be-9dac-4ba99fed3d66" : {
        "facility" : "graylog-server",
        "codename" : "Smuttynose",
        "node_id" : "71ab6aaa-cb39-46be-9dac-4ba99fed3d66",
        "cluster_id" : "3adaf799-1551-4239-84e5-6ed939b56f62",
        "version" : "2.1.1+01d50e5",
        "started_at" : "2016-09-23T10:39:00.179Z",
        "hostname" : "gm-01-c.fritz.box",
        "lifecycle" : "running",
        "lb_status" : "alive",
        "timezone" : "Europe/Berlin",
        "operating_system" : "Linux 3.10.0-327.28.3.el7.x86_64",
        "is_processing" : true
      },
      "ed0ad32d-8776-4d25-be2f-a8956ecebdcf" : {
        "facility" : "graylog-server",
        "codename" : "Smuttynose",
        "node_id" : "ed0ad32d-8776-4d25-be2f-a8956ecebdcf",
        "cluster_id" : "3adaf799-1551-4239-84e5-6ed939b56f62",
        "version" : "2.1.1+01d50e5",
        "started_at" : "2016-09-23T10:40:07.325Z",
        "hostname" : "gm-01-d.fritz.box",
        "lifecycle" : "running",
        "lb_status" : "alive",
        "timezone" : "Europe/Berlin",
        "operating_system" : "Linux 3.16.0-4-amd64",
        "is_processing" : true
      },
      "58c57924-808a-4fa7-be09-63ca551628cd" : {
        "facility" : "graylog-server",
        "codename" : "Smuttynose",
        "node_id" : "58c57924-808a-4fa7-be09-63ca551628cd",
        "cluster_id" : "3adaf799-1551-4239-84e5-6ed939b56f62",
        "version" : "2.1.1+01d50e5",
        "started_at" : "2016-09-30T13:31:39.051Z",
        "hostname" : "gm-01-u.fritz.box",
        "lifecycle" : "running",
        "lb_status" : "alive",
        "timezone" : "Europe/Berlin",
        "operating_system" : "Linux 4.4.0-36-generic",
        "is_processing" : true
      }


Creating and using Access Token
-------------------------------

For security reasons, using the username and password directly on the command line or in some third party application is undesirable.

To prevent having to use the clear text credentials, Graylog allows to create access tokens which can be used for authentication instead.

In order to create a new access token, you need to send a ``POST`` request to the Graylog REST API which includes the username and the name of the new access token.

The following example will create an access token named ``icinga`` for the user ``GM``::

    curl -u GM:superpower -H 'Accept: application/json' -X POST 'http://192.168.178.26:9000/api/users/GM/tokens/icinga?pretty=true'

The response will include the access token in the ``token`` field::

    {
       "name" : "icinga",
       "token" : "htgi84ut7jpivsrcldd6l4lmcigvfauldm99ofcb4hsfcvdgsru",
       "last_access" : "1970-01-01T00:00:00.000Z"
    }

The received access token can now be used as username in a request to the Graylog REST API using Basic Auth together with the literal password ``token``.

Now the first ``curl`` example would look as follows::

    curl -u htgi84ut7jpivsrcldd6l4lmcigvfauldm99ofcb4hsfcvdgsru:token -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/cluster?pretty=true'

If you need to know which access tokens have already been created by a user, just use ``GET /users/{username}/tokens/`` on the Graylog REST API to request a list of all access tokens that are present for this user.

The following example will request all access tokens of the user ``GM``::

    curl -u GM:superpower -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/users/GM/tokens/?pretty=true'

When an access token is no longer needed, it can be delete on the Graylog REST API via ``DELETE /users/{username}/tokens/{token}``.

The following example deletes the previously created access token ``htgi84ut7jpivsrcldd6l4lmcigvfauldm99ofcb4hsfcvdgsru`` of the user ``GM``::

    curl -u GM:superpower -H 'Accept: application/json' -X DELETE' http://192.168.178.26:9000/api/users/GM/tokens/ap84p4jehbf2jddva8rdmjr3k7m3kdnuqbai5s0h5a48e7069po?pretty=true'


Creating and using Session Token
--------------------------------

While access tokens can be used for permanent access, session tokens will expire after a certain time. The expiration time can be adjusted in the user's profile. 

Getting a new session token can be obtained  via ``POST`` request to the Graylog REST API. Username and password are required to get a valid session ID. The following example will create an session token for the user ``GM``::

    curl -i -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' 'http://192.168.178.26:9000/api/system/sessions' -d '{"username":"GM", "password":"superpower", "host":""}'

The response will include the session token in the field ``session_id`` and the time of experation::

    {
        "valid_until" : "2016-10-24T16:08:57.854+0000",
        "session_id" : "cf1df45c-53ea-446c-8ed7-e1df64861de7"
    }

The received token can now be used as username in a request to the Graylog REST API using Basic Auth together with the literal password ``session``.

Now a ``curl`` command to get a list of access tokens would look as follows::

    curl -u cf1df45c-53ea-446c-8ed7-e1df64861de7:session -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/cluster?pretty=true'

