*****
Usage
*****

Reports let you combine multiple Dashboard widgets to create a document that
can display certain information in your Graylog system in an organized format
for specific purposes.

.. note:: Reports are based on Dashboard widgets, so please ensure you understand
   :doc:`Dashboards </pages/dashboards>` before you get started.

Creating Reports
================

You can create a report on the "Enterprise/Reports" page in the web interface.

.. image:: /images/reporting-reports-page.png

Click on the "Create Report" button to get started. That page contains two
different sections:

- **Contents** You can use the form to configure the report's cover page, a
  short description, and select the widgets that will be part of the report.
- **Summary** This information will usually appear on your right and will follow
  you as you scroll through the page. It displays a summary of the data included
  in the report.

.. image:: /images/reporting-create-page.png

Once you are satisfied with the content that will make part of your report, click
on "Create report" to store that configuration in the database.

You can change the selected contents of a report any time by going to the
"Enterprise/Reports" page and clicking on the "Contents" button for the report
you wish to modify.

Configure Reports
=================

The Report Configuration page provides options to schedule the report for
delivery and also to configure the layout of the report.

Go to the "Enterprise/Reports" page and click on "Configuration" to open the
Report Configuration page.

.. image:: /images/reporting-configuration-page.png


Scheduling
----------

.. warning:: Please ensure the :ref:`email configuration <email_config>` in
   your Graylog configuration file is working before you enable report
   scheduling.

.. note:: Scheduling Reports will use resources in the background on both your
   Graylog and ES cluster. To avoid performance issues, make sure to allocate
   enough resources for your setup and also disable scheduling of Reports you
   don't need to be send automatically.

On the Scheduling section you can configure how often the report will be sent. It
is possible to send reports daily, weekly or on a monthly basis.

Here you can also add a subject and body to the email that will contain the report
and select Graylog users or external email addresses that should receive the report
as email.

Once you update the information, make sure to click on "Update scheduling" to save
your changes.


Layout
------

Much like in a Dashboard, you can drag and drop widgets on the virtual sheet of
paper to select the orders the widgets should go in the report. Rearranging
widgets will save the change in the layout automatically.

Please note that the cover page will always go in the first page of the report, and
the next page will start with the report description followed by all widgets in
the configured order.

History
=======

As the background generation of reports may fail, the Report History page can help
you finding out if there was some error while generating and sending a report in
the background.

To open the Report history page for a report, click on the "More actions" button
for that report, and select "Report history".

.. image:: /images/reporting-history-page.png

Generating report on demand
===========================

Download manually
-----------------

You can generate and download a report manually from the web interface. To do so,
go to the "Enterprise/Reports" page, click on the "More actions" button for the
report you want to download, and select "Download report now".

Please take into account that the report generation may take a while.


Send report as email manually
-----------------------------

Additionally to downloading a report on demand, you can also generate and send
the report at any time by clicking on "More actions" and "Send report now" on
the "Enterprise/Reports" page.

