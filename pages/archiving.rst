.. _archivetoc:

*********
Archiving
*********

Graylog enables you to configure a retention period to automatically delete older messages - this is to help you
control the costs of storage in Elasticsearch. But we know it's not ideal deciding between keeping less messages
in Graylog or paying more for hardware. Additionally, many of you are required to store data for long
periods of time due to compliance requirements like PCI or HIPAA.

The Archiving functionality allows you to archive log messages until you need to re-import them into Graylog for
analysis. You can instruct Graylog to automatically archive log messages to compressed flat files on the local
filesystem before retention cleaning kicks in and messages are deleted from Elasticsearch. Archiving also works
through a REST call or the web interface if you don't want to wait until retention cleaning to happen.
We chose flat files for this because they are vendor agnostic so you will always be able to access your data.

You can then do whatever you want with the archived files: move them to cheap storage, write them on tape, or
even print them out if you need to! If you need to search through archived data in the future, you can move any
selection of archived messages back into the Graylog archive folder, and the web interface will enable
you to temporarily import the archive so you can analyze the messages again in Graylog.

.. note:: The archive plugin is a commercial feature and part of `Graylog Enterprise <https://www.graylog.org/enterprise>`_.

.. toctree::
   :titlesonly:

   archiving/setup
   archiving/usage
