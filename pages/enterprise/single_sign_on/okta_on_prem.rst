###################
Okta Single Sign-On 
###################

Graylog provides Okta single sign-on (SSO) for your organization. In addition to Active Directory and LDAP 
Graylog administrators can synchronize Okta groups members to teams Graylog. To use it, your teammates who 
administer SSO needs Okta configured as an external identity provider at the organization level.

********
Overview
********

This is a test


.. list-table:: Configuration Options
    :header-rows: 1
    :widths: 7 20

    * - Name
      - Description
    * - Backend
      - Backend on the **master** node where the archive files will be stored.
    * - Max Segment Size
      - Maximum size (in *bytes*) of archive segment files.
    * - Compression Type
      - Compression type that will be used to compress the archives.
    * - Checksum Type
      - Checksum algorithm that is used to calculate the checksum for archives.
    * - Restore index batch size
      - Elasticsearch batch size when restoring archive files.
    * - Streams to archive
      - Streams that should be included in the archive.