.. _plugins:

*******
Plugins
*******

General information
===================

Graylog comes with a stable plugin API for the following plugin types since Graylog 1.0:

* **Inputs:** Accept/write any messages into Graylog
* **Outputs:** Forward messages to other endpoints in real-time
* **Services:** Run at startup and able to implement any functionality
* **Alarm Callbacks:** Called when a stream alert condition has been triggered
* **Filters:** Transform/drop incoming messages during processing
* **REST API Resources:** A REST resource to expose as part of the ``graylog-server`` REST API
* **Periodical:** Called at periodical intervals during server runtime

The first step for writing a plugin is creating a skeleton that is the same for each type of plugin. The next chapter
is explaining how to do this and will then go over to chapters explaining plugin types in detail.

Creating a plugin skeleton
==========================

The easiest way to get started is to use our `maven archetype <http://maven.apache.org/guides/introduction/introduction-to-archetypes.html>`_
that will create a complete plugin project infrastructure will all required classes, build definitions, and configurations using an interactive wizard.

Maven is a Java widely used build tool that comes pre-installed on many operating systems or can be installed using most package managers. Make sure that it
is installed with at least version 3 before you go on.

Use it like this::

  $ mvn archetype:generate -DarchetypeGroupId=org.graylog -DarchetypeArtifactId=graylog-plugin-archetype

It wil ask you a few questions about the plugin you are planning to build. Let's say you work for a company called ACMECorp and want to build
an alarm callback plugin that creates a JIRA ticket for each alarm that is triggered::

  groupId: com.acmecorp
  artifactId: jira-alarmcallback
  version: 1.0.0
  package: com.acmecorp
  pluginClassName: JiraAlarmCallback

Note that you do not have to tell the archetype wizard what kind of plugin you want to build because it is creating the generic plugin
skeleton for you but nothing that is related to the actual implementation. More on this in the example plugin chapters later.

You now have a new folder called ``jira-alarmcallback`` that includes a complete plugin skeleton including Maven build files. Every Java IDE
out there can now import the project automatically without any required further configuration.

In `IntelliJ IDEA <https://www.jetbrains.com/idea/>`_ for example you can just use the *File -> Open* dialog to open the skeleton as a fully
configured Java project.

Change some default values
--------------------------

Open the ``JiraAlarmCallbackMetaData.java`` file and customize the default values like the plugin description, the website URI, and so on.
Especially the author name etc. should be changed.

Now go on with implementing the actual login in one of the example plugin chapters below.

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

You now have to register your plugin in the ``JiraAlarmCallbackModule.java`` file to make ``graylog-server`` load the alarm callback when launching. The
reason for the manual registering is that a plugin could consist of multiple plugin types. Think of the generated plugin file as a bundle of
multiple plugins.

Register your new plugin using the ``configure()`` method::

  @Override
  protected void configure() {
      addAlarmCallback(JiraAlarmCallback.class);
  }

Building plugins
================

Building the plugin is easy because the archetype has created all necessary files and settings for you. Just run ``mvn package`` from the plugin
directory::

  $ mvn package

This will generate a ``.jar`` file in ``target/`` that is the complete plugin file::

  $ ls target/jira-alarmcallback-1.0.0-SNAPSHOT.jar
  target/jira-alarmcallback-1.0.0-SNAPSHOT.jar

Installing and loading plugins
==============================

The only thing you need to do to run the plugin in Graylog is to copy the ``.jar`` file to your plugins folder that is configured in your
``graylog.conf``. The default is just ``plugins/`` relative from your ``graylog-server`` directory.

Restart ``graylog-server`` and the plugin should be available to use from the web interface immediately.
