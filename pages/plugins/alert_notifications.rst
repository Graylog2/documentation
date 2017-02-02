.. _alert_notifications:

*******************
Alert Notifications
*******************

Alert Notifications are responsible for sending information about alerts to external systems, such as sending an email, push notifications, opening tickets, writing to chat systems etc.

They receive the stream they were bound to as well as the result of the configured :ref:`alert_conditions`.

.. note::
  *Alert Notifications* were called *Alarm Callbacks* in previous versions of Graylog. 
   The old name is still used in the code and REST API endpoints for backwards compatibility, so you will see it when implementing your plugins.

Example Alarm Callback plugin
=============================

Let's assume you still want to build the mentioned JIRA AlarmCallback plugin. First open the ``JiraAlarmCallback.java`` file and let it implement
the ``AlarmCallback`` interface::

  public class JiraAlarmCallback implements AlarmCallback

Your IDE should offer you to create the methods you need to implement:

**public void initialize(Configuration configuration) throws AlarmCallbackConfigurationException**

This is called once at the very beginning of the lifecycle of this plugin. It is common practive to store the ``Configuration`` as a private member
for later access.

**public void call(Stream stream, AlertCondition.CheckResult checkResult) throws AlarmCallbackException**

This is the actual alarm callback being triggered. Implement your login that creates a JIRA ticket here.

**public ConfigurationRequest getRequestedConfiguration()**

Plugins can request configurations. The UI in the Graylog web interface is generated from this information and the filled out configuration values
are passed back to the plugin in ``initialize(Configuration configuration)``.

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

Return attributes that might be interesting to be shown under the alarm callback in the Graylog web interface. It is common practice to at least
return the used configuration here.

**public void checkConfiguration() throws ConfigurationException**

Throw a ``ConfigurationException`` if the user should have entered missing or invalid configuration parameters.

Registering the plugin
----------------------

.. _registering_alarm_callback:

You now have to register your plugin in the ``JiraAlarmCallbackModule.java`` file to make ``graylog-server`` load the alarm callback when launching. The
reason for the manual registering is that a plugin could consist of multiple plugin types. Think of the generated plugin file as a bundle of
multiple plugins.

Register your new plugin using the ``configure()`` method::

  @Override
  protected void configure() {
      addAlarmCallback(JiraAlarmCallback.class);
  }
