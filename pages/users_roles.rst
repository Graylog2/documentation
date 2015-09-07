***************
Users and Roles
***************

Graylog has a granular permission system which secures the access to its features. Each interaction which can look at
data or change configuration in Graylog must be performed as an authenticated user.

Each user can have varying levels of access to Graylog's features, which can be controlled with assigning roles to users.

The following sections describe the capabilities of users and roles.

User accounts
*************

It is recommended to create an account for each individual user accessing Graylog.

User accounts have the usual properties such as a login name, email address, full name, password etc.
In addition to these fields, you can also configure the session timeout, roles and timezone.

.. image:: /images/create_user.png

Sessions
========
Each login for a user creates a session, which is bound to the browser the user is currently using. Whenever the user
interacts with Graylog this session is extended.

For security reasons you will want to have Graylog expire sessions after a certain period of inactivity. Once the interval
specified by ``timeout`` expires the user will be logged out of the system. Requests like displaying throughput statistics
do not extend the session, which means that if the user keeps Graylog open in a browser tab, but does not interact with it,
their session will expire as if the browser was closed.

Logging out explicitly terminates the session.

Timezone
========
Since Graylog internally processes and stores messages in the UTC timezone, it is important to set the correct timezone for each
user.

Even though the system defaults are often enough to display correct times, in case your team is spread across different
timezones, each user can be assigned and change their respective timezone setting. You can find the current timezone settings
for the various components on the ``System / Overview`` page of your Graylog web interface.

Initial Roles
=============
Each user needs to be assigned at least one role, which governs the basic set of permissions this user has in Graylog.

Normal users, which do not need to create inputs, outputs or perform administrative tasks like managing access control etc,
should be assigned the built in ``Reader`` role in addition to the custom roles which grant access to streams and dashboards.

Roles
*****
In Graylog roles are named collections of individual permissions which can be assigned to users. Previous Graylog versions
could only assign individual permissions to each user in the system, making updating stream or dashboard permissions for
a large group of users difficult to deal with.

Starting in Graylog 1.2 you can create roles which bundle permissions to streams and dashboards. These roles can then
be assigned to any number of users and later be updated to include new streams and dashboards.

.. image:: /images/roles.png

The two roles ``Admin`` and ``Reader`` are built in and cannot be changed. The ``Admin`` role grants all permissions
and should only be assigned to users operating Graylog. The ``Reader`` role grants the basic permissions every user needs
to be able to use Graylog. The interface will ensure that every user at least has the ``Reader`` role in addition to
more business specific roles you create.

Roles cannot be deleted as long as users are still assigned to them, to prevent accidentally locking users out.

Create a role
=============
In order to create a new role, choose the green ``Add new role`` button on the ``System / Roles`` page.

This will display a dialog allowing you to describe the new role and select the permissions it grants.

.. image:: /images/create_role_1.png

After naming the role, select the permissions you want to grant using the buttons to the right of the respective stream
or dashboard names. For each stream or dashboard you can select whether to grant ``edit`` or ``read`` permissions, but
note that edit permissions always imply read permissions as well.

In case you have many streams or dashboards you can use the filter to narrow the list down, and use the checkboxes on the
left hand side of the table to select multiple items. You can then use the bulk action buttons on the right hand side
to toggle the permissions for all of the selected items at once.

.. image:: /images/create_role_2.png

Once you are done, be sure to save your changes. The save button is disabled until you select at least one permission.

Editing a role
==============
Administrators can edit roles to add or remove access to new streams and dashboards in the system. The two built in ``Admin``
and ``Reader`` roles cannot be edited or deleted because they are vital for Graylog's permission system.

Simply choose the ``edit`` button on the ``System / Roles`` page and change the settings of the role in the following page:

.. image:: /images/edit_role.png

You can safely rename the role as well as updating its description, the existing role assignment for users will be kept.

Deleting a role
===============
Deleting roles checks whether a role still has users assigned to it, to avoid accidentally locking users out.
If you want to remove a role, please remove it from all users first.