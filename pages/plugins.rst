.. _plugins:

*******
Plugins
*******

About Plugins
=============
Graylog offers various extension points to customize and extend its functionality through writing Java code.

The first step for writing a plugin is creating a skeleton that is the same for each type of plugin. The next chapter
is explaining how to do this and will then go over to chapters explaining plugin types in detail.

.. _plugin_types:

Plugin Types
============

Graylog comes with a stable plugin API for the following plugin types:

  * **Inputs:** Accept/write any messages into Graylog
  * **Outputs:** Forward ingested messages to other systems as they are processed
  * **Services:** Run at startup and able to implement any functionality
  * :ref:`alert_conditions_api`: Decide whether an alert will be triggered depending on a condition
  * :ref:`alert_notifications_api`: Called when a stream alert condition has been triggered
  * **Processors:** Transform/drop incoming messages (can create multiple new messages)
  * **Filters:** (Deprecated) Transform/drop incoming messages during processing
  * **REST API Resources:** An HTTP resource exposed as part of the Graylog REST API
  * **Periodical:** Called at periodical intervals during server runtime
  * :ref:`decorators_api`: Used during search time to modify the presentation of messages
  * **Authentication Realms**: Allowing to implement different authentication mechanisms (like single sign-on or 2FA)

.. toctree::
   :hidden:

   plugins/general_concepts
   plugins/alert_conditions
   plugins/alert_notifications
   plugins/decorators

.. _plugin_prerequisites:

Writing Plugins
===============

What you need in your development environment before starting is:

  * `git <https://git-scm.com>`_
  * `maven <https://maven.apache.org>`_

There are lots of different ways to get those on your local machine, unfortunately we cannot list all of them, so please refer to your operating system-specific documentation,

Graylog uses a couple of conventions and techniques in its code, so be sure to read about the :ref:`general_concepts_api` for an overview.

.. _sample_plugin:

Sample Plugin
-------------

To go along with this documentation, there is a `sample plugin on Github <https://github.com/Graylog2/graylog-plugin-sample/tree/2.2>`_. This documentation will link to specific parts for your reference.
It is fully functional, even though it does not implement any useful functionality. Its purpose to provide a reference for helping to implement your own plugins.

.. _creating_plugin_skeleton:

Creating a plugin skeleton
--------------------------

The easiest way to get started is to use our `Graylog meta project <https://github.com/Graylog2/graylog-project>`_,
which will create a complete plugin project infrastructure will all required classes, build definitions, and configurations. Using the meta project allows you to have the `Graylog server project <https://github.com/graylog2/graylog2-server>`_ and your own plugins (or 3rd party plugins) in the same project, which means that you can run and debug everything in your favorite IDE or navigate seamlessly in the code base.

.. note:: We are working on a replacement tool for the ``graylog-project`` meta project, but for the time being it still works.

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


The anatomy of a plugin
-----------------------

Each plugin contains information to describe itself and register the extensions it contains.

.. note:: A single plugin can contain multiple extensions to Graylog.
  
  For example a hypothetical plugin might contribute an input, an output and alert notifications to communicate with systems. For convenience this would be bundled in a single plugin registering multiple extensions.

Required classes
................

At the very minimum you need to implement two interfaces:

  * ``org.graylog2.plugin.Plugin`` - which is the entry to your `plugin <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/SamplePlugin.java>`_ code
  * ``org.graylog2.plugin.PluginMetaData`` - which `describes your plugin <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/SampleMetaData.java>`_

The ``bootstrap-plugin`` script generates these implementations for you, and you simply need to fill out the details.

Graylog uses Java's `ServiceLoader <https://docs.oracle.com/javase/8/docs/api/java/util/ServiceLoader.html>`_ mechanism to find your plugin's main class, so if you rename your ``Plugin`` implementation, you need to also adjust the `service file <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/resources/META-INF/services/org.graylog2.plugin.Plugin>`_.
Please also see Google Guava's `AutoService <https://github.com/google/auto/tree/master/service>`_ which Graylog uses in conjunction with the plain ServiceLoader.

