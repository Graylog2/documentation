*******************
Amazon Web Services
*******************

AMIs
----

Select your AMI and AZ `here <https://github.com/Graylog2/graylog2-images/tree/master/aws>`_.

Usage
-----

  * Click on *Launch instance* for your AWS region to start Graylog into.
  * Choose an instance type **with at least 4GB memory**
  * Finish the wizard and spin up the VM.
  * Login to the instance as user `ubuntu`
  * Run `sudo graylog-ctl reconfigure`
  * Open port 80 and ports for receiving log messages in the security group of the appliance

Open `http://<vm ip>` in your browser to access the Graylog web interface. Default username and password is `admin`.

Basic configuration
-------------------

We are shipping the ``graylog-ctl`` tool with the virtual machine appliances to get you started
with a customised setup as quickly as possible. Run these (optional) commands to configure the
most basic settings of Graylog in the appliance::

  sudo graylog-ctl set-email-config <smtp server> [--port=<smtp port> --user=<username> --password=<password>]
  sudo graylog-ctl set-admin-password <password>
  sudo graylog-ctl set-timezone <zone acronym>
  sudo graylog-ctl reconfigure

The ``graylog-ctl`` has much more functionality and is documented :ref:`here <graylog-ctl>`.
We strongly recommend to learn more about it to ensure smooth operation of your virtual appliance.
