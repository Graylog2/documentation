.. _graylog-ctl:

**********************
The graylog-ctl script
**********************

Some packages of Graylog (for example the :ref:`virtual machine appliances <virtual-machine-appliances>`)
ship with a pre-installed ``graylog-ctl`` script to allow you easy configuration of certain settings.

.. important:: ``graylog-ctl`` is only available in the virtual machine appliances, but not in the tar-ball (for manual setup), operating system packages, or configuration management scripts (Puppet, Chef, Ansible).


Configuration commands
======================

The following commands are changing the configuration of Graylog:

+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Command                                             | Description                                                                                                |
+=====================================================+============================================================================================================+
|| ``sudo graylog-ctl set-admin-password <password>`` | Set a new admin password                                                                                   |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-admin-username <username>`` | Set a different username for the admin user                                                                |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-email-config``              | Configure SMTP settings to send alert mails                                                                |
|| ``<smtp server> [--port=<smtp port>``              |                                                                                                            |
|| ``--user=<username>``                              |                                                                                                            |
|| ``--password=<password>``                          |                                                                                                            |
|| ``--from-email=<sender-address>``                  |                                                                                                            |
|| ``--web-url=<graylog web-interface url>``          |                                                                                                            |
|| ``--no-tls --no-ssl]``                             |                                                                                                            |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-timezone <zone acronym>``   | Set Graylog's time zone from a `list of valid time zones <http://www.joda.org/joda-time/timezones.html>`_. |
||                                                    | Make sure system time is also set correctly with ``sudo dpkg-reconfigure tzdata``.                         |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl enforce-ssl``                   | Enforce HTTPS for the web interface                                                                        |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-node-id <id>``              | Override random server node id                                                                             |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-server-secret <secret>``    | Override server secret used for encryption                                                                 |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl disable-internal-logging``      | Disable sending internal logs (e. g. nginx) from the VM to Graylog. Reboot is needed for activation!       |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-external-ip``               | Configure an external IP in the Nginx proxy.                                                               |
|| ``http[s]://<public IP>:port/``                    | This is needed to connect the web interface to the REST API e.g. in NAT'd networks or on AWS.              |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-listen-address``            | Set the listen address for the web interface, REST API, and the transport URI.                             |
|| ``--service <web|rest|transport|endpoint>``        | As well as the endpoint uri that is used by the web browser to connect to the API.                         |
|| ``--address http://<host>:port``                   | Can be used to deal with additional network interfaces.                                                    |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl local-connect``                 | Bind all services but the web interface to 127.0.0.1                                                       |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl set-mongodb-password [-a|-g]``  | Activate MongoDB authentication and set a password for an admin or unprivileged service user               |
|| ``-u <username> -p <password>``                    |                                                                                                            |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl backup-etcd``                   | Backup the cluster configuration stored in etcd. See also the :ref:`restore notes <restore_etcd>`.         |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+

Commands for multi node setups:

+--------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Command                                                      | Description                                                                                                |
+==============================================================+============================================================================================================+
|| ``sudo graylog-ctl set-cluster-master <IP of master node>`` | Set IP address of node where others can fetch cluster configuration from                                   |
+--------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl reconfigure-as-backend``                 | Run Graylog server and Elasticsearch on this node                                                          |
+--------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl reconfigure-as-datanode``                | Run Elasticsearch on this node only                                                                        |
+--------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl reconfigure-as-server``                  | Run Graylog server on this node only                                                                       |
+--------------------------------------------------------------+------------------------------------------------------------------------------------------------------------+

General commands:

+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
| Command                                             | Description                                                                                                |
+=====================================================+============================================================================================================+
|| ``sudo graylog-ctl cleanse``                       | Delete *all* graylog data, and start from scratch                                                          |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl graceful-kill``                 | Attempt a graceful stop, then SIGKILL the entire process group                                             |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl hup``                           | Send the services a HUP signal                                                                             |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl int``                           | Send the services an INT signal                                                                            |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl term``                          | Send the services a TERM signal                                                                            |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl kill``                          | Send the services a KILL signal                                                                            |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl list-servers``                  | List all Graylog servers in your cluster                                                                   |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl status``                        | Show the status of all the services                                                                        |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl start``                         | Start services if they are down, and restart them if they stop                                             |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl stop``                          | Stop the services, and do not restart them                                                                 |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl restart``                       | Stop the services if they are running, then start them again                                               |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl once``                          | Start the services if they are down. Do not restart them if they stop                                      |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl uninstall``                     | Kill all processes and uninstall the process supervisor (data will be preserved)                           |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl tail``                          | Watch the service logs of all enabled services                                                             |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl tail <service name>``           | Watch the logs of just one service, name can be 'server', 'elasticsearch', 'mongodb', 'nginx', 'etcd'      |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl show-config``                   | Show the service configuration                                                                             |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+
|| ``sudo graylog-ctl reconfigure``                   | Reconfigure the application                                                                                |
+-----------------------------------------------------+------------------------------------------------------------------------------------------------------------+

