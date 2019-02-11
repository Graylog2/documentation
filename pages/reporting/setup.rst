*****
Setup
*****

Reporting is a commercial Graylog feature that can be installed in addition
to the Graylog open source server.

Installation
============

Reporting is part of the Graylog Enterprise plugin, please check the :doc:`Graylog Enterprise setup page </pages/enterprise/setup>`
for details on how to install it.

Configuration
=============

In most cases you can use the Reporting functionality without doing any changes in
your Graylog configuration file (check the :ref:`default file locations page <default_file_location>`
to see where you can find it). Next you can find all available configuration
options in case you need to do some advanced configuration.

.. list-table:: Configuration Options
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - ``report_disable_sandbox``
      - Disables report generation sandbox.
    * - ``report_generation_timeout_seconds``
      - Timeout in seconds to wait for a report generation.
    * - ``report_user``
      - Internal user to generate reports.
    * - ``report_render_uri``
      - URI to connect to Graylog Web Interface.
    * - ``report_render_engine_port``
      - Port to communicate with background process.

report_disable_sandbox
----------------------
Default value: ``false``.

For security reasons, report generation will run in a sandbox and not as root
user. There are two cases where you may consider enabling this option:

- Environments where you want or must use the root user to run reporting
  generation.
- Environments that provide limited kernel capabilities, like a docker container.

report_generation_timeout_seconds
---------------------------------
Default value: ``180``.

Time in seconds to wait for a report to load in the background. You may
need to increase this value if your reports are doing expensive queries
or your ES cluster is a bit slow.

report_user
-----------
Default value: ``graylog-report``.

Graylog user that will be used internally to generate reports in the background.
To ensure the user has access to all required information, this user must have
the `Report System (Internal)` role assigned.

report_render_uri
-----------------
Default value: ``$http_publish_uri``.

Customize the URI the background process uses to connect to the web interface.
By default it uses the value of the :ref:`http_publish_uri <web_rest_api_options>`
option in your Graylog configuration file.

report_render_engine_port
-------------------------
Default value: ``9515``.

Customize the port used to communicate with the background process.

