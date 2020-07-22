******************
Reading from files
******************

Log files come in a lot of different flavors and formats, much more than any single program could handle.

To support this use case, we provide the :ref:`Sidecar <graylog-sidecar>` which acts as a supervisor process for other programs, such as nxlog and Filebeats, which have specifically been built to collect log messages from local files and ship them to remote systems like Graylog.

Of course you can still use any program supporting the GELF or syslog protocol (among others) to send your logs to Graylog.
