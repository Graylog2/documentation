*****************
Upgrading Graylog
*****************

When upgrading from a previous version of Graylog you follow the previous used installation method (ex. from image or package) using the new version numbers. 

The following Upgrade notes should be read carefully before you start the upgrade process. Breaking changes and dependency upgrades are documented in those upgrade notes.

You should always follow minor versions when updating across multiple versions to make sure necessary migrations are run correctly. The upgrade notes are always written coming from the stable release before.

.. toctree::
   :titlesonly:
   :glob:

   upgrade/graylog-*

Upgrading Graylog Originally Installed from Image
-------------------------------------------------

2.x
   It is not possible to upgrade previous OVAs to Graylog 3.0.0.

3.x
   Starting with Graylog 3.0.0, OVAs use the Operating System packages, so
   you can upgrade your appliance by following
   :ref:`this update guide <operating_package_upgrade_DEB-APT>`.

Upgrading Graylog Originally Installed from Package
---------------------------------------------------

If the current installation was installed using a package manager (ex. yum, apt), update the repository package to the target version, and use the system tools to upgrade the package.
For .rpm based systems :ref:`this update guide <operating_package_upgrade_rpm-yum-dnf>` and for .deb based systems :ref:`this update guide <operating_package_upgrade_DEB-APT>` should help.


.. _upgrading-elasticsearch:

Upgrading Elasticsearch
-----------------------

.. warning:: We caution you not to install or upgrade Elasticsearch to 7.11 and later! It is not supported. If you do so, it will break your instance!

Since Graylog 2.3 Elasticsearch 5.x is supported. This Graylog version supports Elasticsearch 2.x and 5.x. It is recommended to update Elasticsearch 2.x to the latest stable 5.x version, after you have Graylog 2.3 or later running. This Elasticsearch upgrade does not need to be made during the Graylog update. 

When upgrading from Elasticsearch 2.x to Elasticsearch 5.x, make sure to read `the upgrade guide <https://www.elastic.co/guide/en/elasticsearch/reference/5.6/setup-upgrade.html>`_ provided by Elastic. The Graylog :ref:`Elasticsearch configuration documentation <configuring_es>` contains information about the compatible Elasticsearch version. After the upgrade you must :ref:`rotate the indices once manually <rotate_es_indices>`.

Graylog 2.5 is the first Graylog version that supports Elasticsearch 6. The upgrade might need more attention and include the need to reindex your data if you are upgrading from versions before 5.x. Make sure to check :ref:`our Elasticsearch 6 upgrade notes <es6_reindex>` for this and other requirements.

When upgrading from Elasticsearch 5.x to Elasticsearch 6.x, make sure to read the `upgrade guide <https://www.elastic.co/guide/en/elasticsearch/reference/6.x/setup-upgrade.html>`_ provided by Elastic. 

Graylog 4.0 is the first release that supports Elasticsearch 7, the upgrade is recommended as soon as possible but might need more attention and include the need to reindex your data. Make sure to check :ref:`our Elasticsearch 7 upgrade notes <es7_reindex>` for this and other requirements.

When upgrading from Elasticsearch 6.x to Elasticsearch 7.x, make sure to read the `upgrade guide <https://www.elastic.co/guide/en/elasticsearch/reference/7.x/setup-upgrade.html>`__ provided by Elastic. The Graylog :ref:`Elasticsearch configuration documentation <configuring_es>` contains information about the compatible Elasticsearch version. After the upgrade you must :ref:`rotate the indices once manually <rotate_es_indices>`.

.. note::
   A note about rolling upgrades for Elasticsearch:
   Elasticsearch supports rolling upgrades to avoid downtimes during upgrades. Graylog supports rolling upgrades with no restart of any Graylog node for Elasticsearch as long as they are performed *between minor versions*. For more information please see :ref:`Rolling Upgrade Notes <es_rolling_upgrade>`.

.. toctree::
   :titlesonly:
   :glob:

   upgrade/elasticsearch*
   upgrade/rolling_es_upgrade

