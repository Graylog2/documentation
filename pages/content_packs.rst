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

Parameter
---------

Content packs can have parameters. Those parameters help to adjust the
configuration to the needs of the user. A good example usage is the port of
an input. The creator of the content pack may have his input running on port
55055, but the user of the content pack may have already an input running on
that specific port.
The creator can specify a parameter and assign it to the port.
The user of the content pack will be asked for a value of the parameter on
installation. The value than will be used as the port of the input.

How do I create a Content Pack?
===============================

1. Navigate to **System / Content Pack**.
2. Click on **Create a Content Pack** on the upper right side of the page.
   You will now see the wizard for a content pack creation. On the left side
   of that page you can see the navigation of the wizard. There are 3 steps to
   content pack creation: **Content Selection**, **Parameters** and **Preview**.
   In the middle part of the page is the form of each wizard step. And on the
   right side you can see the summary of your content pack.

.. image:: /images/content_pack_selection.png

3. Fill out the general information of the content pack.
4. In **Content Selection** you can select the configuration you want to
   include in your content pack. Necessary dependencies will be included
   automatically.

.. Warning:: The dependency resolution of pipeline rules does not work yet.
             Grok patterns and lookup tables of pipeline rules must be add
             manually to the content pack.

5. Click on **Next** or **Parameter** to go the Parameter Page.
   Parameter are placeholder which will be filled out during installation
   of a content pack. That way parts of the configuration can be adjusted
   fitting to the need of the user.
   To create a parameter click on **Create Parameter**. In the opening modal
   you can specify the name, type and default value of the parameter. We
   support four types of configuration values: String, Integer, Double
   and Boolean.

.. image:: /images/content_pack_parameter.png

6. After creating a parameter you can assign it to a configuration
   key. For that press **Edit** on one of the previously selected
   configuration under **Entity List**.
7. Press **Next** or **Preview** to complete the creation.
   On the preview page you get a summarize of your content pack. Please
   take a close look if all needed configurations are included.
8. To finish the creation click on **Create** or **Create and Download**.

Installing a content pack
=========================

To install the newest version of a content pack, navigate to
**System / Content Pack**.
Here you see the list of uploaded and created content packs.
By clicking **Install** on the desired content pack, a modal will open
which will ask for a **Install comment** and the values of the parameters.
It also shows the list of configurations that will be installed on the
system. Press on **Install** to complete the installation.

.. note:: When installing a configuration of a type where the title must be
          unique (e.g Lookup Tables) the configuration will be only installed
          once, even when the configuration differs.

Uninstalling a content pack
===========================

Navigate to **System / Content Pack** and click on the name of the content
pack that should be uninstalled.
You see now the page of the uploaded content pack.

.. image:: /images/content_pack_show.png

On the left side you can select the version of the content pack.
Below that you find a list of installations. After pressing **Uninstall**
on one of the installations a modal will open showing the entities the
uninstall process will remove from the system.

.. note:: When uninstalling a content pack Graylog keeps track of the remaining
          installations of configurations with unique names.
          Only when the last installation of that configuration will be
          removed the configuration itself will be removed as well.
