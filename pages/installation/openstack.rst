.. _OpenStack:

*********
OpenStack
*********

Installation
------------

Download the Graylog image from the `package <https://packages.graylog2.org/appliances/qcow2>`_ site, uncompress it and import it into the OpenStack image store::

  $ wget https://packages.graylog2.org/releases/graylog-omnibus/qcow2/graylog-3.0.0-1.qcow2.gz
  $ gunzip graylog-3.0.0-1.qcow2.gz
  $ glance image-create --name='graylog' --is-public=true --container-format=bare --disk-format=qcow2 --file graylog-3.0.0-1.qcow2

You should now see an image called `graylog` in the OpenStack web interface under `Images`

Usage
-----

Launch a new instance of the image, make sure to reserve at least 4GB ram for the instance. After spinning up, login with
the username `ubuntu` and your selected ssh key.

Open `http://<vm ip>` in your browser to access the Graylog web interface. Default username and password is `admin`.

Networking
==========

Your browser needs access to port 80 or 443 for reaching the web interface. The interface itself creates a connection back to the REST API of the Graylog server on port 9000. As long as you are in the same private Neutron Network, this works out of the box.

In the most common OpenStack deployment topology if you want to use the OpenStack floating IP address of your VM, this mechanism doesn’t work automatically anymore.
In order to tell Graylog how to reach the API from the users browser perspective, you need to set the ``http_external_uri`` in the :ref:`Graylog configuration file <web_rest_api_options>`::
   http_external_uri = <floating ip>:9000

Make sure to restart your server after the configuration change.

Also make sure that port 80, 443 and 9000 is allowed for incoming traffic on a security group assigned the the VM.

Configuration
=============

Starting with Graylog 3.0.0, virtual machine appliances also use the
:doc:`Graylog Operating System packages </pages/installation/operating_system_packages>`.
Please check the :doc:`Graylog configuration file </pages/configuration/server.conf>`
documentation, if you need to further customize your appliance.

Production readiness
====================

The Graylog appliance is not created to provide a production ready solution. It is build to offer a fast and easy way to try the software itself and not wasting time to install Graylog and it components to any kind of server. 

If you want to create your own production ready setup take a look at our :ref:`other installation methods <installing>`.
