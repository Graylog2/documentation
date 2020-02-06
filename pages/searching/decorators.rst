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

In order to apply decorators to your search results, click on the *Decorators* tab in your search sidebar, select the decorator you want
to apply from the dropdown, and click on *Apply*. Once you save your changes, the search results will already contain the decorated values.

.. image:: /images/searching/create_decorator.png

When you apply multiple decorators to the same search results, you can change the order in which they are applied at any time by using
drag and drop in the decorator list.

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
The pipeline decorator provides a way to decorate messages by processing them with an existing :doc:`processing pipeline <pipelines>`.
In contrast to using a processing pipeline, changes done to the message by the pipeline are not persisted. Instead, the pipeline is used at search time
to modify the *presentation* of the message.

The prerequisite of using the pipeline decorator is that an existing pipeline is required.

.. note:: Please take note, that the pipeline you use for decoration should not be connected to a stream. This would mean that it is run twice (during indexing *and* search time) for each message, effectively rendering the second run useless.

When you are done creating a pipeline, you can now add a decorator using it on any number of streams. In order to create one, you proceed just like for
any other decorator type, by clicking on the *Decorator* sidebar, selecting the type ("Pipeline Processor Decorator" in this case) and clicking the *Apply* button next to one.

.. image:: /images/searching/pipeline_decorator_select_type.png

Upon clicking *Apply*, the pipeline to be used for decorating can be selected.

.. image:: /images/searching/pipeline_decorator_select_pipeline.png

After selecting a pipeline and clicking *Save*, you are already set creating a new pipeline decorator.

Debugging decorators
^^^^^^^^^^^^^^^^^^^^

When a message is not decorated as expected, or you need to know how it looked like originally, you can see all changes that were done during decoration by clicking "Show changes" in the message details.

.. image:: /images/searching/pipeline_decorator_show_changes.png

In this view, deleted content is shown in red, while added content is shown in green. This means that added fields will have a single green entry, removed fields a single red entry and modified fields will have two entries, a red and a green one.

Further functionality
^^^^^^^^^^^^^^^^^^^^^

If the existing decorators are not sufficient for your needs, you can either search the `Graylog marketplace <http://marketplace.graylog.org>`__, or :ref:`write your own decorator <writing_decorators>`.
