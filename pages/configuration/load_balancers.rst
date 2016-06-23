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

Web Interface
=============

It is possible to use the Graylog web interface behind a load balancer for high availability purposes.

However, in order to make the various metrics work in Graylog's web interface, you need to enable sticky sessions in your
load balancer, or configure the second instance to be a failover instance only, which only gets requests in case the
first instance is no longer reachable.

There are various terms used for sticky sessions. Session persistence or session management are also in use.

Please refer to your vendor's documentation to learn about how to enable sticky sessions.

Information for some popular load balancers and their settings can be found through the following links:

* `Amazon Web Services ELB <http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-sticky-sessions.html>`_
* `HAProxy <http://blog.haproxy.com/2012/03/29/load-balancing-affinity-persistence-sticky-sessions-what-you-need-to-know/>`_
* `F5 BIG-IP <https://support.f5.com/kb/en-us/products/lc_9_x/manuals/product/lc_config_10_2/lc_persist_profiles.html>`_
* `KEMP <https://support.kemptechnologies.com/hc/en-us/articles/202040855-What-is-persistence->`_

