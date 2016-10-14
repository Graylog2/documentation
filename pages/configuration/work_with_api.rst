.. _configuring_api:

***
API
***


The Graylog API is very powerful; even the Graylog Web interface use the API to interact with the Graylog Server.

To connect to the API with a Browser just add `api-browser` to your `rest_listen_uri` or use the button you can find in your nodes overview page.

.. image:: /images/api/system_nodes_overview.png

.. note:: The customized swagger GUI will work in chrome and firefox only.

Use the API Browser
====================

After providing Username and Password, you can browse all available Operations.

.. image:: /images/api/use_api_browser.png


Interact with the API
=====================

While having a GUI available is perfect for human interaction and learning, the real power comes up when you can use the API in your automation or use it to integrate Graylog into your Monitoring System.

The same Information, you got from the GUI can be requested on the command line. A very common tool for this is `curl <https://curl.haxx.se/>`__.

.. note:: In the following commands the Username *GM* and the password *superpower* is used to demonstrate the work with the API on the Server *192.168.178.26*


This command gives you back the Information from the GUI only in a JSON String::

    curl -u GM:superpower -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/cluster?pretty=true'

You will get the following response::

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

Create and use Token
--------------------

Providing your Username and Password on the command line or in some tool is not what you would like to-do. This is why you can create a token that can be used for authentication instead.

You need to POST a command that includes the username and the name of the new created token to the API. In short ``POST /users/{username}/tokens/{name}``  and following now as example::

    curl -u GM:superpower -H 'Accept: application/json' -X POST 'http://192.168.178.26:9000/api/users/GM/tokens/icinga?pretty=true'

The response will include your Token ID::

    {
       "name" : "icinga",
       "token" : "htgi84ut7jpivsrcldd6l4lmcigvfauldm99ofcb4hsfcvdgsru",
       "last_access" : "1970-01-01T00:00:00.000Z"
    }

To use this Token now you need to put the token as username in a curl command and use the password ``token``. Now the first curl example will become::

    curl -u htgi84ut7jpivsrcldd6l4lmcigvfauldm99ofcb4hsfcvdgsru:token -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/cluster?pretty=true'

If you need to know what tokens already are create for a user, just use ``GET /users/{username}/tokens/`` on the API. Following one example::

    curl -uGM:superpower -H 'Accept: application/json' -X GET 'http://192.168.178.26:9000/api/users/GM/tokens/?pretty=true'

When a Token is not longer needed you can use ``DELETE /users/{username}/tokens/{token}`` on the API to remove the Token::

    curl -u GM:superpower -H 'Accept: application/json' -X DELETE' http://192.168.178.26:9000/api/users/GM/tokens/ap84p4jehbf2jddva8rdmjr3k7m3kdnuqbai5s0h5a48e7069po?pretty=true'


