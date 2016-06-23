.. _loadbalancer_integration:

*************************
Load balancer integration
*************************

When running multiple Graylog servers a common deployment scenario is to route the message traffic through an
IP load balancer. By doing this we can achieve both a highly available setup, as well as increasing message
processing throughput, by simply adding more servers that operate in parallel.

Load balancer state
===================

However, load balancers usually need some way of determining whether a backend service is reachable and healthy
or not. For this purpose Graylog exposes a load balancer state that is reachable via its REST API.

There are two ways the load balancer state can change:

* due to a lifecycle change (e.g. the server is starting to accept messages, or shutting down)
* due to manual intervention via the REST API

To query the current load balancer status of a Graylog instance, all you need to do is to issue a HTTP call to its REST API::

  GET /system/lbstatus

The status knows two different states, ``ALIVE`` and ``DEAD``, which is also the ``text/plain`` response of the
resource. Additionally, the same information is reflected in the HTTP status codes: If the state is ``ALIVE``
the return code will be ``200 OK``, for ``DEAD`` it will be ``503 Service unavailable``. This is done to make
it easier to configure a wide range of load balancer types and vendors to be able to react to the status.

The resource is accessible without authentication to make it easier for load balancers to access it.

To programmatically change the load balancer status, an additional endpoint is exposed::

  PUT /system/lbstatus/override/alive
  PUT /system/lbstatus/override/dead

Only authenticated and authorized users are able to change the status, in the currently released Graylog version
this means only admin users can change it.

Graceful shutdown
=================

Often, when running a service behind a load balancer, the goal is to be able to perform zero-downtime upgrades, by
taking one of the servers offline, upgrading it, and then bringing it back online. During that time the remaining
servers can take the load seamlessly.

By using the load balancer status API described above one can already perform such a task. However, it would still be
guesswork when the Graylog server is done processing all the messages it already accepted.

For this purpose Graylog supports a graceful shutdown command, also accessible via the web interface and API. It will
set the load balancer status to ``DEAD``, stop all inputs, turn on messages processing (should it have been disabled
manually previously), and flush all messages in memory to Elasticsearch. After all buffers and caches are processed,
it will shut itself down safely.

.. image:: /images/nodes_more_action.png

Web Interface
=============

It is possible to use the Graylog web interface behind a load balancer for high availability purposes.

.. note:: Take care of the configuration you need :ref:`with a proxy setup <configuring_webif_nginx>`, it will *not* work out of the box.

In the current Version 2.0 you did not need the sticky Session that was needed in previous Version. Only the API URL ``/system/deflector/cycle`` need to point to the configured Graylog Master Node. In future Version that might change.

Please refer to your vendor's documentation to learn how to route this URL to a specific host.

