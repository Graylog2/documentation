.. _decorators:

****
Decorators
****

Decorators can be used to transform a message field value during searches.

They are typically used to map between the stored value and a human readable form of that value,
for example like the `Syslog severity mapper decorator <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/java/org/graylog2/decorators/SyslogSeverityMapperDecorator.java>`_ maps between numeric values and their textual respresentation.

Other uses include looking up user names based on a user's ID in a remote database, triggering a ``whois`` request on a domain name etc.

.. _writing_decorators:

Writing a decorator plugin
==========================

Writing a custom decorator is generally similar to the aforementioned alarm callback. After :ref:`creating_plugin_skeleton`, you need to implement a class implementing the ``SearchResponseDecorator`` interface. This class must:

  * Contain interfaces extending the ``SearchResponseDecorator.Factory``, ``SearchResponseDecorator.Config`` & ``SearchResponseDecorator.Descriptor`` interface
  * Implement a ``apply`` method, containing the actual logic of decorating a message

The ``Factory`` interface needs a bit more explanation. It works as a connection between the factory, config, description and actual implementation classes. It should look similar to this::

      public interface Factory extends SearchResponseDecorator.Factory {
        @Override
        YourMessageDecorator create(Decorator decorator);

        @Override
        YourMessageDecorator.Config getConfig();

        @Override
        YourMessageDecorator.Descriptor getDescriptor();
      }

In this example ``YourMessageDecorator`` is used as the base name for the class implementing a decorator.

Registering the plugin
----------------------

Registering the decorator works generally similar to the alarm callback :ref:`example <registering_alarm_callback>`, the helper method used to register a decorator has a different name and signature though. In general it works like this::

  @Override
  protected void configure() {
      installSearchResponseDecorator(searchResponseDecoratorBinder(),
                                     YourMessageDecorator.class,
                                     YourMessageDecorator.Factory.class);
  }


Writing the actual logic
------------------------

The actual logic of modifying the presentation of messages (or better: search results, as this is what a decorator is working on) is contained in the ``SearchResponseDecorator#apply`` method, which needs to be implemented.
It is called every time a search is performed and this specific decorator is configured for the stream it is performed on. It receives a ``SearchResponse`` object and also needs to return one, but is able to manipulate it during the runtime of the ``apply`` call.

A good example on how to write a decorator can be seen in the `source of the Syslog severity mapper decorator <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/java/org/graylog2/decorators/SyslogSeverityMapperDecorator.java>`_.
