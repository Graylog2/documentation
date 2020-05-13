.. _AMI:

*******************
Amazon Web Services
*******************

AMIs
----

Select your `AMI and AWS Region <https://github.com/Graylog2/graylog2-images/tree/3.2/aws>`_.

Usage
-----

  * Click on *Launch instance* for your AWS region to start Graylog into.
  * Choose an instance type **with at least 4GB memory**.
  * Finish the wizard and spin up the VM.
  * Open port 80 and 22 in the applied security group to access the web interface.
  * Login to the instance via SSH as user `ubuntu` to see web login credentials.
  * additionally open more ports for ingesting log data, like 514 for syslog or 12201 for the GELF protocol.

Open `http://<private ip>` in your browser to access the Graylog web interface. Default username is `admin`
with the password shown on the first SSH login.

Networking
----------

Your browser needs access to port 80 for reaching the web interface. Make sure that a security group is opening that
port. On the appliance a NGINX instance is used as proxy to simplify network access. Take a look
in the configuration `/etc/nginx/sites-available/default` for further fine tuning.

HTTPS
-----

In order to enable HTTPS for the web interface port 443 needs also be open. The configuration can be done with NGINX
as well. See :ref:`ssl_setup` for a full reference.

Basic configuration
-------------------

The Graylog appliance is based on Ubuntu system packages so all configuration changes can be done analog to the rest of
this documentation. See :ref:`graylog_configuration`

Production readiness
--------------------

The Graylog appliance is not created to provide a production ready solution. It is build to offer a fast and easy way to try the software itself and not wasting time to install Graylog and it components to any kind of server.
