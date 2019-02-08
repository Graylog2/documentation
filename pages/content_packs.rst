*************
Content Packs
*************

What are content packs?
=======================

Content packs are a convenient way to share configuration. A content pack is a
JSON file which contains a set of configurations of Graylog components.
This JSON file can be uploaded to Graylog instances and then installed.
A user who took the time to create a input, pipelines and dashboard for a
certain type of log format, can so easily share his efforts with the community.

Content packs can be found on the `Graylog Marketplace <https://marketplace.graylog.org/>`__.

.. Warning:: Content packs in 3.0 have changed fundamentally from previous
             versions. Graylog will try to support older versions in the
             future, but at this point there is no guarantee that older
             content packs still work.

Parameter
---------

Content packs can have parameters. Those parameters help to adjust the
configuration to the needs of the user. A good example usage is the port of
an input. The creator of the content pack may have his input running on port
55055, but the user of the content pack may already have an input running on
that specific port.
The creator can specify a parameter and assign it to the port.
The user of the content pack will be asked for a value of the parameter on
installation. The provided value will then be used as the port of the input on
the new system.

How do I create a Content Pack?
===============================

1. Navigate to **System / Content Pack**.
2. Click on **Create a Content Pack** on the upper right side of the page.
   A new content pack is created in a wizard. On the left side
   of that page is the navigation of the wizard. There are 3 steps to
   content pack creation: **Content Selection**, **Parameters** and **Preview**.
   In the middle part of the page is the form of each wizard step. And on the
   right side is the summary of the content pack in creation.

.. image:: /images/content_pack_selection.png

3. Fill out the general information of the content pack.
4. The **Content Selection** offers configurations which can be included to the
   content pack. Necessary dependencies will be included automatically.

.. Warning:: The one exception to this rule is dependencies for pipeline
             rules. Currently, grok patterns and lookup tables for pipeline
             rules must be added manually to the content pack. Support for
             automatic inclusion of pipeline rule dependencies will be
             added in a future release.

5. Click on **Next** or **Parameter** to go the Parameter Page.
   Parameter are placeholders which will be filled out during installation
   of a content pack. That way, parts of the configuration may be adjusted
   according to the needs of the user.
   To create a parameter click on **Create Parameter**. In the opening modal
   can the name, type and default value of the parameter be specified. Graylog
   supports four types of configuration values: String, Integer, Double
   and Boolean.

.. image:: /images/content_pack_parameter.png

6. The created parameter can be assigned to a configuration key by
   pressing **Edit** on one of the previously selected configurations
   under **Entity List**.
7. The final step of creation can be reached by clicking on **Next** or
   **Preview**.
   On the preview page displays a summary of the new content pack.
   This page is meant for a final close inspection of the content pack
   before creation.
8. To finish the creation click on **Create** or **Create and Download**.

Upload a content pack
=====================

Content packs may be downloaded at the
`Graylog Marketplace <https://marketplace.graylog.org/>`__.
To upload these content packs navigate to **System / Content Pack** and
click on **Upload**. The now showing modal has a file finder to select
the downloaded content pack. Click on **Upload** to finish the process.
The uploaded content pack may now be installed on the new Graylog system.

Installing a content pack
=========================

To install the newest version of a content pack, navigate to
**System / Content Pack**.
This page shows the list of uploaded and created content packs.
By clicking **Install** on the desired content pack, a modal will open
which will ask for a **Install Comment** and the values of the parameters.
It also shows the list of configurations that will be installed on the
system. Click on **Install** to complete the installation.

.. note:: Some entities need a unique title or name (e.g Lookup Table).
          When installing such an entity and the title is already
          present on the system, then Graylog will use the installed
          entity instead of installing a new one. Even when the
          new configuration differs from the already installed one. 

Uninstalling a content pack
===========================

Navigate to **System / Content Pack** and click on the name of the content
pack that should be uninstalled.
The displayed page shows the details of a uploaded or created content pack.

.. image:: /images/content_pack_show.png

On the left, select the version of the content pack.
Below that is a list of installations of that content pack.
Click **Uninstall** next to the desired installation.
A list of entities about to be removed will be displayed.
