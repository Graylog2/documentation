Get Messages In
---------------

Log into the VM
^^^^^^^^^^^^^^^

We’re going to use rsyslog because we already have it from the Graylog server image. So, go to the image and login with ``ubuntu/ubuntu``.

.. image:: /images/gs_6-glslogin.png

Modify rsyslog.conf
^^^^^^^^^^^^^^^^^^^

Go to the ``/etc`` directory, and use ``vi``, ``vim`` (`vim Cheat Sheet <http://www.fprintf.net/vimCheatSheet.html>`_), or the editor of your choice to modify the ``/etc/rsyslog.conf`` file.  There are excellent resources on the web for `rsyslog configuration <http://www.rsyslog.com/doc/v8-stable/tutorials/reliable_forwarding.html>`_.

At the bottom of the file, add the following so messages will forward::

  *.* @127.0.0.1:5140;RSYSLOG_SyslogProtocol23Format

In case you wanted to know, ``@`` means UDP, ``127.0.0.1`` is localhost, and ``5140`` is the port.

.. image:: /images/gs_7-rsyslogadd.png

Restart rsyslog
^^^^^^^^^^^^^^^

Type::

  $sudo service rsyslog status
  $sudo service rsyslog restart

If you have modified the config file and it is somehow invalid, the service command will not bring rsyslog back up - so don't worry, you can always delete the line!

We have even more information how to send messages to Graylog on :ref:`a special page <ingest_data>` in our Documentation.
