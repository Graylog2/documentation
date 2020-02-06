Search result highlighting
--------------------------

Graylog supports search result highlighting since v0.20.2:

.. image:: /images/searching/search_result_highlight.png

Enabling/Disabling search result highlighting
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Using search result highlighting will result in slightly higher resource consumption of searches. You can enable and disable
it using a configuration parameter in the ``graylog.conf`` of your Graylog nodes::

  allow_highlighting = true