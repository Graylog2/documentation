.. _permissions:

*********************
Permission Management
*********************

Graylog 4.0 introduced a completely new way of assigning permissions to users. The new version splits up the various sections of the permission and authentication system:

.. image:: /images/permissions/permissions_05.png

There are five different parts to it:

* Authentication
* Users
* Roles
* Teams
* Sharing

Teams and Sharing provides organizations with large user groups and multiple teams accessing Graylog to manage their own content on a day-to-day basis more efficiently. By giving individual teams and users control over their own content needs, these features reduce the time administrators spend responding to access and dashboard requests.

First, Graylog syncs with your organization’s authoritative identity source, such as Active Directory or Okta, so that users are automatically provisioned into Graylog with the appropriate rights and permissions.  Then, Graylog auto-populates access using the current roles and AD groups, reflecting the organizational permissions structure. However, organizations can still manually manage access and permissions if necessary.

Second, Graylog Enterprise users can create Teams that can be easily found through a natural language search. For example, you can create teams such as “Security Team,” making it easier to find users with similar data needs. Graylog Enterprise leverages your authoritative identity source to populate Teams. The Teams functionality allows you to separate users into smaller groups within the organization, containing dashboards and reports to those assigned Teams and reducing informational noise generated from an excess of reports.

For smaller teams, the lack of Group Mapping has little impact. Group Mapping and Teams primarily prevent an overabundance of reports showing up in Users’ streams and dashboards. For smaller organizations using Open Source, removing this functionality has little impact. For Enterprise customers, Group Mapping and Teams enables them to reduce the proliferation of reports across all users, confining information to those who need it, reducing noise, and enhancing security.

You can choose to have lists of users, groups, or a combination of both. The global setting capabilities enable Admins to limit who views data more precisely, ultimately mitigating privacy risk.

Authentication
--------------

Graylog had pluggable authentication providers for a long time, but we have updated them for 4.0. In 4.0 only one external authentication provider can be active. We have removed the UI around changing the order these providers run, as there was practically no usage of this feature and it made reasoning about what happened in the background very difficult for the user.

Both LDAP and Active Directory continue to be available out of the box for Graylog Open Source and we have no plans on changing this. We believe that user access control is an essential feature of a logging solution.
We have also added the “trusted HTTP header” authentication method to Graylog. This feature, in conjunction with a proxy server, is sometimes used to enable authentication providers that Graylog does not have support for, such as keycard systems, Kerberos, and others.

Both LDAP and Active Directory now support the synchronization of teams. Because teams are only available in Graylog Enterprise, the Open Source product no longer has Group Mapping.


In Enterprise Graylog will synchronize chosen LDAP/AD groups to teams when an authentication service is activated.
Graylog will then keep the team members up to date as they log into the system.

.. image:: /images/permissions/permissions_06.png

Teams created in this way cannot be manually managed in Graylog, they have to be managed in the original identity provider. This means you cannot add or remove members from the team, but you can (and should) configure the roles the team brings with it.

Users
-----

The User section is slightly rearranged, but overall contains the same information and capability.

.. image:: /images/permissions/permissions_07.png

There is a new user view screen, that was not present in earlier versions. It shows basic profile information, the assigned roles, team membership for this user, and the “entities” that the user has been granted access to. Entities are things like Streams, Saved Searches, Dashboards, Alert Definitions, and Notifications.

.. image:: /images/permissions/permissions_08.png

The corresponding “Edit User” screen contains the same information but allows changes to profile information according to the permissions the user has (e.g. they cannot add themselves to arbitrary groups etc). This is basically identical to the behavior in 3.3, just with a rearranged UI.

Administrative User
^^^^^^^^^^^^^^^^^^^

Administrative users can set up all access in a single location. The ability to share information is extended to all system entities.

When Admins navigate to the System menu, they can see “Users and Teams.” The default setting for Users is the most basic permission assignment, “Reader,” unless your identity source defines their access otherwise. “Readers” typically cannot see Dashboards or Streams unless their role in Graylog allows it.

The syncing functionality from your identity source to Graylog streamlines the user access provisioning process for a seamless experience. Once your Admin aligns an AD role to a Graylog role, users immediately gain access to streams, which allows them to get started using Search and Dashboard capabilities immediately.

Standard Users
^^^^^^^^^^^^^^

Standard Users now have three types of permissions. Admins are the only users who can create streams and also provide other users with Owner, Manager, or Viewer level access. Admins have three access levels from which to choose:

* Viewer provides read-only access, allowing users to see the messages in the stream.
* Manager enables the user to change user roles and change Team descriptions.
* Owner allows a user to manage access control for the Streams, dashboards, event definitions, and searches.

These access levels align with Roles, Teams, and Sharing capabilities in 4.0.

Roles
-----

In 4.0,  Roles  have a more central position. While Graylog still has some of the same Roles, such as Administrator and Reader, it also includes some new ones. Since roles no longer contain information about which access is granted, it makes no sense to map LDAP/AD groups to them, and without Teams, there is no way to automatically group users.

