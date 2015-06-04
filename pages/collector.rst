*********************
The Graylog collector
*********************

The Graylog collector is a lightweight process that allows you to forward data from log files to a Graylog cluster. It reads contents of local files or
Windows EventLog directly and sends it over the network using the `GELF format <https://www.graylog.org/resources/gelf-2/>`_.

Installation
************

Linux/Unix
^^^^^^^^^^

#. Unzip collector tgz file to target location
#. cp collector.conf.example to collector.conf
#. Update server-url in collector.conf to correct Graylog server address (required for registration)
#. Update file input configuration with the correct log files
#. Update outputs->gelf-tcp with the correct Graylog server address (required for sending GELF messages)

**Note:** The collector will not start properly if you do not set the URL or the correct input log files and GELF output configuration

Windows
^^^^^^^

Download a collector release zip file from the Graylog homepage. Unzip the collector zip file to target location.

.. image:: /images/collector_win_install_1.png

Change into the extracted collector directory and create a collector configuration file in ``config\collector.conf``.

.. image:: /images/collector_win_install_2.png

The following configuration file shows a good starting point for Windows systems. It collects the *Application*, *Security*, and *System* event logs.
Replace the ``x.x.x.x`` with the IP address of your Graylog server.

Example::

  server-url = "http://x.x.x.x:12900/"

  message-buffer-size = 128

  inputs {
    win-eventlog-application {
      type = "windows-eventlog"
      source-name = "Application"
      poll-interval = 1s
    }
    win-eventlog-system {
      type = "windows-eventlog"
      source-name = "System"
      poll-interval = 1s
    }
    win-eventlog-security {
      type = "windows-eventlog"
      source-name = "Security"
      poll-interval = 1s
    }
  }

  outputs {
    gelf-tcp {
      type = "gelf"
      host = "x.x.x.x"
      port = 12201
    }
  }

Start a ``cmd.exe``, change to the collector installation path and execute the following commands to install the collector as Windows service.

Commands::

  C:\> cd graylog-collector-0.2.2
  C:\graylog-collector-0.2.2> bin\graylog-collector-service.bat install GraylogCollector
  C:\graylog-collector-0.2.2> bin\graylog-collector-service.bat start GraylogCollector

.. image:: /images/collector_win_install_3.png

Running the Collector
*********************

You will need a configuration before starting the collector. An configuration file example can be found below.

Linux/Unix
^^^^^^^^^^

The collector needs a configuration file (see "Example configuration" below) and can be started with the following command.

Example::

  $ bin/graylog-collector run -f ../config/collector.conf

Windows
^^^^^^^

You probably want to run the collector as Windows service as described in the Windows installation section above.
If you want to run it from the command line, run the following commands.

Make sure you have a valid configuration file in ``config\collector.conf``.

Commands::

  C:\> cd graylog-collector-0.2.2
  C:\graylog-collector-0.2.2> bin\graylog-collector.bat run -f config\collector.conf

.. image:: /images/collector_win_run_1.png

Troubleshooting
^^^^^^^^^^^^^^^

Check the standard output of the collector process for any error messages or warnings. Messages not arriving in your Graylog
cluster? Check possible firewalls and the network connection.

Command Line Options
********************

Linux/Unix
^^^^^^^^^^

The collector offers the following command line options::

  usage: graylog-collector <command> [<args>]

  The most commonly used graylog-collector commands are:

      help      Display help information

      run       Start the collector

      version   Show version information on STDOUT

   See 'graylog-collector help <command>' for more information on a specific command.

   NAME
          graylog-collector run - Start the collector

   SYNOPSIS
          graylog-collector run -f <configFile>

   OPTIONS
          -f <configFile>
              Path to configuration file.


Example Configuration
^^^^^^^^^^^^^^^^^^^^^

This is an example configuration file::

  message-buffer-size = 128

  inputs {
    local-syslog {
      type = "file"
      path = "/var/log/syslog"
    }
    apache-access {
      type = "file"
      path = "/var/log/apache2/access.log"
      outputs = "gelf-tcp,console"
    }
    test-log {
      type = "file"
      path = "logs/file.log"
    }
  }

  outputs {
    gelf-tcp {
      type = "gelf"
      host = "127.0.0.1"
      port = 12201
      client-queue-size = 512
      client-connect-timeout = 5000
      client-reconnect-delay = 1000
      client-tcp-no-delay = true
      client-send-buffer-size = 32768
      inputs = "test-log"
    }
    console {
      type = "stdout"
    }
  }

Notice how inputs can choose which outputs to forward data with.

Correctly Configured Collector Log Sample
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the `STDOUT` output of a collector starting up with no problems::

  2015-05-12T16:00:10.841+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Starting Collector v0.2.0-SNAPSHOT (commit a2ad8c8)
  2015-05-12T16:00:11.489+0200 INFO  [main] o.g.collector.utils.CollectorId - Collector ID: cf4734f7-01d6-4974-a957-cb71bbd826b7
  2015-05-12T16:00:11.505+0200 INFO  [GelfOutput] o.g.c.outputs.gelf.GelfOutput - Starting GELF transport: org.graylog2.gelfclient.GelfConfiguration@3952e37e
  2015-05-12T16:00:11.512+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: BufferProcessor [RUNNING]
  2015-05-12T16:00:11.513+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: MetricService [RUNNING]
  2015-05-12T16:00:11.515+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: FileInput{id='local-syslog', path='/var/log/syslog', charset='UTF-8', outputs='', content-splitter='NEWLINE'}
  2015-05-12T16:00:11.516+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: GelfOutput{port='12201', id='gelf-tcp', client-send-buffer-size='32768', host='127.0.0.1', inputs='', client-reconnect-delay='1000', client-connect-timeout='5000', client-tcp-no-delay='true', client-queue-size='512'}
  2015-05-12T16:00:11.516+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: HeartbeatService [RUNNING]
  2015-05-12T16:00:11.516+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: StdoutOutput{id='console', inputs=''}
>>>>>>> 1.1