.. important:: After using a command that changes the application configuration re-run ``sudo graylog-ctl reconfigure`` to actually enable the changes.

Multi VM setup
==============

At some point it make sense to not run all services on a single VM anymore. For performance reasons you might want to add more Elasticsearch
nodes to the cluster or even add a second Graylog server. This can be achieved by changing IP addresses in the Graylog
configuration files by hand or use our canned configurations which come with the ``graylog-ctl`` command.

The idea is to have one VM which is a central point for other VMs to fetch all needed configuration settings to join the cluster.
Typically the first VM you spin up is used for this task. Automatically an instance of etcd is started and filled with the necessary
settings for other hosts.

For example, to create a small cluster with a dedicated Graylog server node and another for Elasticsearch, spin up two VMs from the same Graylog image.
On the first one start only Graylog and MongoDB::

  vm1> sudo graylog-ctl set-admin-password sEcReT
  vm1> sudo graylog-ctl reconfigure-as-server

On the second VM start only Elasticsearch. Before doing so set the IP of the first VM to fetch the configuration data from there::

  vm2> sudo graylog-ctl set-cluster-master <ip-of-vm1>
  vm2> sudo graylog-ctl reconfigure-as-datanode

  vm1> sudo graylog-ctl reconfigure-as-server
  
This results in a perfectly fine dual VM setup. However if you want to scale this setup out by adding an additional Elasticsearch node,
you can proceed in the same way::

  vm3> sudo graylog-ctl set-cluster-master <ip-of-vm1>
  vm3> sudo graylog-ctl reconfigure-as-datanode

  vm1> sudo graylog-ctl reconfigure-as-server
  vm2> sudo graylog-ctl reconfigure-as-datanode

Verify that all nodes are working as a cluster by going to the Kopf plugin on one of the Elasticsearch nodes open ``http://vm2:9200/_plugin/kopf/#!/nodes``.

**Important**:
In case you want to add a second Graylog server you have to set the same server secret on all machines.
The secret is stored in the file ``/etc/graylog/graylog-secrets`` and can be applied to other hosts with the ``set-server-secret`` sub-command.

The following configuration modes do exist:

+-----------------------------------------------------+-------------------------------------------------+
| Command                                             | Services                                        |
+=====================================================+=================================================+
| ``sudo graylog-ctl reconfigure``                    | Regenerate configuration files based on         |
|                                                     | ``/etc/graylog/graylog-services.json``          |
+-----------------------------------------------------+-------------------------------------------------+
| ``sudo graylog-ctl reconfigure-as-server``          | Run Graylog, web and MongoDB (no Elasticsearch) |
+-----------------------------------------------------+-------------------------------------------------+
| ``sudo graylog-ctl reconfigure-as-backend``         | Run Graylog, Elasticsearch and                  |
|                                                     | MongoDB (no nginx for web interface access)     |
+-----------------------------------------------------+-------------------------------------------------+
| ``sudo graylog-ctl reconfigure-as-datanode``        | Run only Elasticsearch                          |
+-----------------------------------------------------+-------------------------------------------------+
| ``sudo graylog-ctl enable-all-services``            | Run all services on this box                    |
+-----------------------------------------------------+-------------------------------------------------+

A server with only the web interface running is not supported as of Graylog 2.0. The web interface is now included in the server process.
But you can create your own service combinations by editing the file ``/etc/graylog/graylog-services.json`` by hand and enable or disable single services.
Just run ``graylog-ctl reconfigure`` afterwards.

.. _extend_ova_disk:

Extend disk space
=================

All data of the appliance setup is stored in ``/var/opt/graylog/data``.
In order to extend the disk space mount a second (virtual) hard drive into this directory.

