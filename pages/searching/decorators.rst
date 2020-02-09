.. _decorators:

Decorators
----------
Decorators allow you to alter message fields during search time automatically, while *preserving the unmodified message on disk*. Decorators
are specially useful to make some data in your fields more readable, combine data in some field, or add new fields with more information about
the message. As decorators are configured per stream (including the :ref:`default stream <default_stream>`), you are also able to present a
single message in different streams differently.

As changes made by decorators are not persisted, you cannot search for decorated values or use field analyzers on them. You can
still use those features in the original non-decorated fields.

Decorators are applied on a stream-level, and are shared among all users capable of accessing a stream, so all users can share the same results
and benefit from the advantages decorators add.

Graylog includes some message decorators out of the box, but you can add new ones from pipelines or by writing your own as plugins.

Decorators can be configured in the system menu under "System/Configurations". Select a stream in the section "Decorators Configuration" to see
an overview of all related decorators.

.. image:: /images/searching/decorator_overview.png
   :align: center

To add new default decorators to a stream, click on the *Update* button. This will open a modal which provides two selects,
one to specifiy the stream and one to define the type of the decorator. After creating a decorator you need to *Save* the changes to finish the configuration.

.. image:: /images/searching/decorator_creation.png
   :align: center

When you apply multiple decorators to the same search results, you can change the order in which they are applied at any time by using
drag and drop in the decorator list inside the modal.

List active decorators
^^^^^^^^^^^^^^^^^^^^^^

The message table widget provides an overview of all active decorators. When opening the stream search page, by selecting a stream on the "Streams" page,
the widget will be preconfigured and display the related search results. Editing the message table widget will open a modal with an overview of all active decorators.
You can also add decorators here, but they will not be saved or associated with the stream. If you want to save a decorator only for a specific message table,
you can do this inside a :ref:`dashboards` or :ref:`saved-searches`.

.. image:: /images/searching/decorator_message_table.png
   :align: center

.. _syslog_severity_mapper:

Syslog severity mapper
^^^^^^^^^^^^^^^^^^^^^^
The syslog severity mapper decorator lets you convert the numeric syslog level of syslog messages, to a human readable string. For example,
applying the decorator to the ``level`` field in your logs would convert the syslog level ``4`` to ``Warning (4)``.

To apply a syslog severity mapper decorator, you need to provide the following data:

* **Source field**: Field containing the numeric syslog level
* **Target field**: Field to store the human readable string. It can be the same one as the source field, if you wish to replace the numeric
  value on your search results

Format string
^^^^^^^^^^^^^
The format string decorator provides a simple way of combining several fields into one. It can also be used to modify the content of a field
in, without altering the stored result in Elasticsearch.

To apply a format string decorator you need to provide the following data:

* **Format string**: Pattern used to format the resulting string. You can provide fields in the message by enclosing them in ``${}``.
  E.g. ``${source}`` will add the contents of the ``source`` message field into the resulting string
* **Target field**: Field to store the resulting value
* **Require all fields** (optional): Check this box to only format the string when all other fields are present

For example, using the format string ``Request to ${controller}#${action} finished in ${took_ms}ms with code ${http_response_code}``, could
produce the text ``Request to PostsController#show finished in 57ms with code 200``, and make it visible in one of the message fields in
your search results.

Pipeline Decorator
^^^^^^^^^^^^^^^^^^
The pipeline decorator provides a way to decorate messages by processing them with an existing :doc:`processing pipeline </pages/pipelines>`.
In contrast to using a processing pipeline, changes done to the message by the pipeline are not persisted. Instead, the pipeline is used at search time
to modify the *presentation* of the message.

The prerequisite of using the pipeline decorator is that an existing pipeline is required.

.. note:: Please take note, that the pipeline you use for decoration should not be connected to a stream. This would mean that it is run twice (during indexing *and* search time) for each message, effectively rendering the second run useless.

When you are done creating a pipeline, you can now add a decorator using it on any number of streams. In order to create one, you proceed just like for
any other decorator type, by navigating to "System/Configurations" and clicking on the *Update* in the section "Decorators Configuration"
and selecting the type ("Pipeline Processor Decorator" in this case) and clicking the *Apply* button next to one.

.. image:: /images/searching/decorator_pipeline_select.png
   :align: center

After selecting a pipeline and clicking *Save*, you are already set creating a new pipeline decorator.

Further functionality
^^^^^^^^^^^^^^^^^^^^^

If the existing decorators are not sufficient for your needs, you can either search the `Graylog marketplace <http://marketplace.graylog.org>`__, or :ref:`write your own decorator <writing_decorators>`.
