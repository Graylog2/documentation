*****
Setup
*****

Reporting is a commercial Graylog feature that can be installed in addition
to the Graylog open source server.

Installation
============

Reporting is part of the Graylog Enterprise plugin, please check the :doc:`Graylog Enterprise setup page </pages/enterprise/setup>`
for details on how to install it.

The PDF generation needs the ``fontconfig`` package installed on the server it is running on.

On a Debian based system use ``apt`` to install it, e.g.::

  $ sudo apt-get install fontconfig

Respectively on a RedHat based systems use::

  $ sudo yum install fontconfig


Configuration
=============

In most cases you can use the Reporting functionality without making any changes to
your Graylog configuration file (check the :ref:`default file locations page <default_file_location>`
to see where you can find it). Below, you will find all available configuration
options in case you need to do some advanced configuration.

.. list-table:: Configuration Options
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - ``bin_dir``
      - Directory with binaries needed for PDF generation.
    * - ``data_dir``
      - Cache directory for PDF generation.
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

bin_dir
-------
Default value: ``bin`` - relative to Graylog working directory

The default distribution comes with two binaries needed for PDF generation 'headless_shell' and 'chromedriver'.
These binaries are usually located in ``/usr/share/graylog-server/bin``.

data_dir
--------
Default value: ``data`` - relative to Graylog working directory

The PDF generation happens on disk in the first place so Graylog needs a place to write out temporary files.
The system packages create ``/var/lib/graylog-server`` for this purpose. Make sure this directory is correctly configured
and read-, and writable for the Graylog Server user.

report_disable_sandbox
----------------------
Default value: ``false``.

To ensure the maximum security in your system, the reporting generation process
runs inside a sandbox, which provides a restricted environment for the
application. That sandbox can only be used when the process is executed as a
normal user, as the ``root`` user has special administrative privileges that
could grant a potential attacker full access to your system.

We recommend leaving this configuration option set to ``false``.

Unfortunately, there are two scenarios where the security features provided by
the sandbox cannot be used:

- Environments where you want or must use the ``root`` user to run reporting
  generation.
- Environments that provide limited kernel capabilities. On the one hand Docker containers
  limit the kernel capabilities in a way that sandboxing doesn't work. On the other hand
  some RedHat/CentOS based systems come with older kernel versions which also lack the necessary
  capabilities. Systems with a kernel version >= 4.x should be fine for the default settings.

In case your Graylog server runs in one of those scenarios, you may consider
disabling the sandbox.

Please note that this option only affects the reporting generation process, not
the Graylog server.

report_generation_timeout_seconds
---------------------------------
Default value: ``180``.

Time in seconds to wait for a report to load in the background.

To ensure all widgets in your report have time to fetch their data and load,
Graylog will wait up to the value set to this configuration option. When a
report takes longer than that to load, the report generation will fail and
Graylog will log the error in its logs.

In case reports in your Graylog setup are not being generated and the server
displays a timeout error, you may need to increase this value.

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

