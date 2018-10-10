****************************
Architecture
****************************

Every Graylog System is composed of at least one instance of Graylog Server, MongoDB and Elasticsearch. Each of these components are required and cannot be substituted with any other technology. 



Minimum
-------
In a minimum Graylog deployment, all three components are installed on a single host. A minimum Graylog setup that can be used for smaller, non-critical, or test setups.

None of the components is redundant but it is easy and quick to set up.

.. image:: /images/architec_small_setup.png

Our :ref:`Virtual Machine Appliances <virtual-machine-appliances>` are using this design by default, deploying nginx as :ref:`frontend proxy <configuring_webif_nginx>`.

Simple Multi-Node
-----------------
In a Simple Multi-Node system, Graylog and Elasticsearch components each reside on their own hosts. Most customers install MongoDB on same host as the Graylog Server. Since it is used primarily for application configuration information, the load on MongoDB is low enough that it does not typically need its own host. 

.. _big_production_setup:

Complex Multi-Node
------------------
For larger environments, or where High Availability is required, Graylog may be deployed in a Complex Multi-Node configuration. Both Graylog and Elasticsearch may be clustered to provide resilience in case of a node failure. Multi-node systems are often required in order support a high volume of events.

Complex Multi-Node designs will be required for larger production environments. It is comprised of two or more Graylog nodes behind a load balancer distributing the processing load.

The load balancer can ping the Graylog nodes via HTTP on the Graylog REST API to check if they are alive and take dead nodes out of the cluster.

.. image:: /images/architec_bigger_setup.png

How to plan and configure such a setup is covered in our :ref:`Multi-node Setup guide <configure_multinode>`.

Some guides on the `Graylog Marketplace <https://marketplace.graylog.org/>`__ also offer some ideas how you can use `RabbitMQ (AMQP) <https://marketplace.graylog.org/addons/246dc332-7da7-4016-b2f9-b00f722a8e79>`__ or `Apache Kafka <https://marketplace.graylog.org/addons/113fd1cb-f7d2-4176-b427-32831bd554ee>`__ to add some queueing to your setup.

Architectural considerations
----------------------------
There are a few rules of thumb when scaling resources for Graylog:

* Graylog nodes should have a focus on CPU power. These also serve the user interface to the browser.
* Elasticsearch nodes should have as much RAM as possible and the fastest disks you can get.
  Everything depends on I/O speed here.
* MongoDB is storing meta information and configuration data and doesn't need many resources.

Also keep in mind that ingested messages are **only** stored in Elasticsearch. If you have data loss
in the Elasticsearch cluster, the messages are gone - unless you have created backups or archives of the indices.



