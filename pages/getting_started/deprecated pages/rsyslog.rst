Get Messages In
---------------

Log in to the VM
^^^^^^^^^^^^^^^^

We’re going to use rsyslog to ship messages to Graylog since it's already running on the virtual machine.

To start, go to your virtual machine's window (starting it back up if needed) and login with ``ubuntu`` for both the username and password.

.. image:: /images/gs_6-glslogin.png

Modify rsyslog.conf
^^^^^^^^^^^^^^^^^^^

Go to the ``/etc`` directory, and use ``vi``, ``vim`` (`vim Cheat Sheet <http://www.fprintf.net/vimCheatSheet.html>`_), or the editor of your choice to modify the ``/etc/rsyslog.conf`` file.  There are excellent resources on the web for `rsyslog configuration <http://www.rsyslog.com/doc/v8-stable/tutorials/reliable_forwarding.html>`_.

At the bottom of the file, add the following so messages will forward::

  *.* @127.0.0.1:514;RSYSLOG_SyslogProtocol23Format

In case you're curious: ``@`` means UDP, ``127.0.0.1`` is localhost, and ``514`` is the port. Fortunately, our Graylog environment has an input to accept syslog messages on UDP port 514!

You can find out more about ingesting syslog messages with Graylog in our `Syslog configuration guide <https://github.com/Graylog2/graylog-guide-syslog-linux>`__.

Restart rsyslog
^^^^^^^^^^^^^^^

Type::

  $ sudo service rsyslog status
  $ sudo service rsyslog restart

If you have modified the config file and it is somehow invalid, the service command will not bring rsyslog back up - but don't worry, you can always delete the line!

Ingesting more log messages
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Please refer to :ref:`ingest_data` for further instructions about configuring Graylog and ingesting data from external sources.
