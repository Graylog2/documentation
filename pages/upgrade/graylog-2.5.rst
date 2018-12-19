**************************
Upgrading to Graylog 2.5.x
**************************

.. _upgrade-from-24-to-25:

Protecting against CSRF, HTTP header required
=============================================

Using the Graylog server API requires all clients sending non-GET requests to include a custom HTTP header
(``X-Requested-By``). The value of the header is not important, but it's presence is, as all requests without it will
be ignored and will return a 400 error.

**This is important for people using scripts that modify Graylog in any way through the REST API**. We already adapted
Graylog web interface and our plugins, so if you don't use any scripts or 3rd party products to access Graylog, you
don't have to do anything else.

If you are using the Graylog Sidecar, you either have to use Graylog version 2.5.1 or update the Sidecar to `version 0.1.7 <https://github.com/Graylog2/collector-sidecar/releases/tag/0.1.7>`_. That version is using the correct CSRF headers for HTTP requests against the Graylog server API.
