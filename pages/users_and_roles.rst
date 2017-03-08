.. _usersandrolestoc:

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
   users_and_roles/permission_system
   users_and_roles/external_auth


Authentication providers
========================

Graylog 2.1.0 and later supports pluggable authentication providers. This means, that Graylog cannot only use the builtin authentication mechanisms like its internal user database, LDAP/Active Directory, or access tokens, but can also be extended by plugins to support other authentication mechanisms, for example Single Sign-On or Two Factor Authentication.

Configuration
-------------

The order in which the authentication providers will be queried can be configured in the Graylog web interface on the **System / Authentication / Configure Provider Order** page.

.. image:: /images/authentication_order_1.png

If a user tries to log into Graylog, the authentication providers will be queried in the configured order until a successful authentication attempt has been made (in which case the user will be logged in) or all authentication providers have denied authentication (in which case the user will not be logged in and get an error message).

By clicking on the **Update** button on the **System / Authentication / Configure Provider Order** page, the order of authentication providers can be customized.

.. image:: /images/authentication_order_2.png


