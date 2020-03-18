************
Introduction
************

.. _enterprise_features:

Graylog Enterprise is made of the combination of the open source core and several plugins that contribute functionality. This way someone coming from open source can add Enterprise simply by installing a new operating system package.

When the Graylog enterprise plugins and Graylog enterprise integrations plugin is installed the some additional features are added to Graylog. The following list should give a brief overview what is added to Graylog. All of this will only work with a valid enterprise license. 



    - :ref:`Archiving<archivetoc>`
		* Store the data after a configurable time on disk for infinite time. This enables to fulfill most compliance rules about storing specific data for a specific amount of time.

    - :ref:`Audit log<auditlog_toc>`
		* This enables to keep record about changes that are done in Graylog.

    - :ref:`Reporting - Extension of Dashboards<reporting_toc>` 
    	* Get the reportings you need delivered to your Inbox.

    - Search extensions
		* :ref:`Parameter support<search_parameters>` - placeholders in the query, which asks users for values to put into queries, without having to copy&paste queries themselves
            
    - Alerting extensions (basic Alerting is part of open source)
		* Event Correlation

		* :ref:`Dynamic Lists<event_filter_dynamic>` - allows to lookup values in lookup tables and use the result in the alert query this feature use based on Search Parameters

		* Cluster-wide scheduler - Open Source runs alerts on a single node only, Enterprise runs them on all Graylog nodes, increasing capacity

		* :ref:`Script Notification<alerts_script_alert>` - ability to run a custom native program in response to generating an alert, useful for the integration of third-party systems

    - :ref:`MongoDB Lookup Table<lookuptable_mongodb>`
        * This allows settings values from pipelines, e.g. to maintain a list of suspicious IP addresses to be used in Dynamic Lists

    - :ref:`Forwarding<forwarder>`
        * Cluster-to-cluster forwarder output - requires two fully functioning Graylog clusters, adds the ability to forward specific data streams to remote locations





Please see the `Graylog Enterprise Page <https://www.graylog.org/enterprise>`_ for more details.