*******************
Amazon Web Services
*******************

AMIs
----

Select your `AMI and AWS Region <https://github.com/Graylog2/graylog2-images/tree/2.3/aws>`_.

Usage
-----

  * Click on *Launch instance* for your AWS region to start Graylog into.
  * Choose an instance type **with at least 4GB memory**.
  * Finish the wizard and spin up the VM.
  * Login to the instance via SSH as user `ubuntu`.
  * Run `sudo graylog-ctl reconfigure`.
  * Open port 80 and 9000 in the applied security group to access the web interface.
  * additionally open more ports for ingesting log data, like 514 for syslog or 12201 for the GELF protocol.

Open `http://<private ip>` in your browser to access the Graylog web interface. Default username and password is `admin`.

Networking
----------

Your browser needs access to port 80 or 443 for reaching the web interface. The interface itself creates a connection
back to the REST API of the Graylog server on port 9000. As long as you are in a private network like Amazon VPC for
instance, this works out of the box.
If you want to use the *public* IP address of your VM, this mechanism doesn't work automatically anymore. You have
to tell Graylog how to reach the API from the users browser perspective::

  sudo graylog-ctl set-external-ip http://<public ip>:9000/api/
  sudo graylog-ctl reconfigure

Also make sure that this port is open, even on the public IP.

HTTPS
-----

In order to enable HTTPS for the web interface both ports need to be encrypted. Otherwise the web browser would show
an error message. For this reason we created a proxy configuration on the appliance that can be enabled by running::

  sudo graylog-ctl enforce-ssl
  sudo graylog-ctl reconfigure

This command combines the Graylog web interface and the API on port 443. The API is accessable via the path `/api`.
For this reason you have to set the external IP to an HTTPS address with the appended path `/api`::

  sudo graylog-ctl set-external-ip https://<public ip>:443/api
  sudo graylog-ctl reconfigure

Basic configuration
-------------------

We are shipping the ``graylog-ctl`` tool with the virtual machine appliances to get you started
with a customised setup as quickly as possible. Run these (optional) commands to configure the
most basic settings of Graylog in the appliance::

  sudo graylog-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  sudo graylog-ctl set-admin-password <password>
  sudo graylog-ctl set-timezone <zone acronym>
  sudo graylog-ctl reconfigure

The ``graylog-ctl`` has much more :ref:`functionality documented <graylog-ctl>`.
We strongly recommend to learn more about it to ensure smooth operation of your virtual appliance.

Production readiness
====================

The Graylog appliance is not created to provide a production ready solution. It is build to offer a fast and easy way to try the software itself and not wasting time to install Graylog and it components to any kind of server. 

If you want to create your own production ready setup take a look at our :ref:`other installation methods <installing>`.