.. _sec_adcs_certificates.rst:

*************************************************************
Generating Graylog certificates and keys with Microsoft AD CS
*************************************************************

In order to really make your Graylog installation "your own" Graylog, you will need to add TLS certificates issued and trusted by your own organization. Many organizations rely upon Microsoft's ADCS (Active Directory Certificate Services) for the issuance of their internal certificates. Here, we will explain the basic requirements and workflow of setting up all keys and certificates for a Graylog stack. 

In these examples we will assume a Graylog cluster, consisting of:

* One Graylog front-end server.
* Three Graylog data receiver hosts (clustered).
* Three ElasticSearch instances (clustered).
* SearchGuard, used to apply TLS/SSL for free on ElasticSearch.
* Three MongoDB instances (clustered as *replica set*)


Required certificates
=====================

In order to provide your full cluster with all required certificates, we'll need to make all of the following keypairs and certificates. For each certificate you'll need to gather the relevant hostnames, DNS aliases and IP addresses, because we want the certificates to work for all of these.

.. list-table:: Required certificates and key files
    :header-rows: 1

    * - Goal
      - Subject
      - Subject alt. names
      - Filetype
    * - MongoDB 1
      - CN=hostname1.mydomain.local
      - dns:hostname1
        dns:hostname1.mydomain.local
        dns:graylogmongoalias.mydomain.local
        dns:graylogmongoalias
        ip:192.168.100.101
      - PEM PKCS#12 (cert+key in one)
    * - MongoDB 2
      - CN=hostname2.mydomain.local
      - dns:hostname2
        dns:hostname12mydomain.local
        dns:graylogmongoalias.mydomain.local
        dns:graylogmongoalias
        ip:192.168.100.102
      - PEM PKCS#12 (cert+key in one)
    * - MongoDB 3
      - CN=hostname3.mydomain.local
      - dns:hostname3
        dns:hostname3.mydomain.local
        dns:graylogmongoalias.mydomain.local
        dns:graylogmongoalias
        ip:192.168.100.103
      - PEM PKCS#12 (cert+key in one)
    * - Graylog frontend
      - CN=hostname4.mydomain.local
      - dns:hostname4
        dns:hostname4.mydomain.local
        dns:graylogguialias.mydomain.local
        dns:graylogguialias
        ip:192.168.100.104
      - PEM (certificate)
        PKCS#8 (key file)
    * - Graylog receiver 1
      - CN=hostname5.mydomain.local
      - dns:hostname5
        dns:hostname5.mydomain.local
        dns:graylogreceiveralias.mydomain.local
        dns:graylogreceiveralias
        ip:192.168.100.105
      - PEM (certificate)
        PKCS#8 (key file)
    * - Graylog receiver 2
      - CN=hostname6.mydomain.local
      - dns:hostname6
        dns:hostname6.mydomain.local
        dns:graylogreceiveralias.mydomain.local
        dns:graylogreceiveralias
        ip:192.168.100.106
      - PEM (certificate)
        PKCS#8 (key file)
    * - Graylog receiver 3
      - CN=hostname7.mydomain.local
      - dns:hostname7
        dns:hostname7.mydomain.local
        dns:graylogreceiveralias.mydomain.local
        dns:graylogreceiveralias
        ip:192.168.100.107
      - PEM (certificate)
        PKCS#8 (key file)
    * - SearchGuard Admin
      - CN=searchguardadmin,O=yourorganization
      - 
      - PEM (certificate)
        PKCS#8 (key file)
    * - ElasticSearch 1
      - CN=hostname8.mydomain.local
      - dns:hostname8
        dns:hostname8.mydomain.local
        dns:graylogelasticalias.mydomain.local
        dns:graylogelasticalias
        ip:192.168.100.108
      - PEM (certificate)
        PKCS#8 (key file)
    * - ElasticSearch 2
      - CN=hostname9.mydomain.local
      - dns:hostname9
        dns:hostname9.mydomain.local
        dns:graylogelasticalias.mydomain.local
        dns:graylogelasticalias
        ip:192.168.100.109
      - PEM (certificate)
        PKCS#8 (key file)
    * - ElasticSearch 3
      - CN=hostname9.mydomain.local
      - dns:hostname9
        dns:hostname9.mydomain.local
        dns:graylogelasticalias.mydomain.local
        dns:graylogelasticalias
        ip:192.168.100.109
      - PEM (certificate)
        PKCS#8 (key file)


Graylog stack certificate template
==================================

The certificates for the Graylog stack and all of its components need some pretty specific settings. In order to achieve these, you will need to define a new certificate template in ADCS. 

