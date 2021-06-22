#########
Forwarder
#########

.. toctree::
   :hidden:

   forwarder/installation
   forwarder/configuration_options

************
Introduction
************
The Graylog Forwarder is a standalone agent for sending send log data to Graylog Cloud or an on-premise Graylog
Server cluster. The Forwarder is typically run as a service to continuously stream data to the destination Graylog
cluster.

.. image:: /images/forwarder_diagram.png

********
Security
********

The Forwarder connects to Graylog Cloud over TLS. Using TLS is also highly recommended for on-premise installations.
This ensures data moves securely. The Forwarder also uses API Token authentication, to ensure only
authorized Forwarders can connect to your environment. Forwarders must be assigned and configured with a token to
authenticate with the destination Graylog cluster or Cloud environment. When setting up a new Forwarder,
the :ref:`Forwarder Wizard <forwarder_wizard>` will guide you through the process of creating the API token.
Any tokens used by the Forwarder must belong to the user Forwarder System User (built-in). You can find
information about creating an `API token in the documentation <https://docs.graylog.org/en/4.0/pages/configuration/rest_api.html?highlight=token#creating-and-using-access-token>`__.


************
Installation
************

The Forwarder is distributed in similar packaging and installation methods as the Graylog server.
You can choose between operating system packages, Docker, and binary installation methods. See the
:ref:`Forwarder Installation <forwarder_installation>` page for more information.

*****
Setup
*****

The same Forwarder agent can be used for both Graylog Cloud and on-premise Graylog installations, but the required
setup is different for each environment.

Create Forwarder Input (on-premise only)
========================================

If you are setting up a Forwarder for Graylog on-premise, you will need to create a Forwarder input on the
*System > Inputs* page. Skip this step if you are using Graylog Cloud.
This special Forwarder input allows your Graylog nodes to accept connections from Forwarders.
This input should only be created once with the Global option checked. This will ensure that the input runs on
all Graylog nodes within the cluster.

The default values are appropriate for most environments. It is highly recommended to enable TLS, especially if the
Forwarder traffic will route over the internet. The process is similar  :ref:`to enabling TLS in Graylog Server<tls_setup>`.
You must provide your own TLS certificate and key for the input, and also later when configuring the Forwarder agent.

.. image:: /images/forwarder_input.png

Once the input has been created, verify that it is ``RUNNING``. Please see the Graylog server log if any
troubleshooting is needed.

.. _forwarder_wizard:

Setup Wizard
============

Graylog ships with a Forwarder Setup Wizard that provides guidance for setting up Forwarders in both the Cloud and
on-premise environments.

The Forwarder Setup Wizard can be found in the following locations:

* Graylog on-premise: Enterprise > Forwarders
* Graylog Cloud: System > Forwarders

From the main Forwarders page, launch the wizard by clicking the *New Forwarder* or *Get Started* buttons.
Once launched, the wizard will guide you through the appropriate configuration steps for your environment.

.. image:: /images/forwarder_wizard_intro.png

Complete the wizard by following the sections below:

Install Forwarder
-----------------

#. :ref:`Download and install the Forwarder<forwarder_installation>`.
#. Press *Continue* to navigate to the next step in the accordion.

Create API Token
----------------

We recommend using a unique API token for each Forwarder, ensuring that you can revoke tokens for individual Forwarders
that are no longer used.

#. Enter your *Token Name* in the available field.
#. Create the new name by clicking the *Create Token* button.

.. image:: /images/forwarder_api_token_1.png

Configure local Forwarder agent
-------------------------------

The wizard now displays the required configuration to input in the ``forwarder.conf`` file. This file provides all of
the environment-specific configuration needed for the Forwarder to connect successfully.

The required configuration is different for Graylog Cloud and on-premise. The wizard will automatically provide the
needed configuration for your particular setup on screen. You can then copy and paste it into your ``forwarder.conf``
file.

.. image:: /images/forwarder_config_1.png

See the :ref:`Forwarder Configuration values <forwarder_config_options>` page for a list of all supported configuration
options.

Example Graylog Cloud configuration file:

.. code-block::

    forwarder_server_hostname = ingest-<your-account-url>.graylog.cloud
    forwarder_grpc_api_token = <your-api-token>

Example Graylog on-premise configuration file:

.. code-block:: bash

    forwarder_server_hostname = (required) The Graylog server hostname where the Forwarder should connect to.
    forwarder_grpc_api_token = <your-api-token>
    forwarder_configuration_port = 13302
    forwarder_message_transmission_port = 13301
    forwarder_grpc_enable_tls = true
    forwarder_grpc_tls_trust_chain_cert_file = <path to cert.pem>

Start Forwarder
---------------

Once configured, the Forwarder must be started, so the setup wizard can find it on the next step.

If you are using the Forwarder OS packages, or docker, following the instructions on the
:ref:`Installation page<forwarder_os_packages>`.

If you are using the Forwarder binaries, you can use these instructions to start the Forwarder:

#. Open your terminal
#. Locate the startup script found in your application directory.
#. Run the startup script with the command ``./bin/graylog-forwarder run --configfile forwarder.conf``.
#. Return to the wizard after the Forwarder successfully runs.

