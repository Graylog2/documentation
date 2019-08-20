.. _event_notifications_api:

*******************
Event Notifications
*******************

Event Notifications are responsible for sending information about events to external systems, such as sending an email, push notifications, opening tickets, writing to chat systems, etc.

They receive the event they were triggered for as well as a context object with additional metadata. Each notification consists of two classes. A configuration class, keeping parameters for the notification, and a second class with the actual notification code.

Class Overview
==============

The interfaces to implement are ``org.graylog.events.notifications.EventNotificationConfig`` and ``org.graylog.events.notifications.EventNotification``. Both classes are used to register a new notification type via the ``PluginModule`` class::

  addNotificationType(TYPE_NAME,
                      EventNotificationConfig.class,
                      EventNotification.class,
                      EventNotification.Factory.class);

Example Event Notification
==========================

You can use the build-in notifications as full examples one for a `configuration class <https://github.com/Graylog2/graylog2-server/blob/3.1/graylog2-server/src/main/java/org/graylog/events/notifications/types/HTTPEventNotificationConfig.java>`_,
and one for a `notification class <https://github.com/Graylog2/graylog2-server/blob/3.1/graylog2-server/src/main/java/org/graylog/events/notifications/types/HTTPEventNotification.java>`_.

To create an event notification plugin start by implementing the ``EventNotificationConfig`` interface::

  public abstract class HTTPEventNotificationConfig implements EventNotificationConfig

Every notification has a unique type name. Usually a string apended by a version number, e.g.::

  public static final String TYPE_NAME = "http-notification-v1"

Continue with the parameters which are needed for the notification. For example for a HTTP notification an URL is needed::

  private static final String FIELD_URL = "url";

  @JsonProperty(FIELD_URL)
  public abstract String url();

A Builder for the configuration class is needed::

  public static Builder builder() {
        return Builder.create();
  }

  @AutoValue.Builder
  public static abstract class Builder implements EventNotificationConfig.Builder<Builder> {
    @JsonCreator
    public static Builder create() {
      return new AutoValue_HTTPEventNotificationConfig.Builder()
                                                      .type(TYPE_NAME);
      }

      @JsonProperty(FIELD_URL)
      public abstract Builder url(String url);

      public abstract HTTPEventNotificationConfig build();
  }

Additionally interface methods are to implement:

**public JobTriggerData toJobTriggerData(EventDto dto)**

This is called when the scheduler executes the notification and is gathering data for the job.

**public ValidationResult validate()**

On the API level, inputs should be validated, put the checks here.

**public EventNotificationConfigEntity toContentPackEntity(EntityDescriptorIds entityDescriptorIds)**

If content-pack support is desired this methode is called to transfer a notification to a content pack entity.

Take a look at the examples for more details on this.

After creating the configuration class the actual notification code can be written. This is done by implementing the ``EventNotification`` interface in a new class::

  public class HTTPEventNotification implements EventNotification

There is just a single methode to override. The notification logic goes into ``execute(EventNotificationContext ctx)``.

The context object is keeping data about the event that lead to the notification, see `this class <https://github.com/Graylog2/graylog2-server/blob/3.1/graylog2-server/src/main/java/org/graylog/events/notifications/EventNotificationContext.java>`_ for more informations.

For getting a backlog of messages which were the source of the event itself a service is provided::

  ImmutableList<MessageSummary> backlog = notificationCallbackService.getBacklogForEvent(ctx)

User Interface
==============

Event Notifications need to provide some UI components that let the user enter Notification details in a form,
and also display a summary of the Notification in the Event Definition summary.

First of all, Event Notifications need to register a plugin for ``eventNotificationTypes``. As an example, we will
show the definition of the HTTP Notification type::

  eventNotificationTypes: [
    {
      type: 'http-notification-v1',
      displayName: 'HTTP Notification',
      formComponent: HttpNotificationForm,
      summaryComponent: HttpNotificationSummary,
      defaultConfig: {
          url: '',
      },
    }
  ]

Here is a description of each field the Notification needs to provide:

- ``type`` Unique type identifying the Notification. You should use the same type as used in the server class
- ``displayName`` Human readable short name that describes the Notification. It will be used in select inputs
- ``formComponent`` React component providing the form elements the user should fill in order to create the Event Notification
- ``defaultConfig`` Object including the default configuration that is used once the Notification type is selected.
  We recommend defining the default configuration in your ``formComponent`` and then simply add a reference to it here
- ``summaryComponent`` React component displaying a summary of the Event Notification

In order to help you write the required React components, we now describe what props they will receive and what is expected from the given components.

Form component
--------------

This component should present inputs that need to be filled out in order to configure the Event Notification. The component will receive the following
props::

  config: PropTypes.object
  onChange: PropTypes.func
  validation: PropTypes.object

- ``config`` Contains the current configuration the user gave for the Notification. This will be set by default to the object given as ``defaultConfig`` in
  the plugin definition
- ``onChange`` Function to call when an input changes. The function expects to receive the complete configuration object as first argument. Please remember
  you should not directly modify the ``config`` prop, but instead clone the object first and apply modifications there
- ``validation`` Contains an object with validation information. The object has the following structure::

    validation: {
      errors: {
        url: [
          "HTTP Notification URL cannot be empty."
        ],
      },
      failed: true
    }

With that, once the user is done configuring the Event Notification, Graylog will submit the defined configuration into the server and create the Event Notification.

Summary component
-----------------

This component should render a summary of all options configured in the Event Notification. It will be displayed in the summary step of the Event Definition form.
The component receives the following props::

  type: PropTypes.string,
  notification: PropTypes.object,
  definitionNotification: PropTypes.object,

- ``type`` Contains the ``displayName`` property defined in the Notification plugin
- ``notification`` Contains the Notification object, including its configuration
- ``definitionNotification`` Contains the ``notification_id`` used by the Event Definition. This is only required in case the Notification plugin is not installed or was deleted

In order to follow the same style as other Notifications in the summary component, we highly recommend using the ``CommonNotificationSummary`` component to render all
common properties all Notifications have: title, type, description, and the children you pass. The component receives the same props as this one, plus the children you want to
render with the custom plugin configuration. As an example, this is how the HttpNotificationSummary renders its summary::

  <CommonNotificationSummary {...this.props}>
    <React.Fragment>
      <tr>
        <td>URL</td>
        <td><code>{notification.config.url}</code></td>
      </tr>
    </React.Fragment>
  </CommonNotificationSummary>

