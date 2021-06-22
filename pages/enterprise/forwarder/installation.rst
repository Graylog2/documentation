.. _forwarder_installation:

######################
Forwarder Installation
######################

************
Introduction
************

The Forwarder is distributed in similar packaging and installation methods as the Graylog server.
You can choose between operating system packages, docker, and binary tar installation methods for the Forwarder.
Each installation method is described below in more detail.

*******************
Binary Installation
*******************

The binary installation can be performed by downloading the binaries and manually installing them on disk.

The latest Forwarder binaries can be obtained from the `Downloads page <https://www.graylog.org/downloads-2>`_ by
choosing the TGZ option.

*************************************
Operating System Package Installation
*************************************

.. _forwarder_os_packages:

The most common installation method is to use the Linux operating system packages. You can choose
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

#. Install the Graylog repository configuration:

    .. code-block:: bash

        $ sudo rpm -Uvh https://packages.graylog2.org/repo/packages/graylog-4.0-repository_latest.rpm

#. Install the ``graylog-forwarder`` package:

    .. code-block:: bash
    
        $ sudo yum install graylog-forwarder

#. Create the certificate and update the configuration file:

    .. code-block:: bash
    
        $ sudo vi /etc/graylog/forwarder/forwarder.conf

#. Start the service:

    .. code-block:: bash

        $ sudo systemctl start graylog-forwarder.service

*******************
Docker Installation
*******************

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
