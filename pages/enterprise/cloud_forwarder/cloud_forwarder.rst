###############
Cloud Forwarder
###############

************
Introduction
************
The Graylog Cloud Forwarder is the solution to get your data into Graylog Cloud. Graylog Cloud allows you to set up
a connection so one or more Forwarders can send messages. Since it’s hosted in the cloud you can run the Forwarder 
anywhere. In addition, your data has improved uptime and reliability.

The Cloud Forwarder is not a one-and-done migration tool. In fact, it’s an integral part of your cloud architecture. 
Your Forwarder must run 24-7 in your environment in order to get data in the cloud.

********
Security
********

The Forwarder connects to Graylog Cloud over TLS. This ensures data moves securely and reliably. 

Another layer of security required for the Forwarder is an API token. To ensure only Forwarders you trust can connect
to your Graylog Cloud instance, Forwarders must be assigned and configured with a token to authenticate with Graylog 
Cloud. Any tokens used by the Forwarder must belong to the user Forwarder System User (built-in). You can find 
information about creating an `API token in the documentation <https://docs.graylog.org/en/4.0/pages/configuration/rest_api.html?highlight=token#creating-and-using-access-token>`__.

*************
Input Profile
*************

Input Profiles are a set of Inputs that can be configured to run on one or more Forwarders of your choice. 
This aspect is critical to your Forwarder because it provides a gateway to move data to Graylog Cloud.

Input Profiles helps you to avoid re-doing the same configuration for all Forwarders since you can start new Forwarders 
and assign them a set of Inputs you already defined and tested beforehand. This is especially helpful if you want to collect the same kind of logs in different parts of your Infrastructure or to have a more redundant set-up.

As you create your Cloud Forwarder, you must create an Input Profile from the wizard, explained in Add Inputs. 
Provide a descriptive name for the Input Profile, a short description of its intention, and then create all the input 
necessary for the Forwarder.

*************
Configuration
*************

File
====

On the client-side of your Forwarder, modify the configuration file to address your Graylog host and authentication. 
The default values for ``forwarder.conf`` are:
* ``forwarder_server_hostname``: (required) The Graylog Cloud Forwarder ingest hostname (eg. ``ingest-<your-account>.graylog.cloud``).
It’s found on the Forwarder Setup Wizard in Graylog Cloud.
* ``forwarder_grpc_api_token``: (required) The API Token for authenticating the Forwarder.

Here’s an example of the configuration file, with the following values:

.. code-block:: bash

    $ forwarder_server_hostname = ingest-<your-account-url>.graylog.cloud
    $ forwarder_grpc_api_token = <your-api-token>

Wizard
======

When you login to the Cloud instance, you’ll walk through a guided process to configure your Forwarder.

Complete the wizard by following the sections below:

#. Go to the Graylog user interface to select *Forwarders*, found in the *System* menu.
#. Click the *New Forwarder* button.
#. Press the *Start configuration* button to navigate to the *Select Forwarder* accordion.

Install Forwarder
-----------------

#. Download the Forwarder.
#. Press *Continue* to navigate to the next step in the accordion.

Create API Token
----------------

We recommend using a single API token for each Forwarder, ensuring that you can revoke tokens for 
individual Forwarders no longer used.

#. Enter your *Token Name* in the available field.
#. Create the new name by clicking the **Create Token* button.

Configure Forwarder (Accordion/Wizard Menu)
-------------------------------------------

#. Open your text editor of choice to access your ``forwarder.conf`` file
#. Click *Copy as configuration snippet* to copy the configuration details displayed to your ``forwarder.conf``
file, i.e. ``forwarder_server_hostname`` and ``forwarder_grpc_api_token`` with corresponding values.
#. Paste all values in the configuration file, and save the new changes.

Start the Forwarder
-------------------

Before you begin the last step in the accordion:

#. Open your terminal
#. Locate the startup script found in your application directory. 
#. Run the startup script with the command ``./bin/graylog-forwarder run --configfile forwarder.conf``. 
#. Return to the wizard after the Forwarder successfully runs.

Select Forwarder
----------------

Once the Forwarder makes a connection to Graylog Cloud, see it listed among your routers. 

#. Click the radio button to select the new Forwarder you just created. 
#. Click *Configure selected Forwarder* to navigate to the next menu: *Configure Forwarder*.

Configure Forwarder (Wizard Menu)
---------------------------------

In this section, you have the option to customize the identity of your Forwarder.

#. Add a title. 
#. Enter a long-form description, in case you want to distinguish it from other Forwarders (if they exist).
#. Click *Add Forwarder* inputs to complete this section.

Add Inputs
----------

In this section, select an Input Profile. When you design this type of profile, it contains a collection 
of inputs that multiple Forwarders can use. In this case, create one:
#. Click *Create Input Profile*.
#. Add a name in the *Title* field.
#. Enter a description that corresponds to the *Title*.
#. Click *Add Inputs* to complete the form.
#. Select an *Input Type* from the dropdown menu.
#. Fill in the details for your input in the form.
#. Click *Create Input*, then save the configuration.

Summary
-------

Review your summary, then select *Exit configuration*. You’ll see the new Forwarder on the *Forwarder* page.

After installing, configuring, and starting a Forwarder instance, it will register with Graylog Cloud 
and appear on the Forwarders page in Graylog Cloud. Each Forwarder will have a *Configure* button to begin 
the configuration process for it. In case the Forwarder is not displayed yet, clicking on New Forwarder 
will give you information on how to configure and start it.

**************************************
Operating System Package Configuration
**************************************

If you don't install the Forwarder with the binary, you can install it with Linux packages. You can choose 
from DEB and RPM. If either of those tools is your method, be sure Java is available on your operating system.
In addition, be sure to have access to a TLS certificate and an API token generated from Graylog.

Install via DEB
===============

#. Download the DEB package:

    .. code-block:: bash

        $ sudo apt-get install apt-transport-https
        $ wget https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.deb
        $ sudo dpkg -i graylog-4.0-repository_latest.deb
        $ sudo apt-get update
        
#. Install the package:
    
    .. code-block:: bash
        $ sudo apt-get install graylog-forwarder

#. Create the certificate and update the config file:
    
    .. code-block:: bash
        $ sudo vi /etc/graylog/forwarder/forwarder.conf
        
#. Start the service:
    
    .. code-block:: bash
        $ sudo systemctl start graylog-forwarder.service

RPM Install Instructions
========================
Install the Graylog repository configuration.
sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.rpm
Install the graylog-forwarder package:
sudo yum install graylog-forwarder
Create the certificate and update the config file:
sudo vi /etc/graylog/forwarder/forwarder.conf
Start the service:
sudo systemctl start graylog-forwarder.service
Docker Installation
Additionally, your Forwarder is available as a Docker image. Regardless of your installation method, you’re required to create a digital certificate to ensure better security. The forwarder is also available as a docker image. To download the image, run the following command: docker pull graylog/graylog-forwarder:<release-version>

To run the container, you will need to pass it the following environment variables:
GRAYLOG_FORWARDER_SERVER_HOSTNAME
GRAYLOG_FORWARDER_GRPC_API_TOKEN

You'll also need to mount the certificate file as a volume. Here is an example command:
docker run -e GRAYLOG_FORWARDER_SERVER_HOSTNAME=ingest.<SERVER NAME> -e
GRAYLOG_FORWARDER_GRPC_API_TOKEN=<INSERT_API_TOKEN_HERE> -v /path/to/cert/cert.pem:/etc/graylog/forwarder/cert.pem graylog/graylog-forwarder:<release-version>