Be careful: 

* Defining a new certicate template will require elevated privileges in your Active Directory domain. 
* PKI and certificates are a matter of trust! Do not break your organization's *Certificate Policy* or its *Certificate practice Statement*. Stick to your standard procedures and do not simply start messing with the PKI!

Defining the new template is done through the ADCS management tool "*Certification Authority*". 

#. Duplicate the default ADCS WebServer template, rename it to your liking.
#. General tab:

   #. Set the name to something recognizable, for example "Graylog Stack Template".
   #. The software will automatically generate the internal name, which removes all spaces: "GraylogStackTemplate".

#. Cryptography tab:

   #. **Provider** is the *Key Storage Provider*
   #. **Requests can use any provider available on the subject's computer** is true
   #. **Algorithm** is *RSA 2048*
   #. **Request hash** is *SHA256*
   #. **Use alternate signature hash** must be set to false.

#. Extensions tab:

   #. **Application policies** is set to both *server auth* as well as *client auth*.

#. Request handling tab:

   .. note:: If you are going to be generating all the keypairs on your issuing CA or on another management station, then you will need to add the following as well, which will allow you to export the keypair for migration to the Graylog stack servers.
   
   #. **Allow the private key to be exported** is set to *Yes*.

Generating the keypair and certificates - preparation
=====================================================

