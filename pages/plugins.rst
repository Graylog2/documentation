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

.. _plugin_prerequisites:

Prerequisites
=============

What you need in your development environment before starting is:

  * `git <https://git-scm.com>`_
  * `maven <https://maven.apache.org>`_

There are lots of different ways to get those on your local machine, unfortunately we cannot list all of them, so please refer to your operating system-specific documentation,

.. _creating_plugin_skeleton:

Creating a plugin skeleton
==========================

The easiest way to get started is to use our `Graylog meta project <https://github.com/graylog2/graylog-project>`_,
which will create a complete plugin project infrastructure will all required classes, build definitions, and configurations. Using the meta project allows you to have the `Graylog server project <https://github.com/graylog2/graylog2-server>`_ and your own plugins (or 3rd party plugins) in the same project, which means that you can run and debug everything in your favorite IDE or navigate seamlessly in the code base.

Maven is a widely used build tool for Java, that comes pre-installed on many operating systems or can be installed using most package managers. Make sure that you have at least version 3 before you go on.

Use it like this::

  $ git clone git@github.com:Graylog2/graylog-project.git


This will create a checkout of the meta project in your current work dir. Now change to the ``graylog-project`` directory and execute the step which to download the necessary base modules::

  $ scripts/bootstrap


Now you can bootstrap the plugin you want to write from here, by doing::

  $ scripts/bootstrap-plugin jira-alarmcallback

It will ask you a few questions about the plugin you are planning to build. Let's say you work for a company called ACMECorp and want to build
an alarm callback plugin that creates a JIRA ticket for each alarm that is triggered::

  groupId: com.acmecorp
  version: 1.0.0
  package: com.acmecorp
  pluginClassName: JiraAlarmCallback

Note that you do not have to tell the archetype wizard what kind of plugin you want to build because it is creating the generic plugin
skeleton for you but nothing that is related to the actual implementation. More on this in the example plugin chapters later.

You now have a new folder called ``graylog-plugin-jira-alarmcallback`` that includes a complete plugin skeleton including Maven build files. Every Java IDE
out there can now import the project automatically without any required further configuration.

In `IntelliJ IDEA <https://www.jetbrains.com/idea/>`_ for example you can just use the *File -> Open* dialog to open the ``graylog-project`` directory as a fully configured Java project, which should include the Graylog server and your plugin as submodules.

Please pay close attention to the `README file <https://github.com/Graylog2/graylog-project/blob/master/README.md>`_ of the Graylog meta project and follow any further instructions listed there to set up your IDE properly.

If you want to continue working on the command line, you can do the following to compile the server and your plugin::

  $ mvn package


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


Creating a plugin for the web interface
=======================================

Sometimes your plugin is not only supposed to work under the hoods inside a Graylog server as an input, output, alarm callback, etc. but you also want to contribute previously nonexisting functionality to Graylog's web interface. Since version 2.0 this is now possible. When using the most recent `Graylog meta project <https://github.com/Graylog2/graylog-project>` to bootstrap the plugin skeleton, you are already good to go for this. Otherwise please see our chapter about :ref:`creating_plugin_skeleton`.

Graylog web plugins are bundles of mainly JavaScript files, but you can also include basically any file usable in your browser, that you want to use in your plugin, i.e. images, stylesheets, fonts, even audio or video files. During the build process all of these are assembled into modular chunks by `webpack <http://webpack.github.io>` and included in the jar file of your plugin.

Prerequisites
-------------

The Graylog web interface is written in JavaScript, based on `React <https://facebook.github.io/react/>`_. It is built using `webpack <http://webpack.github.io>`_, which is bundling all JavaScript code into chunks digestable by your browser and `NPM <https://www.npmjs.com>`_, which is managing our external (and own) dependencies. This might be overwhelming at first if you are not accustomed to JS-development, but fortunately we have set up a lot to make writing plugins easier for you!

If you use our proposed way for :ref:`creating_plugin_skeleton`, and followed the part about the :ref:`plugin_prerequisites`, you are already good to go for building a plugin with a web part. Everything else is fetched at build time!

Web Plugin structure
--------------------

These are the relevant files and directories in your plugin directory for the web part of it:

  webpack.config.js
    This is the configuration file for the `webpack <http://webpack.github.io>`_ module bundler. Most of it is already preconfigured by our ``PluginWebpackConfig`` class, so the file is very small. You can override/extend every configuration option by passing a webpack snippet though.
  
  build.config.js.sample
    In this file you can customize some of the parameters of the build. There is one mandatory parameter named ``web_src_path`` which defines the absolute or relative location to a checkout of the `Graylog source repository <https://github.com/Graylog2/graylog2-server>`_.

Building plugins
================

Building the plugin is easy because the archetype has created all necessary files and settings for you. Just run ``mvn package`` from the plugin
directory::

  $ mvn package

This will generate a ``.jar`` file in ``target/`` that is the complete plugin file::

  $ ls target/jira-alarmcallback-1.0.0-SNAPSHOT.jar
  target/jira-alarmcallback-1.0.0-SNAPSHOT.jar

.. _installing_and_loading_plugins:

Installing and loading plugins
==============================

The only thing you need to do to run the plugin in Graylog is to copy the ``.jar`` file to your plugins folder that is configured in your
``graylog.conf``. The default is just ``plugins/`` relative from your ``graylog-server`` directory.

Restart ``graylog-server`` and the plugin should be available to use from the web interface immediately.
