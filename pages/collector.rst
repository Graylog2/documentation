*********************
The Graylog collector
*********************

Installation
************

**Linux/Unix**

#. Unzip collector tgz file to target location
#. cp collector.conf.example to collector.conf
#. Update server-url in collector.conf to correct Graylog server address (required for registration)
#. Update file input configuration with the correct log files 
#. Update outputs->gelf-tcp with the correct Graylog server address (required for sending GELF messages)

**Note:** The collector will not start properly if you do not set the URL or the correct input log files and GELF output configuration

**Windows**

**OSX**

#. Unzip collector tgz file to target location
#. Navigate to target location
#. cp config/collector.conf.example to config/collector.conf
#. Update server-url in collector.conf to correct Graylog server address (required for registration)
#. Update file input configuration with the correct log files 
#. Update outputs->gelf-tcp with the correct Graylog server address (required for sending GELF messages)

Running the Collector
*********************

You will need a configuration before starting the collector. An configuration file example can be found below. 

**Linux/Unix**

The collector needs a configuration file and can be started with the following command.
Example: 
$ bin/graylog-collector run -f ../config/collector.conf

**Windows**

**OSX**

**Troubleshooting**

Check standard output for error messages

Command Line Options
********************

**Linux/Unix**

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


**Example Configuration**

message-buffer-size = 128

\inputs {\
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
}\

Correctly Configured Collector Log Sample
*****************************************


2015-05-12T16:00:10.841+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Starting Collector v0.2.0-SNAPSHOT (commit a2ad8c8)

2015-05-12T16:00:11.489+0200 INFO  [main] o.g.collector.utils.CollectorId - Collector ID: cf4734f7-01d6-4974-a957-cb71bbd826b7

2015-05-12T16:00:11.505+0200 INFO  [GelfOutput] o.g.c.outputs.gelf.GelfOutput - Starting GELF transport: org.graylog2.gelfclient.GelfConfiguration@3952e37e

2015-05-12T16:00:11.512+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: BufferProcessor [RUNNING]

2015-05-12T16:00:11.513+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: MetricService [RUNNING]

2015-05-12T16:00:11.515+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: FileInput{id='local-syslog', path='/var/log/syslog', charset='UTF-8', outputs='', content-splitter='NEWLINE'}

2015-05-12T16:00:11.516+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: GelfOutput{port='12201', id='gelf-tcp', client-send-buffer-size='32768', host='127.0.0.1', inputs='', client-reconnect-delay='1000', client-connect-timeout='5000', client-tcp-no-delay='true', client-queue-size='512'}

2015-05-12T16:00:11.516+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: HeartbeatService [RUNNING]

2015-05-12T16:00:11.516+0200 INFO  [main] o.graylog.collector.cli.commands.Run - Service RUNNING: StdoutOutput{id='console', inputs=''}

