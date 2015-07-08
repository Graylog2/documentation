*******************
Amazon Web Services
*******************

======= ============== ============  ===========================================================================================================================
Version Region         AMI           Launch Wizard
======= ============== ============  ===========================================================================================================================
1.1.4   us-east-1      ami-d962a4b2  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-d962a4b2>`_
1.1.4   us-west-1      ami-6b26d72f  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:ami=ami-6b26d72f>`_
1.1.4   us-west-2      ami-196d6b29  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-196d6b29>`_
1.1.4   eu-west-1      ami-886726ff  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=eu-west-1#LaunchInstanceWizard:ami=ami-886726ff>`_
1.1.4   eu-central-1   ami-10f3c80d  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=eu-central-1#LaunchInstanceWizard:ami=ami-10f3c80d>`_
1.1.4   ap-southeast-2 ami-e1d095db  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=ap-southeast-2#LaunchInstanceWizard:ami=ami-e1d095db>`_
1.1.3   us-east-1      ami-9bff03f0  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-9bff03f0>`_
1.1.3   us-west-1      ami-7f4db93b  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=us-west-1#LaunchInstanceWizard:ami=ami-7f4db93b>`_
1.1.3   us-west-2      ami-f10a0fc1  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#LaunchInstanceWizard:ami=ami-f10a0fc1>`_
1.1.3   eu-west-1      ami-67bac010  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=eu-west-1#LaunchInstanceWizard:ami=ami-67bac010>`_
1.1.3   eu-central-1   ami-f2d7efef  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=eu-central-1#LaunchInstanceWizard:ami=ami-f2d7efef>`_
1.1.3   ap-southeast-2 ami-1b433921  `Launch instance <https://console.aws.amazon.com/ec2/v2/home?region=ap-southeast-2#LaunchInstanceWizard:ami=ami-1b433921>`_
======= ============== ============  ===========================================================================================================================

Usage
-----

  * Click on *Launch instance* for your AWS region to start Graylog into.
  * Choose an instance type with at least 4GB memory
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
