*****************
Upgrading Graylog
*****************

When upgrading from a previous version of Graylog you follow the previous used installation method using the new version numbers. 

The following Upgrade notes should be read carefully before you start the upgrade process. Breaking changes and dependency upgrades are documented in those upgrade notes.

You should always follow minor versions when updating across multiple versions to make sure necessary migrations are run correctly. The upgrade notes are always written coming from the stable release before.

.. toctree::
   :titlesonly:
   :glob:

   upgrade/graylog-*


The Virtual Machine Appliance (OVA) and Amazon Web Services (AMI) Version of Graylog use the Omnibus package. The upgrade documentation is :ref:`part of the graylog-ctl documentation <upgrade_graylog_omnibus>`.

Should the current installation use operating system packages, update the repository package to the target version and use the system tools to upgrade the package.

For .rpm based systems :ref:`this update guide <operating_package_upgrade_rpm-yum-dnf>` and for .deb based systems :ref:`this update guide <operating_package_upgrade_DEB-APT>` should help.
