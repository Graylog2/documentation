.. _decorators_api:

**********
Decorators
**********

:ref:`decorators` can be used to transform a message field at display time. Multiple decorators can be applied at the same time, but you cannot make any assumptions about their order, as that is user defined. Stacked decorators receive the value of the previous decorator results.

They are typically used to map between the stored value and a human readable form of that value,
for example like the :ref:`syslog_severity_mapper` (compare its `code <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/java/org/graylog2/decorators/SyslogSeverityMapperDecorator.java>`_) maps between numeric values and their textual representation.

Other uses include looking up user names based on a user's ID in a remote database, triggering a ``whois`` request on a domain name etc.

.. _writing_decorators:

Class Overview
==============

You need to implement the ``org.graylog2.plugin.decorators.SearchResponseDecorator`` interface. This class must declare a :ref:`concept_factory_api`.

Beyond the factory, configuration and descriptor classes, the only thing that a decorator needs to implement is the ``apply`` function:

.. code:: java

	SearchResponse apply(SearchResponse searchResponse);

The ``org.graylog2.rest.resources.search.responses.SearchResponse`` class represents the result that is being returned to the web interface (or other callers of the REST API).

You are free to modify any field, create new fields or remove fields. However, the web interface makes certain assumptions regarding fields that start with ``gl2_`` and requires at least the ``timestamp``, ``source`` and ``message`` fields to be present.

Thrown exceptions are being logged as errors and lead to returning the original search response, without any modifications.

Example
=======

Please refer to the sample `plugin implementation <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/decorator/SampleDecorator.java>`_ for the full code.

Bindings
========

Compare with the code in the `sample plugin <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/SampleModule.java>`_.

.. code:: java

  public class SampleModule extends PluginModule {

    @Override
    public Set<? extends PluginConfigBean> getConfigBeans() {
        return Collections.emptySet();
    }

    @Override
    protected void configure() {
      installSearchResponseDecorator(searchResponseDecoratorBinder(),
                      PipelineProcessorMessageDecorator.class,
                      PipelineProcessorMessageDecorator.Factory.class);
    }
  }

User Interface
==============

Decorators have no custom user interface elements.