.. important:: Make sure to move old data to the new drive before and give the graylog user permissions to read and write here.


Example procedure for the Graylog virtual appliance
---------------------------------------------------

.. note:: These steps require basic knowledge in using Linux and the common shell programs.

* Shutdown the virtual machine as preparation for creating a consistent snapshot.

* Take a snapshot of the virtual machine in case something goes wrong.

    * `Understanding VM snapshots in ESXi / ESX <https://kb.vmware.com/kb/1015180>`_
    * `VMware vSphere: Managing Snapshots <https://pubs.vmware.com/vsphere-65/topic/com.vmware.vsphere.vm_admin.doc/GUID-50BD0E64-75A6-4164-B0E3-A2FBCCE15F1A.html>`_
    * `VirtualBox: Snapshots <https://www.virtualbox.org/manual/ch01.html#snapshots>`_
    * `Parallels: Save Snapshots of a Virtual Machine <http://download.parallels.com/desktop/v12/docs/en_US/Parallels%20Desktop%20User's%20Guide/32896.htm>`_
    * `Parallels: Working with snapshots <http://kb.parallels.com/5691>`_

* Attach an additional hard drive to the virtual machine.

    * `VMware Workstation: Adding a New Virtual Disk to a Virtual Machine <https://www.vmware.com/support/ws5/doc/ws_disk_add_virtual.html>`_
    * `VMware vSphere: Virtual Disk Configuration <https://pubs.vmware.com/vsphere-65/topic/com.vmware.vsphere.vm_admin.doc/GUID-90FD3678-AC9F-40CC-BB66-F499141E2B99.html>`_
    * `VirtualBox: Virtual storage <https://www.virtualbox.org/manual/ch05.html>`_
    * `Parallels: Hard Disk <http://download.parallels.com/desktop/v12/docs/en_US/Parallels%20Desktop%20User's%20Guide/33140.htm>`_

* Start the virtual machine again.

* Stop all services to prevent disk access::

    $ sudo graylog-ctl stop

* Check for the `logical name` of the new hard drive. Usually this is ``/dev/sdb``::

    $ sudo lshw -class disk

* Partition and format new disk::

    $ sudo parted -a optimal /dev/sdb mklabel gpt
    # A reboot may be necessary at this point so that the updated GPT is being recognized by the operating system
    $ sudo parted -a optimal -- /dev/sdb unit compact mkpart primary ext3 "1" "-1"
    $ sudo mkfs.ext4 /dev/sdb1

* Mount disk into temporary directory ``/mnt/tmp``::

    $ sudo mkdir /mnt/tmp
    $ sudo mount /dev/sdb1 /mnt/tmp

