*****************
Microsoft Windows
*****************

Unfortunately there is no officially supported way to run Graylog on Microsoft Windows operating systems even though all parts run on the
Java Virtual Machine. We recommend to run the :ref:`virtual machine appliances <virtual-machine-appliances>`  on a Windows host.
It should be technically possible to run Graylog on Windows but it is most probably not worth the time to work your way around the cliffs.

Should you require running Graylog on Windows, you need to disable the message journal in ``graylog-server`` by changing the following setting in the ``graylog.conf``::

  message_journal_enabled = false

Due to restrictions of how Windows handles file locking the journal will not work correctly. This will be improved in future versions.

**Please note that this impacts Graylog's ability to buffer messages, so we strongly recommend running the Linux-based OVAs on Windows.**