Starting in 4.0, roles in general only describe capabilities. For example, you can now assign Roles like “Create Dashboard,” “Create Event Definitions,” and “Create Event Notifications.” These Roles are now actions that users can take within Graylog. This permission system is based on grants, like in a database, where it records access to entities based on user access levels. This shift enhances an organization’s security posture by enabling organizations to limit access more precisely within the Graylog platform, reducing excess access risk.

Additionally, since Graylog 4.0 now supports “sharing” functionality, granting access to streams and dashboards is no longer part of the “edit Roles” capability. Standard out-of-the-box roles are:

* Admin
* Alerts Manager
* Archive Manager
* Archive Viewer
* Dashboard Creator
* Event Definition Creator
* Event Notification Creator
* Reader
* Report Creator
* Report Manager

With Graylog 4.0, Roles no longer define what entities a user can see, but the types of actions they can take. With this update, organizations no longer have the need or ability to make customer roles through the platform although they can set up API calls for specific needs.

For organizations upgrading from Open Source to Enterprise, Graylog will look at each user’s capabilities and access levels then migrate that going forward into 4.0.

.. image:: /images/permissions/permissions_09.png

The information which specific entity a user or team has access to is managed through “sharing” on the entity itself, not through a role.

As an example, in earlier versions of Graylog, to give access to a stream containing windows logs and the corresponding dashboard visualizing them, an administrator had to create a role:
“Windows Logs”, having “Stream Windows Logs” as “Allow Reading”, and “Dashboard Windows Logs” as “Allow Reading”. This role was then assigned to a user, either manually or via a group mapping.

In 4.0, there is no special role necessary for this access. Instead, the Administrator grants access to the stream, and either the Administrator or another owner of the dashboard shares access to the entities with a specific user or team. For most of the process, the user sharing the access does not have to have administrator-level access.

Roles now only govern what actions someone can take, but do not themselves state on which entities these actions can take place. The latter is done through the sharing dialog. (see the later section for details)

In 4.0 the UI does not allow defining new roles, even though this is still possible through the API. As there is much less need to create custom roles, we believe this is acceptable initially, but we plan on making custom roles possible in future releases.

Providing Dashboard Creation Access
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Before users can create their own Dashboards, you need to provide them the appropriate level of access.

Under the “System” dropdown menu located in the top menu, click on the “Users and Teams” option. Choose the User record that you want to update.

.. image:: /images/permissions/permissions_10.png

In the “Assign Roles” menu, you can change the individual user’s permissions to better align with their job function. In this case, the user, Alice, needs to be able to create Dashboards. Click on “Dashboard Creator,” then click “Assign Role.” Graylog automatically updates the user’s account, granting the necessary access immediately.

.. image:: /images/permissions/permissions_11.png

After providing “Dashboard Creator” access to users, they will be able to see the “Create a Dashboard” button on the upper right-hand side of their Dashboards view.

.. image:: /images/permissions/permissions_12.png

**Example:** Manually Granting Access Permissions

“Alice” is on the Security Team. However, before being added to a Team in Graylog, she has no access to Streams or Dashboards.

Alice’s User View before providing her access looks like this:

.. image:: /images/permissions/permissions_13.png

As a member of the Security Team, Alice needs access to email logs. As an Admin, you can go into Graylog, select the Security Team, and then select the appropriate level of access.

Teams
-----

Teams join users and roles together.
Users can be in any number of teams, from zero to multiple teams. Each team can be assigned any number of roles, from zero to multiple many roles, which are added to the team’s members when checking for permissions.

Currently, team management requires an Administrator account. Now that Roles have transitioned to defining capabilities, Administrators can use Teams as a way to provide Roles to multiple users at once, rather than providing the capabilities individually. For large organizations, this reduces the amount of time spent managing individual user access.

The primary benefit Teams brings is the ability to segregate data visibility according to need and

Creating a team requires minimal information about it and allows assigning roles and members directly:

.. image:: /images/permissions/permissions_15.png

For example, if an organization has 10 Teams with 5 people on each Team, the Administrator can change Roles in bulk rather than having to manage all 55 users individually. Additionally, Administrators spend less time focusing on Role and Permissions within Graylog as they can apply unique sets of Roles to each Team without worrying that one User will have too much or too little access to engage in their job function.

AD/LDAP Synchronization with Teams
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enterprise organizations can leverage AD/LDAP synchronization, using their authoritative identity source to populate Teams. When a new user is added to the identity source of record, that user is automatically provisioned to the appropriate Graylog Team with all the Permissions everyone else in the Team has.

Providing Team Access Manually
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Before being assigned to a Team, users will see no streams and have no dashboards available. To create a permissions level for a Team, you select the Teams Overview button in the upper righthand corner of the screen. Teams Overview will show you the different Teams you have created in your Graylog environment, including the natural language name and Team description.

.. image:: /images/permissions/permissions_14.png

Graylog uses familiar search mechanisms for sharing views and dashboards so that Admins can more efficiently provide access to resources.