* Copy current data to new disk::

    $ sudo cp -ax /var/opt/graylog/data/* /mnt/tmp/

* Compare both folders::

    # Output should be: Only in /mnt/tmp: lost+found
    $ sudo diff -qr --suppress-common-lines /var/opt/graylog/data /mnt/tmp

* Delete old data::

    $ sudo rm -rf /var/opt/graylog/data/*

* Mount new disk into ``/var/opt/graylog/data`` directory::

    $ sudo umount /mnt/tmp
    $ sudo mount /dev/sdb1 /var/opt/graylog/data

* Make change permanent by adding an entry to ``/etc/fstab``::

    $ echo '/dev/sdb1 /var/opt/graylog/data ext4 defaults 0 0' | sudo tee -a /etc/fstab

* Reboot virtual machine::

    $ sudo shutdown -r now


Install Graylog plugins
=======================
The Graylog plugin directory is located in ``/opt/graylog/plugin/``. Just drop a JAR file there and restart the server with
``sudo graylog-ctl restart graylog-server`` to load the plugin.

Install Elasticsearch plugins
=============================

Elasticsearch comes with a helper program to install additional plugins you can call it like this
``sudo JAVA_HOME=/opt/graylog/embedded/jre /opt/graylog/elasticsearch/bin/plugin``

Install custom SSL certificates
===============================

During the first reconfigure run self signed SSL certificates are generated. You can replace this certificate with your own to prevent security
warnings in your browser. Just drop the key and combined certificate file here: ``/opt/graylog/conf/nginx/ca/graylog.crt`` respectively
``/opt/graylog/conf/nginx/ca/graylog.key``. Afterwards restart nginx with ``sudo graylog-ctl restart nginx``.

.. _static_ip_ova:

Assign a static IP
==================

Per default the appliance make use of DHCP to setup the network. If you want to access Graylog under a static IP please
follow these instructions::

  $ sudo ifdown eth0

Edit the file ``/etc/network/interfaces`` like this (just the important lines)::

  auto eth0
    iface eth0 inet static
    address <static IP address>
    netmask <netmask>
    gateway <default gateway>
    pre-up sleep 2

Activate the new IP and reconfigure Graylog to make use of it::

  $ sudo ifup eth0
  $ sudo graylog-ctl reconfigure

Wait some time until all services are restarted and running again. Afterwards you should be able to access Graylog with the new IP.

.. _upgrade_graylog_omnibus:

Upgrade Graylog
===============

.. caution:: The Graylog omnibus package does *not* support unattended upgrading from Graylog 1.x to Graylog 2.x!

.. caution:: The Graylog omnibus package 2.3.0 and later, which contains Elasticsearch 5.5.0, can not be used in environments which have been running the Graylog omnibus package 1.x before and which still have indices created by Elasticsearch before version 2.0.0!

Always perform a full backup or snapshot of the appliance before proceeding. Only upgrade
if the release notes say the next version is a drop-in replacement.
Choose the Graylog version you want to install from the `list of Omnibus packages <https://packages.graylog2.org/appliances/ubuntu>`_ . ``graylog_latest.deb`` always links to the newest version::

  $ wget https://packages.graylog2.org/releases/graylog-omnibus/ubuntu/graylog_latest.deb
  $ sudo graylog-ctl stop
  $ sudo dpkg -G -i graylog_latest.deb
  $ sudo graylog-ctl backup-etcd
  $ sudo graylog-ctl reconfigure
  $ sudo reboot

.. error:: In case the ``etcd`` service won't start after the upgrade, an error is shown like:

  .. code-block:: ruby

    Errno::ECONNREFUSED
    -------------------
    Connection refused - connect(2) for "127.0.0.1" port 4001``

  Please flush and restore the ``etcd`` database like it's shown in the :ref:`restore notes <restore_etcd>`.

Migrate manually from 1.x to 2.x
================================

To update a 1.x appliance to 2.x the administrator has to purge the Graylog installation, migrate the stored log data
and install the new version as Omnibus package. Before upgrading read the `upgrade notes <https://github.com/Graylog2/graylog2-server/blob/master/UPGRADING.rst>`_.
This procedure can potentially delete log data or configuration settings. So it's absolutely necessary to perform a backup or a snapshot before!

Stop all services but Elasticsearch::

  $ sudo -s
  $ graylog-ctl stop graylog-web
  $ graylog-ctl stop graylog-server
  $ graylog-ctl stop mongodb
  $ graylog-ctl stop nginx
  $ graylog-ctl stop etcd

Check for index range types. The output of this command should be `{}`, if not `read these notes <https://github.com/Graylog2/graylog2-server/blob/6b2d3fa0cf11596bee0d606f2eace23d73e50513/UPGRADING.rst#index-range-types>`_  for how to fix this::

  $ curl -XGET <appliance_IP>:9200/_all/_mapping/index_range; echo
  {}

Delete the Graylog index template::

  $ curl -X DELETE <appliance_IP>:9200/_template/graylog-internal

Migrate appliance configuration::

  $ cd /etc
  $ mv graylog graylog2.2
  $ vi graylog2.2/graylog-secrets.json

  # Remove the graylog_web section
  },  << don't forget the comma!
  "graylog_web": {
    "secret_token": "3552c87f3e3..."
  }

  $ vi graylog2.2/graylog-services.json

  # Remove the graylog_web section
  }, << don't forget the comma!
  "graylog_web": {
    "enabled": true
  }

  $ vi graylog2.2/graylog-settings.json
  
  # Remove "rotation_size", "rotation_time", "indices"
  "enforce_ssl": false,
  "rotation_size": 1073741824,
  "rotation_time": 0,
  "indices": 10,
  "journal_size": 1,

Migrate appliance data::

  $ cd /var/opt
  $ mv graylog graylog2.2
  $ mv graylog2.2/data/elasticsearch/graylog2 graylog2.2/data/elasticsearch/graylog

Delete old Graylog version and install new Omnibus package::

  $ wget http://packages.graylog2.org/releases/graylog-omnibus/ubuntu/graylog_2.2.1-1_amd64.deb
  $ apt-get purge graylog
  $ dpkg -i graylog_2.2.1-1_amd64.deb

Move directories back::

  $ cd /etc
  $ mv graylog2.2 graylog
  $ cd /var/opt/
  $ mv graylog2.2 graylog

Reconfigure and Reboot::

  $ graylog-ctl reconfigure
  $ reboot

Graylog should now be updated and old data still available.

.. important:: The index retention configuration moved from the Graylog configuration file to the web interface. After the first start go to 'System -> Indices -> Update configuration' to re-enable your settings.

.. _graylog_ctl_advanced:

Advanced Settings
=================

To change certain parameters used by ``graylog-ctl`` during a reconfigure run you can override all default parameters found  in the `attributes <https://github.com/Graylog2/omnibus-graylog2/blob/2.2/files/graylog-cookbooks/graylog/attributes/default.rb>`_ file.

If you want to change the username used by Graylog for example, edit the file ``/etc/graylog/graylog-settings.json`` like this::

  "custom_attributes": {
    "user": {
      "username": "log-user"
    }
  }

Afterwards run ``sudo graylog-ctl reconfigure`` and ``sudo graylog-ctl restart``. The first command renders all changed configuration files and the later makes
sure that all services restart to activate the change.

There are a couple of other use cases of this, e.g. change the default data directories used by Graylog to ``/data`` (make sure this is writeable by the graylog user)::

  "custom_attributes": {
      "elasticsearch": {
        "data_directory": "/data/elasticsearch"
      },
      "mongodb": {
        "data_directory": "/data/mongodb"
      },
      "etcd": {
        "data_directory": "/data/etcd"
      },
      "graylog-server": {
        "journal_directory": "/data/journal"
      }
    }

Or change the default memory settings used by Graylog or Elasticsearch::

  "custom_attributes": {
       "graylog-server": {
         "memory": "1700m"
       },
       "elasticsearch": {
         "memory": "2200m"
       }
     }

Again, run ``reconfigure`` and ``restart`` afterwards to activate the changes.

Securing an appliance
=====================

Even though the Graylog appliances are not meant for production use there are still two commands you can use to increase the security of an installation.
With ``graylog-ctl local-connect`` only the web interface is reachable from the outside. All other services are listening on the local loopback device.
This is only useful when you run the appliance as a single node. Clustered setups are not possible anymore. But data stored in MongoDB or Elastcsearch
are protected from direct external access.

The other one is ``graylog-ctl set-mongodb-password``. This command enables authentication for MongoDB and creates or updates a database user.
First an admin user should be created. This user is needed for database maintenance and future password changes. Afterwards an unprivileged service user
can be created for Graylog. The procedure works like this::

  $ graylog-ctl set-mongodb-password -a -u admin -p someAdminPassword123
  $ graylog-ctl set-mongodb-password -g -u graylog -p someGraylogServicePassword
  $ graylog-ctl reconfigure

MongoDB and the Graylog server will be restarted with activated authentication. The username and password needs to be set on every Graylog node to make a cluster work.
Login to another Graylog server and only set the service user::

  $ graylog-ctl set-cluster-master 1.1.1.2
  $ graylog-ctl set-mongodb-password -g -u graylog -p someGraylogServicePassword
  $ graylog-ctl reconfigure-as-server

Since the pre-build appliances are based on standard Ubuntu-Linux, tools like iptables/SELinux/AppArmor can be used additionally.
But to explain all available countermeasurements would go beyond this documentation.

.. _restore_etcd:

Restore cluster configuration
=============================

With ``graylog-ctl backup-etcd`` a backup of the cluster configuration of a multi node setup can be created. In order to restore this backup copy the wal-file back to the data directory::

  $ graylog-ctl stop etcd
  $ rm -r /var/opt/graylog/data/etcd/member/*
  $ cp /var/opt/graylog/backup/etcd/<timestamp>/member/wal /var/opt/graylog/data/etcd/member/
  $ chown -R graylog.graylog /var/opt/graylog/data/etcd/member/wal
  $ su -c '/opt/graylog/embedded/sbin/etcd -data-dir=/var/opt/graylog/data/etcd -force-new-cluster' graylog
  <Ctrl-C>
  $ graylog-ctl start etcd
