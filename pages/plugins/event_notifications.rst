.. _event_notifications_api:

*******************
Event Notifications
*******************

Event Notifications are responsible for sending information about events to external systems, such as sending an email, push notifications, opening tickets, writing to chat systems etc.

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