To add users to a stream, go into the Streams menu. Choose the Stream you want to share. Click “More Actions” and then “Share.”

Once in the Share menu, you can choose to give an individual user or a Team access to the streams. Once you provide access to a Team, all users who are members of that Graylog team will be given access to the Stream.

When you provide Stream access to a Team, you can also change the permissions for the entire Team. Admins are the only users who can create streams and also provide other users with Owner, Manager, or Viewer level access.
As soon as the Admin sets the access for a Team, users in that Team will have the necessary access.

Sharing
-------

As mentioned above, configuring who has access to something has moved away from the role configuration to the entities themselves. This functionality is available both in the Open Source and Enterprise level versions of Graylog. Any entity shared will be seen by all Users who have similar access levels to those entities. For example, the IT support team may choose to make dashboards which get shared across the organization. For small organizations, this increases noise but can be easily managed. For Enterprise level use, the proliferation of reports increases the noise and reduces Graylog’s usability.
Each entity that is implemented in the new system, which for 4.0 are Searches, Dashboards, Streams, Event Definitions, and Notifications, has a “Share” button associated with them.

.. image:: /images/permissions/permissions_17.png

That dialog looks the same for every entity and allows managing the level of access granted to the selected user or team. (Team assignment is only possible in Graylog Enterprise).
Just as with Teams, sharing offers three different levels of access:

* Viewer
* Manager
* Owner

Viewer rights mean you can use the entity, but not make any changes to them.
Manager rights mean you can edit any aspect about them, including deleting them.
Owner rights mean Manager rights, but on top of them, come with the ability to share the entity with additional users. This difference is to prevent privilege escalation: just because I have access to change a dashboard does not mean I should be able to share it with someone else.

For any given user, their profile page lists which entities they have access to, both directly as well as through team membership.

Sharing Streams and Dashboards with Teams
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By changing Roles and User attributes, Graylog 4.0 also changes how users gain access to different entities. Instead of placing entity access at the user Profile level, Graylog 4.0 offers a “Sharing” feature similar to those in other applications.

Users who are “Owners” or “Managers” can share entities like Dashboards and Streams with other users.

For Enterprise level use, Sharing stays contained within individual Teams. Thus, individual Teams can create as many reports and Dashboards as they need without decreasing visibility for other teams. For example, if the IT Support Team shares 5 Dashboards, those will only show up for the IT Support Team, not the Security Team.

Sharing within Teams
^^^^^^^^^^^^^^^^^^^^

Before being assigned to a Team, users will see no streams and have no dashboards available. To create a permissions level for a Team, you select the Teams Overview button in the upper righthand corner of the screen. Teams Overview will show you the different Teams you have created in your Graylog environment, including the natural language name and Team description.

.. image:: /images/permissions/permissions_14.png

Graylog uses familiar search mechanisms for sharing views and dashboards so that Admins can more efficiently provide access to resources.

To add users to a stream, go into the Streams menu. Choose the Stream you want to share. Click “More Actions” and then “Share.”

Once in the Share menu, you can choose to give an individual user or a Team access to the streams. Once you provide access to a Team, all users who are members of that Graylog team will be given access to the Stream.

When you provide Stream access to a Team, you can also change the permissions for the entire Team.

As soon as the Admin sets the access for a Team, users in that Team will have the necessary access.

.. image:: /images/permissions/permissions_19.png

You can choose to add users individually or by their Team. Choosing Security Team provides everyone the same level of access to the Stream all at once rather than adding each user individually:

.. image:: /images/permissions/permissions_20.png

.. image:: /images/permissions/permissions_21.png

Once you save changes, users on the Team automatically gain access to the Stream without needing to log out of Graylog.

.. image:: /images/permissions/permissions_22.png

Sharing Dashboards within Teams
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Graylog restricts Dashboards to Owners by default, meaning that all newly created Dashboards are “private dashboards.” This default setting ensures that Owners specify who can see their Dashboards and prevents data leakages.  Owners can choose to share Dashboards with individuals or their Teams so that they can collaborate.

**Example: Bob and Alice**

Alice creates a Dashboard in her account.

.. image:: /images/permissions/permissions_23.png

Bob, another member of her Team, cannot see the Dashboard in his account because the default Dashboard setting is private.

.. image:: /images/permissions/permissions_24.png

However, Bob can request that Alice share the Dashboard with him so that they can collaborate. When he requests this access, Alice can choose to share only with Bob or with the whole Team.

Alice then goes to her Dashboard view, chooses the Dashboard she wants to share:

.. image:: /images/permissions/permissions_25.png

Once she chooses the Dashboard, she clicks on the dash in the upper right-hand corner and chooses “Share” from the drop-down menu:

.. image:: /images/permissions/permissions_26.png

Alice can choose to share with a single user or her whole Team. She can also set access permissions as Viewer, Manager, or Owner.

.. image:: /images/permissions/permissions_27.png

Once she makes the access decision, she clicks on “Add Collaborator,” which saves the decisions, granting the selected level of access to all collaborators chosen.

.. image:: /images/permissions/permissions_28.png
