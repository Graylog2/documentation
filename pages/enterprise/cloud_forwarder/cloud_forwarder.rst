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

#. Install the Graylog repository configuration.

    .. code-block:: bash

        $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.rpm

#.  Install the graylog-forwarder package:

    .. code-block:: bash

        $ sudo yum install graylog-forwarder

#. Create the certificate and update the config file:

    .. code-block:: bash
    
        $ sudo vi /etc/graylog/forwarder/forwarder.conf

#. Start the service:

    .. code-block:: bash

        $ sudo systemctl start graylog-forwarder.service

Docker Installation
===================

Additionally, your Forwarder is available as a Docker image. Regardless of your installation method, you’re required
to create a digital certificate to ensure better security. The forwarder is also available as a docker image. 
To download the image, run the following command: ``docker pull graylog/graylog-forwarder:<release-version>``.

To run the container, you will need to pass it the following environment variables:

    .. code-block:: bash

        $ GRAYLOG_FORWARDER_SERVER_HOSTNAME
        $ GRAYLOG_FORWARDER_GRPC_API_TOKEN

You'll also need to mount the certificate file as a volume. Here is an example command:

    .. code-block:: bash

        $ docker run -e GRAYLOG_FORWARDER_SERVER_HOSTNAME=ingest.<SERVER NAME> -e GRAYLOG_FORWARDER_GRPC_API_TOKEN=<INSERT_API_TOKEN_HERE> -v /path/to/cert/cert.pem:/etc/graylog/forwarder/cert.pem graylog/graylog-forwarder:<release-version>

****************************************
Monitoring Forwarder Activity and Health
****************************************

After you connect your Forwarder to Graylog Cloud, get to know methods to access metrics and other information 
on your Forwarder(s) and corresponding input(s). Here are a few methods to analyze and extract details on Forwarder 
activity:

* review active Forwarder(s) in the UI
* call REST endpoints to consume information on health and list of inputs
* export Forwarder metrics from Prometheus, a third-party monitoring tool
        
Forwarder Overview
==================
        
One place to review Cloud Forwarder connectivity is the *Forwarders* screen, under the *Systems* menu. 
This page provides a summary of all Forwarders. Identify the green Connected badge on the Status column. 
This tells you that a Forwarder is actively sending messages to your cloud instance. Another key indicator 
is found on the Metrics column. The cells that show active message rates, again, prove your Cloud Forwarders works. 

REST API
========

The Forwarder supports a local REST API for checking health status, inputs, and exporting Prometheus metrics. 
To enable the Forwarder API:

* Open your ``forwarder.conf`` file
* Add the ``forwarder_api_enabled = true`` configuration option. 

When enabled, the API will listen on a Unix Domain Socket using the file indicated with ``forwarder_api_socket_path``
unless you provide a value for ``forwarder_api_tcp_bind_address``. For example, you can run a curl command to access
the endpoint. If you need a refresher on how to use Unix sockets, `review this guide <https://superuser.com/a/925610>`__.
        
Health Status Endpoint
----------------------

To check the health of your Forwarder, query the endpoint ``GET /api/health``:

    .. code-block:: json

        {
            "healthy": true,
            "inputs": {
                "healthy": true,
                "running": 2,
                "failed": 0,
                "not running": 0
                },
            "upstream": {
            "healthy": true
            }
        }

Input Endpoint
--------------

To obtain a list of Inputs running on the Forwarder, query the GET /api/inputs endpoint.

    .. code-block:: json

    {
    "inputs": [
        {
        "id": "5fc91564d44bfd2000249e8c",
        "title": "Random"
        },
        {
        "id": "5fc91550d44bfd2000249e74",
        "title": "Beats"
        }
    ]
}   

Drill down to the input profile and view the Forwarder sub-menu to ensure it receives messages. If data still doesn’t 
come through, create a new input. Click the name of your input which takes you to its main profile with the details 
you added at initial configuration.
        
        
If an input is in a failed state, the input endpoint returns no information on ``id`` nor ``title``. 
        
Additionally, you can get deeper insights into Forwarder messaging and node health. Click the Details button on your 
node, to get information about your message cache (buffers). One metric to pay attention to is the number of messages 
in the journal. The journal is the on-disk persistent storage location that stores Forwarder messages. So, if the rest 
of Graylog malfunctions, we can still keep all the messages we still have a place to put them.
        
Prometheus Metrics Exports
--------------------------

The Forwarder, alone, has no interface for insight into the internal operations. To that end, you must configure a 
local Prometheus container; this becomes the interface for Forwarder metrics. These are similar to the traditional 
Graylog Server metrics but instead are exported to Prometheus. The response format is the standard Prometheus HTTP 
export format.
        
To start this process:

#. Download and start `Prometheus <https://prometheus.io/docs/prometheus/latest/getting_started/#downloading-and-running-prometheus>`__.
#. Install `Docker <https://docs.docker.com/get-docker/>`__ on your machine.
#. Create a Prometheus Dockerfile, e.g. ``touch /tmp/prometheus.yml``:
    
    .. code-block:: yaml
        
        $ global:
          scrape_interval: 15s
          scrape_timeout: 10s
          evaluation_interval: 15s
        alerting:
          alertmanagers:
          - static_configs:
            - targets: []
            scheme: http
            timeout: 10s
            api_version: v1
        scrape_configs:
        - job_name: prometheus
          honor_timestamps: true
          scrape_interval: 15s
          scrape_timeout: 10s
          metrics_path: /api/metrics/prometheus
          scheme: http
          static_configs:
          - targets:
            - host.docker.internal:9001
        Run this Docker command to start the container:
            docker run \
              -p 9090:9090 \
              -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml \
              prom/prometheus
        

Resiliency Models
        When you think about scaling your deployment -- that is, add more Forwarders -- you must incorporate tools, procedures, and policies that let you continue operating in the case of a major outage – widespread, long-lasting, destructive, or all three. If all the above pose a threat to your Forwarder consider both message recovery and load balancing. 
        Message Recovery
        The Cloud Forwarder’s disk journal is capable of caching data in case of a network outage. From there, they are read and sent to Graylog Cloud. 
        
        As mentioned in the Output Framework chapter, if the internet is unavailable, the Forwarder is still capable of receiving messages. So, once the internet is back the workflow will resume. Messages from the journal are sent to Graylog Cloud.
        Load Balancing Options
        A larger deployment means more throughput i.e., requests passing through your systems. So, in a more mature, multi-Forwarder scenario we recommend you configure a load balancer to evenly distribute data transfer. This helps your deployment manage bulk requests and potential latency issues while ensuring resiliency.
        
        More to the point, the load balancer distributes requests among healthy nodes in your local and/or external data centers. In our help docs, you can test and configure tools such as Apache HTTP server, Nginx, or HAProxy to handle requests among multiple Cloud Forwarders.
