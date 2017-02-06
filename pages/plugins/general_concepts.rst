.. _general_concepts_api:

API concepts
************

Graylog uses certain patterns in its code bases to make it easier to write extensions.
It is important to know about these to be successful in writing custom for it.

You can browse the Graylog `Javadoc documentation <https://javadoc.io/doc/org.graylog2/graylog2-server/2.2.0>`_ for details on each class and method mentioned here.

.. _concept_factory_api:

Factory Class
=============

Many newer Graylog extension points split the common aspects of custom code into three different classes:

* instance creation - an, usually inner, interface commonly called ``Factory``
* configuration - the factory returns a ``ConfigurationRequest`` instance (or a wrapped instance of it), commonly called ``Config``
* descriptor - the factory returns a display descriptor instance, commonly called ``Descriptor``

Say Graylog exposes an extension point interface called ``ExtensionPoint``, which contains inner interfaces calles ``Factory``, ``Config`` and ``Descriptor``.
An implementation of ``ExtensionPoint`` then looks as following:

.. code:: java

	public AwesomeExtension implements ExtensionPoint {
		
		public interface Factory extends ExtensionPoint.Factory {
			@Override
			AwesomeExtension create(Decorator decorator);

			@Override
			AwesomeExtension.Config getConfig();

			@Override
			AwesomeExtension.Descriptor getDescriptor();
		}
		
		public static class Config implements ExtensionPoint.Config {
			@Override
			public ConfigurationRequest getRequestedConfiguration() {
				return new ConfigurationRequest();
			}
		}

		public static class Descriptor extends ExtensionPoint.Descriptor {
			public Descriptor() {
				super("awesome", "http://docs.graylog.org/", "Awesome Extension");
			}
		}
	}

This pattern is used to prevent instantiation of extensions just to get their descriptor or configuration information, because some extensions might be expensive to set up or require some external service and configuration to work.

The factory itself is built using Guice's `assisted injection <https://github.com/google/guice/wiki/AssistedInject>`_ for auto-wired factories.
This allows plugin authors (and Graylog's internals as well) to cleanly describe their extension as well as taking advantage of dependency injection.

To register such an extension, Graylog typically offers a convenience method via its Guice modules (``GraylogModule`` or ``PluginModule``).
For example alert conditions follow the same pattern and are registered as such:

.. code:: java

	public class SampleModule extends PluginModule {
		// other methods omitted for clarity
		@Override
		protected void configure() {
			addAlertCondition(SampleAlertCondition.class.getCanonicalName(),
					SampleAlertCondition.class,
					SampleAlertCondition.Factory.class);
		}
	}