Once the Forwarder starts successfully, the console should display the following message.

.. code-block::

    INFO: Forwarder Service started successfully.

Select Forwarder
----------------

Once the Forwarder makes a connection to Graylog, it will register automatically. Then, you will see it listed on the
next step. Both the hostname of the machine where the Forwarder is started, and the node id are are shown for each
Forwarder.

.. image:: /images/forwarder_select.png

#. Click the radio button to select the new Forwarder you just created.
#. Click *Configure selected Forwarder* to navigate to the next menu: *Configure Forwarder*.

Configure Forwarder
-------------------

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

After installing, configuring, and starting a Forwarder instance, it will register with Graylog
and appear on the Forwarders page in Graylog. Each Forwarder will have a *Configure* button to begin
the configuration process for it. In case the Forwarder is not displayed yet, clicking on New Forwarder
will give you information on how to configure and start it.

*************
Input Profile
*************

Input Profiles are a set of Inputs that can be configured to run on one or more Forwarders of your choice. 
This aspect is critical to your Forwarder because it provides a gateway to move data to Graylog.

Input Profiles helps you to avoid re-doing the same configuration for all Forwarders since you can start new Forwarders 
and assign them a set of Inputs you already defined and tested beforehand. This is especially helpful if you want to
collect the same kind of logs in different parts of your Infrastructure or to have a more redundant set-up.

As you create your Forwarder, you must create an Input Profile from the wizard, explained in Add Inputs.
Provide a descriptive name for the Input Profile, a short description of its intention, and then create all the input 
necessary for the Forwarder.

****************************************
Monitoring Forwarder Activity and Health
****************************************

After you connect your Forwarder to Graylog, get to know methods to access metrics and other information
on your Forwarder(s) and corresponding input(s). Here are a few methods to analyze and extract details on Forwarder 
activity:

* Review active Forwarder(s) on your Graylog Cloud instance
* Call Forwarder REST endpoints to consume information on health and list of inputs
* Export Forwarder metrics from Prometheus, a third-party monitoring tool
        
Forwarder Overview
==================

.. image:: /images/forwarders_list.png
        
One place to review Forwarder agent connectivity is the *Forwarders* screen, under the *Systems* menu.
This page provides a summary of all Forwarders. Identify the green Connected badge on the Status column. 
This tells you that a Forwarder is actively sending messages to your cloud instance. Another key indicator 
is found on the Metrics column. The cells that show active message rates, again, prove your Forwarders works.

Forwarder agent REST API
========================

The Forwarder agent supports a local REST API for checking health status, inputs, and exporting Prometheus metrics.
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

To obtain a list of Inputs running on the Forwarder, query the endpoint ``GET /api/inputs``.

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
        
        global:
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
      
#. Run this Docker command to start the container:

    .. code-block:: bash

            docker run \
              -p 9090:9090 \
              -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml \
              prom/prometheus
        
*****************
Resiliency Models
*****************
        
When you think about scaling your deployment -- that is, add more Forwarders -- you must incorporate tools, procedures, 
and policies that let you continue operating in the case of a major outage – widespread, long-lasting, destructive, or 
all three. If all the above pose a threat to your Forwarder consider both message recovery and load balancing. 
        
Message Recovery
================
        
The Forwarder’s disk journal is capable of caching data in case of a network outage. From there, they are read
and sent to Graylog.
        
As mentioned in the `Output Framework chapter <https://docs.graylog.org/en/4.0/pages/integrations/output_framework.html?highlight=Journal#on-disk-journal>`__, if the internet is unavailable, 
the Forwarder is still capable of receiving messages. So, once the internet is back the workflow will resume. 
Messages from the journal are sent to Graylog Cloud.
        
Load Balancing Options
======================

A larger deployment means more throughput i.e., requests passing through your systems. So, in a more mature, 
multi-Forwarder scenario we recommend you configure a load balancer to evenly distribute data transfer. This helps 
your deployment manage bulk requests and potential latency issues while ensuring resiliency.
        
More to the point, the load balancer distributes requests among healthy nodes in your local and/or external data 
centers. In our help docs, you can test and configure tools such as Apache HTTP server, Nginx, or HAProxy to handle 
requests among multiple Forwarders.

*************************
Distinguishing Forwarders
*************************

+--------------------------------+----------------------------------------+-------------------------------------------------+
| Type                           | Purpose                                | Details                                         |
+================================+========================================+=================================================+
|                                | This Forwarder allows you              | This Forwarder has an open-source instance      |
| Cluster-to-cluster Forwarder   | to configure an Output to forward      | However, it is only available within            |
|                                | messages from a source to a            | the Enterprise Integrations plugin.             |
|                                | destination cluster.                   |                                                 |
|                                |                                        |                                                 |
+--------------------------------+----------------------------------------+-------------------------------------------------+
|                                | Forward log messages to Graylog Cloud  | Your input profile can host multiple Forwarders.|
|  Forwarder                     | or on-premise.                         |                                                 |
|                                |                                        |                                                 |
|                                |                                        |                                                 |
+--------------------------------+----------------------------------------+-------------------------------------------------+
