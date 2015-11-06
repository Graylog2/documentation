***************
Users and Roles
***************

Graylog has a granular permission system which secures the access to its features. Each interaction which can look at
data or change configuration in Graylog must be performed as an authenticated user.

Each user can have varying levels of access to Graylog's features, which can be controlled with assigning roles to users.

The following sections describe the capabilities of users and roles **and also how to use LDAP for authentication**.

.. toctree::
   :titlesonly:

   users_and_roles/users
   users_and_roles/roles
   users_and_roles/system_users
   users_and_roles/external_auth