The following instructions assume that you generate all the keypairs on a Windows administrative workstation, or on the issuing CA itself (meaning, you'll need that extra "*Allow the private key to be exported*" flag). You can of course generate all keys on the Graylog stack servers and then simply submit the CSR (certificate signing request) to the CA.

The .INF input file for the *certreq* command would look similar to the following. Note that we are referring to the template by the internal name, which does not have whitespace!::

      [Version]
      signature="$Windows NT$"
      [NewRequest]
      Subject="CN=hostname5.mydomain.local"
      HashAlgorithm=SHA256
      Keyalgorithm=RSA
      KeyLength=2048
      Exportable=True
      MachineKeySet=True
      [RequestAttributes]
      CertificateTemplate="GraylogStackTemplate"
      [Extensions]
      2.5.29.17="{text}"
      _continue_="dns=hostname5&" 
      _continue_="dns=hostname5.mydomain.local&" 
      _continue_="dns=graylogreceiveralias.mydomain.local&" 
      _continue_="dns=graylogreceiveralias&" 
      _continue_="ipaddress=192.168.100.105&" 

If you're one of the edge-cases where you will be using an older *Internet Explorer* to talk to the IP address of the host, as opposed to the hostname or its alias, you will need to add::

      _continue_="dns=192.168.100.105&" 

For some reason IExplore ignores the *ipaddress* field of the SAN (subject alternative name).

The above is only one of the needed .INF files; you will need one for each keypair being generated! So adjust all relevant fields and save each .INF file separately.


Generating the keypair and certificates - execution
===================================================

As said, we're assuming that you're generating the keypairs on your Windows administration station. If you're generating the keypairs on the Graylog Linux hosts, then you will need to use different instructions. 

For each of the .INF files that we built, we will run commands like the following (assuming that the files are all in D:\secrets\graylog)::

      certreq -new D:\secrets\graylog\hostname5-graylogreceiver.inf D:\secrets\graylog\hostname5-graylogreceiver.req
      certreq -submit D:\secrets\graylog\hostname5-graylogreceiver.req

This gives you a request ID, for example "531". Ask one of your PKI administrators to approve the request, for example::

      certutil -resubmit 531

Afterwards you can continue::

      certreq -retrieve 531 D:\secrets\graylog\hostname5-graylogreceiver.cer
      certreq -accept D:\secrets\graylog\hostname5-graylogreceiver.cer

What all of this does is:

#. Generate a keypair by your specifications.
#. Generate a CSR for the keypair.
#. Submit the CSR to the issuing CA.
#. Approve the CSR on the issuing CA.
#. Export the signed certificate from the issuing CA.
#. Import the signed certificate into your current server's certificate store. 


**SearchGuard admin**

SearchGuard is used to add TLS/SSL encryption onto ElasticSearch for free. The product requires that the admin-user authenticates using a keypair and certificate. The generation process is similar to the one above, except that you won't be adding SANs, because the user does not have DNS names or IP addresses. The subject name will understandably also be different (e.g. *CN=searchguardadmin,OU=yourteam,O=yourorganization*), but be warned that it must match exactly with the account name in the SearchGuard configuration.


Generating the keypair and certificates - conversion
====================================================

We showed earlier (in the table above) that each part of the Graylog stack has specific requirements for the format and files that are used to submit the keypair and the certificate. We will need to convert everything we have right now, in order to make them usable.


.. warning:: Key materials are very sensitive information! You should not leave them lying around! Once you have finished the setup of all keys and certificates on the Graylog stack, you must delete all the files we've put into D:\secrets\graylog. Never leave key materials lying around!

Also, please use strong passwords on all PFX and PKCS files! Store these passwords safely, in a password vaulting application.


**CA Chain**

Each application requires that you provide the CA chain of your PKI, for inclusion in its trust store. The following assumes that you have one root CA and one issuing CA and that you've put their respective certificates in D:\secrets\graylog::

      openssl x509 -in rootca.crt -outform pem -out D:\secrets\graylog\rootca.pem
      openssl x509 -in ca.crt -outform pem -out D:\secrets\graylog\ca.pem
      type D:\secrets\graylog\rootca.pem > D:\secrets\graylog\cachain.pem
      type D:\secrets\graylog\rootca.pem >> D:\secrets\graylog\cachain.pem

The resulting cachain.pem file can be used in all Graylog stack applications for inclusion in the trust store. You will probably need to run the file through **dos2unix** first though, to fix line endings.


**MongoDB**

For each of the keypairs we made we will need to repeat the following in Powershell (adjust all names accordingly)::

      Get-ChildItem -Path cert:\\LocalMachine\My | Select-String hostname3

This will return metadata of the certificate for MongoDB on hostname3. You will need the thumbprint string, which will look similar to "*5F98EBBFE735CDDAE00E33E0FD69050EF9220254*". Moving on::

      $mypass = ConvertTo-SecureString -String "yoursafepassword" -Force -AsPlainText
      Get-ChildItem -Path cert:\\LocalMachine\My\5F98EBBFE735CDDAE00E33E0FD69050EF9220254 | Export-PfxCertificate -FilePath D:\secrets\graylog\hostname3-mongodb.pfx -Password $mypass
      openssl x509 -in D:\secrets\graylog\hostname3-mongodb.cer -outform pem -out D:\secrets\graylog\hostname3-mongodb.crt
      openssl pkcs12 -in D:\secrets\graylog\hostname3-mongodb.pfx -nocerts -out D:\secrets\graylog\hostname3-mongodb.key
      type D:\secrets\graylog\hostname3-mongodb.crt > D:\secrets\graylog\hostname3-mongodb.pem
      D:\secrets\graylog\hostname3-mongodb.key >> D:\secrets\graylog\hostname3-mongodb.pem

Finally, edit the PEM file D:\secrets\graylog\hostname3-mongodb.pem to remove all extraneous metadata and whitespaces. There should be nothing separating the *=== END CERTIFICATE ===* and the *=== BEGIN PRIVATE KEY ===* headers. 

You may upload the PEM file to the relevant MongoDB server, where you will need to do one final conversion: use **dos2unix** to convert the line endings from Windows-type to Linux-type. 


**Graylog and ElasticSearch**

For each of the keypairs we made we will need to repeat the following in Powershell (adjust all names accordingly)::

      Get-ChildItem -Path cert:\\LocalMachine\My | Select-String hostname5

This will return metadata of the certificate for MongoDB on hostname5. You will need the thumbprint string, which will look similar to "*5F98EBBFE735CDDAE00E33E0FD69050EF9220254*". Moving on::

      $mypass = ConvertTo-SecureString -String "yoursafepassword" -Force -AsPlainText
      Get-ChildItem -Path cert:\\LocalMachine\My\5F98EBBFE735CDDAE00E33E0FD69050EF9220254 | Export-PfxCertificate -FilePath D:\secrets\graylog\hostname5-receiver.pfx -Password $mypass
      openssl x509 -in D:\secrets\graylog\hostname5-receiver.cer -outform pem -out D:\secrets\graylog\hostname5-receiver.crt
      openssl pkcs12 -in D:\secrets\graylog\hostname5-receiver.pfx -nocerts -out D:\secrets\graylog\hostname5-receiver.key
      openssl pkcs8 -in D:\secrets\graylog\hostname5-receiver.key -topk8 -out D:\secrets\graylog\hostname5-receiver.pem

Finally, edit the CRT and PEM files to remove all extraneous metadata and whitespaces. There should be nothing before or after the **=== BEGIN** and **END ===** tags.

You may upload the PEM and CRT files to the relevant ElasticSearch or Graylog server, where you will need to do one final conversion: use **dos2unix** to convert the line endings from Windows-type to Linux-type. 

