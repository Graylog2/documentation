.. _roles:

*****
Roles
*****

In Graylog, roles are named collections of individual permissions which can be assigned to users. Previous Graylog versions
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
In order to create a new role, choose the green *Add new role* button on the *System* -> *Roles* page.

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

Simply choose the *edit* button on the *System* -> *Roles* page and change the settings of the role in the following page:

.. image:: /images/edit_role.png

You can safely rename the role as well as updating its description, the existing role assignment for users will be kept.

Deleting a role
===============
Deleting roles checks whether a role still has users assigned to it, to avoid accidentally locking users out.
If you want to remove a role, please remove it from all users first.
