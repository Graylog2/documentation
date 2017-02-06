.. _alert_conditions_api:

****************
Alert Conditions
****************

An alert condition determines whether an alert is triggered. The result of a condition is sent to an alert notification for sending to remote systems.

In Graylog alerting is based on searches and typically includes a list of messages that lead to the alert. However nothing prevents user code to query other systems than Elasticsearch to produce alerts.

Class Overview
==============

The central interface is ``org.graylog2.plugin.alarms.AlertCondition`` which is also the type that a plugin module must register using ``org.graylog2.plugin.PluginModule#addAlertCondition``.

Alert conditions are configurable at runtime and thus need a corresponding ``org.graylog2.plugin.configuration.ConfigurationRequest``.

Like many other types they also require a ``org.graylog2.plugin.alarms.AlertCondition.Descriptor`` for displaying information about the alert condition.

Typically you will not implement ``AlertCondition`` directly, but instead use ``org.graylog2.alerts.AbstractAlertCondition`` which handles the configuration persistence for you automatically and implements two helper to provide the result of a condition check.

Example
=======

Please refer to the sample `plugin implementation <https://github.com/Graylog2/graylog-plugin-sample/blob/2.2/src/main/java/org/graylog/plugins/sample/alerts/SampleAlertCondition.java>`_ for the full code.

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
        addAlertCondition(SampleAlertCondition.class.getCanonicalName(),
                SampleAlertCondition.class,
                SampleAlertCondition.Factory.class);
    }
  }

User Interface
==============

Alert conditions have no special user interface elements.
