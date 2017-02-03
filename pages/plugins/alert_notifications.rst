.. _alert_notifications_api:

*******************
Alert Notifications
*******************

Alert Notifications are responsible for sending information about alerts to external systems, such as sending an email, push notifications, opening tickets, writing to chat systems etc.

They receive the stream they were bound to as well as the result of the configured :ref:`alert_conditions_api`.

.. note:: Alert Notifications were called Alarm Callbacks in previous versions of Graylog. 

  The old name is still used in the code and REST API endpoints for backwards compatibility, so you will see it when implementing your plugins.

Class Overview
==============

The interface to implement is ``org.graylog2.plugin.alarms.callbacks.AlarmCallback`` which is also the type that a plugin module must register using ``org.graylog2.plugin.PluginModule#addAlarmCallback``.

Example Alert Notification
==========================

You can find a `minimal implementation in the sample plugin <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/alerts/SampleAlertNotification.java>`_.

To create an alert notification plugin implement the ``AlarmCallback`` interface interface::

  public class SampleAlertNotification implements AlarmCallback

Your IDE should offer you to create the methods you need to implement:

**public void initialize(Configuration configuration) throws AlarmCallbackConfigurationException**

This is called once at the very beginning of the lifecycle of this plugin. It is common practice to store the ``Configuration`` as a private member
for later access.

**public void call(Stream stream, AlertCondition.CheckResult checkResult) throws AlarmCallbackException**

This is the actual alert notification being triggered. Implement your login that interacts with a remote system here, for example sending a push notification, posts into a chat system etc.

**public ConfigurationRequest getRequestedConfiguration()**

Plugins can request configurations. The UI in the Graylog web interface is generated from this information and the filled out configuration values
are passed back to the plugin in ``initialize(Configuration configuration)``.

The return value must not be ``null``.

This is an example configuration request::

  final ConfigurationRequest configurationRequest = new ConfigurationRequest();
  configurationRequest.addField(new TextField(
          "service_key", "Service key", "", "JIRA API token. You can find this token in your account settings.",
          ConfigurationField.Optional.NOT_OPTIONAL)); // required, must be filled out
  configurationRequest.addField(new BooleanField(
          "use_https", "HTTPs", true,
          "Use HTTP for API communication?"));

**public String getName()**

Return a human readable name of this plugin.

**public Map<String, Object> getAttributes()**

Return attributes that might be interesting to be shown under the alert notification in the Graylog web interface. It is common practice to at least
return the used configuration here.

**public void checkConfiguration() throws ConfigurationException**

Throw a ``ConfigurationException`` if the user should have entered missing or invalid configuration parameters.

.. caution:: The alert notification may be created multiple times, so be sure to not perform business logic in the constructor.

  You should however inject custom dependencies, such as a specific client library or other objects in the constructor.

Bindings
========

.. _registering_alarm_callback:

Compare with the code in the `sample plugin <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/SampleModule.java>`_.

.. code:: java

	public class SampleModule extends PluginModule {

		@Override
		public Set<? extends PluginConfigBean> getConfigBeans() {
			return Collections.emptySet();
		}

		@Override
		protected void configure() {
			addAlarmCallback(SampleAlertNotification.class);
		}
	}

User Interface
==============

Alert notifications have no custom user interface elements.
