************
Introduction
************

.. _enterprise_features:

Graylog Enterprise is made of the combination of the open source core and several plugins that contribute functionality. This way someone coming from open source can add Enterprise simply by installing a new operating system package.

When the Graylog enterprise plugins and Graylog enterprise integrations plugin is installed the some additional features are added to Graylog. The following list should give a brief overview what is added to Graylog. All of this will only work with a valid enterprise license. 



    - :ref:`Archiving<archivetoc>`
		* Archiving allows you to store the data to long term retention location, for an infinite amount of time. This can be local or removable media. This will allow most users to meet compliance regulation around data retention

    - :ref:`Audit log<auditlog_toc>`
		* Audit log enables Graylog to keep a record about changes done in-product, on all levels of users.

    - :ref:`Reporting - Extension of Dashboards<reporting_toc>` 
    	* Take any of your current dashboard widgets, and put them into a scheduled report you can have delivered to your Inbox.

    - Search extensions
		* :ref:`Parameter support<search_parameters>` - placeholders in the query, which asks users for values to put into queries, without having to copy&paste queries themselves
            
    - Alerting extensions (basic Alerting is part of open source)
		* Event Correlation

		* :ref:`Dynamic Lists<event_filter_dynamic>` - allows Graylog to lookup values in lookup tables and use the result in the alert query field in the correlation rule. This feature is based on Search Parameters.

		* Cluster-wide scheduler - Open Source runs alerts on a single node only, Enterprise runs them on all Graylog nodes, increasing capacity.

		* :ref:`Script Notification<alert_notification_script>` - ability to run a custom native program in response to a generated alert, useful for the integration of third-party systems.

    - :ref:`MongoDB Lookup Table<lookuptable_mongodb>`
        * This allows settings values from pipelines, e.g. to maintain a list of suspicious IP addresses to be used in Dynamic Lists

    - :ref:`Forwarding<forwarder>`
        * Cluster-to-cluster forwarder output - requires two fully functioning Graylog clusters. The forwarder adds the ability to forward specific data streams to remote locations with journaling support incase of outages.





Please see the `Graylog Enterprise Page <https://www.graylog.org/enterprise>`_ for more details.