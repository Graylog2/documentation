.. _securing:

****************
Securing Graylog
****************

To secure your Graylog setup, you should not use one of our pre-configured images, create your own unique installation where you understand each component and secure the environment by design. Expose only the services that are needed and secure them whenever possible with TLS/SSL and some kind of authentication. Do not use the pre-created appliances for critical production environments.

On the Graylog appliances MongoDB and Elasticsearch is listening on the external interface. This makes the creation of a cluster easier and demonstrates the way Graylog works.
Never run this in an insecure network.

When using Amazon Web Services and our pre-configured AMI, never open all ports in the security group. Do not expose the server to the internet. Access Graylog only from within your VPC. Enable encryption for the communication.

Default ports
=============

All parts of one Graylog installation will communicate over network sockets. Depending on your setup and number of nodes this might be exposed or can be bound to localhost. The :ref:`SELinux <selinux>` configuration is already covered in our step-by-step guide for CentOS Linux.

.. list-table:: Default network communication ports
    :header-rows: 1

    * - Component
      - Port
    * - Graylog (web interface / API)
      - 9000 (tcp)
    * - Graylog to Elasticsearch
      - 9200 (tcp)
    * - Elasticsearch node communication
      - 9300 (tcp)
    * - MongoDB
      - 27017 (tcp)



Each setup is unique in the requirements and ports might be changed by configuration, but you should limit who is able to connect to which service. In the :ref:`architecture description <big_production_setup>` you can see what components need to be exposed and communicate with each other.

Configuring TLS ciphers
=======================

When running Graylog in untrusted environments such as the Internet, we strongly recommend to use SSL/TLS for all connections.

It's possible to :ref:`disable unsafe or deprecated TLS ciphers <disable_ciphers_java>` in Graylog. When using :ref:`nginx or Apache httpd <configuring_webif_nginx>` for SSL termination the `Mozilla SSL Configuration Generator <https://mozilla.github.io/server-side-tls/ssl-config-generator/>`_ will help to create a reasonably secure configuration for them.


Security related topics
=======================

.. toctree::
   :titlesonly:
   :glob:


   sec_*