In addition to the service, Graylog needs an additional resource file called ``graylog-plugin.properties`` in a special location. This file contains information about the plugin, specifically which classloader the plugin needs to be in, so it needs to be read before the plugin is actually loaded.
Typically you can simply take the default that has been `generated for you <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/resources/org.graylog.plugins.graylog-plugin-sample/graylog-plugin.properties>`_.

Registering your extension
..........................

So far the plugin itself does not do anything, because it neither implements any of the available extensions, nor could Graylog know which ones are available from your code.

Graylog uses `dependency injection <https://github.com/google/guice>`_ to wire up its internal components as well as the plugins. Thus the extensions a plugin provides need to be exposed as a `PluginModule <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-server/src/main/java/org/graylog2/plugin/PluginModule.java>`_ which provides you with a lot of helper methods to register the various available extensions to cut down the boiler plate code you have to write.

An `empty module <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/SampleModule.java>`_ is created for you.

.. caution:: The ``PluginModule`` exposes a lot of extension points, but not all of them are considered stable API for external use.

  If in doubt, please reach out to us on our `community support channels <https://www.graylog.org/community-support>`_.

Please refer to the available :ref:`plugin_types` for detailed information what you can implement. The :ref:`sample_plugin` contains stub implementations for each of the supported extensions.

Web Plugin creation
...................

Sometimes your plugin is not only supposed to work under the hoods inside a Graylog server as an input, output, alarm callback, etc. but you also want to contribute previously nonexisting functionality to Graylog's web interface. Since version 2.0 this is now possible. When using the most recent `Graylog meta project <https://github.com/Graylog2/graylog-project>`_ to bootstrap the plugin skeleton, you are already good to go for this. Otherwise please see our chapter about :ref:`creating_plugin_skeleton`.

The Graylog web interface is written in JavaScript, based on `React <https://facebook.github.io/react/>`_. It is built using `webpack <http://webpack.github.io>`_, which is bundling all JavaScript code (and other files you use, like stylesheets, fonts, images, even audio or video files if you need them) into chunks digestible by your browser and npm_, which is managing our external (and own) dependencies. During the build process all of this will be bundled and included in the jar file of your plugin.

This might be overwhelming at first if you are not accustomed to JS-development, but fortunately we have set up a lot to make writing plugins easier for you!

If you use our proposed way for :ref:`creating_plugin_skeleton`, and followed the part about the :ref:`plugin_prerequisites`, you are already good to go for building a plugin with a web part. **All you need is a running Graylog server on your machine.** Everything else is fetched at build time!

Getting up and running with a web development environment is as easy as this::

  $ scripts/start-web-dev
  [...]
  $ open http://localhost:8080


This starts the development web server. It even tries to open a browser window going to it (probably working on Mac OS X only).

If your Graylog server is not running on ``http://localhost:9000/api/``, then you need to edit ``graylog2-server/graylog2-web-interface/config.js`` (in your ``graylog-project`` directory) and adapt the ``gl2ServerUrl`` parameter.

Web Plugin structure
....................

These are the relevant files and directories in your plugin directory for the web part of it:

  webpack.config.js
    This is the configuration file for the `webpack <http://webpack.github.io>`_ module bundler. Most of it is already preconfigured by our ``PluginWebpackConfig`` class, so the file is very small. You can override/extend every configuration option by passing a webpack snippet though.
  
  build.config.js.sample
    In this file you can customize some of the parameters of the build. There is one mandatory parameter named ``web_src_path`` which defines the absolute or relative location to a checkout of the `Graylog source repository <https://github.com/Graylog2/graylog2-server>`_.

  package.json
    This is a standard npm_ JSON file describing the web part of your plugin, especially its dependencies. You can read more about its `format <https://docs.npmjs.com/files/package.json>`_.

  src/web
    This is where the actual code for thw web part of your plugin goes to. For the start there is a simple ``index.jsx`` file, which shows you how to register your plugin and the parts it provides with the Graylog web interface. We will get to this in detail later.


Required conventions for web plugins
------------------------------------

Plugin Entrypoint
.................

There is a single file which is the entry point of your plugin, which means that the execution of your plugin starts there. By convention this is `src/web/index.jsx`. You can rename/move this file, you just have to adapt your webpack configuration to reflect this change, but it is not recommended.

In any case, this file needs to contain the following code at the very top::

    // eslint-disable-next-line no-unused-vars
    import webpackEntry from 'webpack-entry';

This part is responsible to include and execute the `webpack-entry <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-web-interface/src/webpack-entry.js>`_ file, which is responsible to set up webpack to use the correct URL format when loading assets for this plugin. If you leave this out, erratic behavior will be the result.

Linking to other pages from your plugin
.......................................

If you want to generate links from the web frontend to other pages of your plugin or the main web interface, you need to use the ``Routes.pluginRoute()`` helper method to generate the URLs properly.

See `this file <https://github.com/Graylog2/graylog2-server/blob/master/graylog2-web-interface/src/routing/Routes.jsx#L5-L20>`_ for more information.

Best practices for web plugin development
-----------------------------------------

Using ESLint
............

`ESLint <http://eslint.org>`_ is an awesome tool for linting JavaScript code. It makes sure that any written code is in line with general best practises and the project-specific coding style/guideline. We at Graylog are striving to make the best use of this tools as possible, to help our developers and you to generate top quality code with little bugs. Therefore we highly recommend to enable it for a Graylog plugin you are writing.

Code Splitting
..............

Both the web interface and plugins for it depend on a number of libraries like React, RefluxJS and others. To prevent those getting bundled into *both* the web interface *and* plugin assets, therefore wasting space or causing problems (especially React does not like to be present more than once), we extract those into a commons chunk which is reused by the web interface and plugins.

This has no consequences for you as a plugin author, because the configuration to make use of this is already generated for you when using the meta project or the maven archetype. But here are some details about it:

Common libraries are built into a separate ``vendor`` bundle using an own configuration file named `webpack.vendor.js <https://github.com/Graylog2/graylog2-server/blob/2.1/graylog2-web-interface/webpack.vendor.js>`_. Using the `DLLPlugin <https://github.com/webpack/docs/wiki/list-of-plugins>`_ a `manifest is extracted <https://github.com/Graylog2/graylog2-server/blob/2.1/graylog2-web-interface/webpack.vendor.js#L30-L33>`_ which allow us to reuse the generated bundle. This is then imported in our main `web interface webpack configuration file <https://github.com/Graylog2/graylog2-server/blob/2.1/graylog2-web-interface/webpack.config.js#L48>`_ and the corresponding `generated webpack config file for plugins <https://github.com/Graylog2/graylog-web-plugin/blob/master/src/PluginWebpackConfig.js#L45>`_.

Building plugins
----------------

Building the plugin is easy because the meta project has created all necessary files and settings for you. Just run ``mvn package`` either from the meta project's directory (to build the server *and* the plugin) or from the plugin
directory (to build the plugin only)::

  $ mvn package

This will generate a ``.jar`` file in ``target/`` that is the complete plugin file::

  $ ls target/jira-alarmcallback-1.0.0-SNAPSHOT.jar
  target/jira-alarmcallback-1.0.0-SNAPSHOT.jar

.. _installing_and_loading_plugins:

Installing and loading plugins
==============================

The only thing you need to do to run the plugin in Graylog is to copy the ``.jar`` file to your plugins folder that is configured in your
``graylog.conf``. The default is just ``plugins/`` relative from your ``graylog-server`` directory.

This is a list of default plugin locations for the different installation methods.

.. include:: /includes/plugin-installation-locations.rst

Restart ``graylog-server`` and the plugin should be available to use from the web interface immediately.


.. _npm: http://npmjs.com
