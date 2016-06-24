.. _graylog-ctl:

**********************
The graylog-ctl script
**********************

Some packages of Graylog (for example the :ref:`virtual machine appliances <virtual-machine-appliances>`)
ship with a pre-installed ``graylog-ctl`` script to allow you easy configuration of certain settings.

**Important:** The manual setup, operating system packages, configuration management scripts etc are not
shipping with this.

Configuration commands
======================

The following commands are changing the configuration of Graylog:

+-----------------------------------------------------+---------------------------------------------+
| Command                                             | Description                                 |
+=====================================================+=============================================+
|| ``sudo graylog-ctl set-admin-password <password>`` | Set a new admin password                    |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-admin-username <username>`` | Set a different username for the admin user |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-email-config``              | Configure SMTP settings to send alert mails |
|| ``<smtp server> [--port=<smtp port>``              |                                             |
|| ``--user=<username>``                              |                                             |
|| ``--password=<password>``                          |                                             |
|| ``--from-email=<sender-address>``                  |                                             |
|| ``--web-url=<graylog web-interface url>``          |                                             |
|| ``--no-tls --no-ssl]``                             |                                             |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-timezone <zone acronym>``   | Set Graylog's timezone. Make sure system    |
||                                                    | time is also set correctly with             |
||                                                    | ``sudo dpkg-reconfigure tzdata``            |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl enforce-ssl``                   | Enforce HTTPS for the web interface         |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-node-id <id>``              | Override random server node id              |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-server-secret <secret>``    | Override server secret used for encryption  |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl disable-internal-logging``      | Disable sending internal logs (e. g. nginx) |
||                                                    | from the virtual machine to Graylog         |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-external-ip``               | Configure an external IP in the Nginx       |
|| ``http[s]://<public IP>:port/``                    | proxy. This is needed to connect the web    |
||                                                    | interface to the REST API e.g. in nat'd     |
||                                                    | networks or on AWS.                         |
+-----------------------------------------------------+---------------------------------------------+
|| ``sudo graylog-ctl set-listen-address``            | Set the listen address for the web          |
|| ``--service <web|rest|trabsport>``                 | interface, REST API, and the transport URI. |
|| ``--address http://<host>:port``                   | Can be used to deal with additional network |
||                                                    | interfaces.                                 |
+-----------------------------------------------------+---------------------------------------------+

**After setting one or more of these options re-run**::

  sudo graylog-ctl reconfigure

You can also edit the full configuration files under ``/opt/graylog/conf`` manually. restart the related service afterwards::

  sudo graylog-ctl restart graylog-server

Or to restart all services::

  sudo graylog-ctl restart

Multi VM setup
==============

At some point it make sense to not run all services on a single VM anymore. For performance reasons you might want to add more Elasticsearch
nodes to the cluster or even add a second Graylog server. This can be achieved by changing IP addresses in the Graylog
configuration files by hand or use our canned configurations which come with the ``graylog-ctl`` command.

The idea is to have one VM which is a central point for other VMs to fetch all needed configuration settings to join the cluster.
Typically the first VM you spin up is used for this task. Automatically an instance of etcd is started and filled with the necessary
settings for other hosts.

For example, to create a small cluster with a dedicated Graylog server node and another for Elasticsearch, spin up two VMs from the same Graylog image.
On the first one start only `graylog-server` and `mongodb`::

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

Verify that all nodes are working as a cluster by going to the Kopf plugin on one of the Elasticsearch nodes `open http://vm2:9200/_plugin/kopf/#!/nodes`

**Important**:
In case you want to add a second Graylog server you have to set the same server secret on all machines.
The secret is stored in the file ``/etc/graylog/graylog-secrets`` and can be applied to other hosts with the ``set-server-secret`` sub-command.

The following configuration modes do exist:

+-----------------------------------------------------+---------------------------------------------+
| Command                                             | Services                                    |
+=====================================================+=============================================+
| ``sudo graylog-ctl reconfigure``                    | Run all services on this box                |
+-----------------------------------------------------+---------------------------------------------+
| ``sudo graylog-ctl reconfigure-as-server``          | Run graylog-server, web and mongodb         |
|                                                     | (no elasticsearch)                          |
+-----------------------------------------------------+---------------------------------------------+
| ``sudo graylog-ctl reconfigure-as-backend``         | Run graylog-server, elasticsearch and       |
|                                                     | mongodb (no nginx for web access)           |
+-----------------------------------------------------+---------------------------------------------+
| ``sudo graylog-ctl reconfigure-as-datanode``        | Run only elasticsearch                      |
+-----------------------------------------------------+---------------------------------------------+

A server with only the web interface running is not supported anymore since Graylog 2.0. The web interface is now included in the server process.
But you can create your own service combinations by editing the file `/etc/graylog/graylog-services.json` by hand and enable or disable single services.
Just run `graylog-ctl reconfigure` afterwards.

Extend disk space
=================

All data of an appliance setup is stored in one directory ``/var/opt/graylog/data``. In order to extend the disk space mount a second drive on this path. Make
sure to move old data to the new drive before and give the graylog user permissions to read and write here.

Example procedure for an OVA appliance on VMWare:

+-----------------------------------------------------+--------------------------------------------------+
| Action                                              | Explanation                                      |
+=====================================================+==================================================+
| shutdown the VM                                     | Preparation for creating a consistend snapshot   |
+-----------------------------------------------------+--------------------------------------------------+
| take a snapshot through VMWare                      | Use the VMWare GUI to create a snapshot          |
|                                                     | of the VM in case something goes wrong           |
+-----------------------------------------------------+--------------------------------------------------+
| attach an additional hard drive                     | Use the VMWare GUI to attach another harddrive   |
|                                                     | suitable for the amount of logs you want to      |
|                                                     | store                                            |
+-----------------------------------------------------+--------------------------------------------------+
| start the VM again and follow these steps:          |                                                  |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo graylog-ctl stop``                         | Stop all running services to prevent disk        |
|                                                     | access                                           |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo lshw -class disk``                         | Check for the `logical name` of the new hard     |
|                                                     | drive. Usually this is `/dev/sdb`                |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo parted -a optimal /dev/sdb mklabel gpt``   | Partition and format new disk                    |
| |                                                   |                                                  |
| | (A reboot may be necessary at this point)         |                                                  |
| |                                                   |                                                  |
| | ``sudo parted -a optimal -- /dev/sdb unit \\``    |                                                  |
| |          ``compact mkpart primary ext3 "1" "-1"`` |                                                  |
| |                                                   |                                                  |
| | ``sudo mkfs.ext4 /dev/sdb1``                      |                                                  |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo mkdir /mnt/tmp``                           | Mount disk to temporary mount point              |
| |                                                   |                                                  |
| | ``sudo mount /dev/sdb1 /mnt/tmp``                 |                                                  |
+-----------------------------------------------------+--------------------------------------------------+
| | ``cd /var/opt/graylog/data``                      | Copy current data to new disk                    |
| |                                                   |                                                  |
| | ``sudo cp -ax * /mnt/tmp/``                       |                                                  |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo diff -qr --suppress-common-lines \\``      | Compare both folders.                            |
| |           ``/var/opt/graylog/data /mnt/tmp``      | Output should be: `Only in /mnt/tmp: lost+found` |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo rm -rf /var/opt/graylog/data/*``           | Delete old data                                  |
+-----------------------------------------------------+--------------------------------------------------+
| | ``sudo umount /mnt/tmp``                          | Mount new disk over data folder                  |
| |                                                   |                                                  |
| | ``sudo mount /dev/sdb1 /var/opt/graylog/data``    |                                                  |
+-----------------------------------------------------+--------------------------------------------------+
| | ``echo "/dev/sdb1 /var/opt/graylog/data ext4 \\`` | Make change permanent                            |
| | ``defaults 0 0" \| sudo tee -a /etc/fstab``       |                                                  |
| |                                                   |                                                  |
| | ``sudo shutdown -r now``                          |                                                  |
+-----------------------------------------------------+--------------------------------------------------+

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

.. warning:: The Graylog omnibus package does *not* support unattended upgrading from Graylog 1.x to Graylog 2.0.x!

Always perform a full backup or snapshot of the appliance before proceeding. Only upgrade
if the release notes say the next version is a drop-in replacement.
Look for the Graylog version you want to install `here <https://packages.graylog2.org/appliances/ubuntu>`_ , `graylog_latest` always links to the newest version::

  wget https://packages.graylog2.org/releases/graylog-omnibus/ubuntu/graylog_latest.deb
  sudo graylog-ctl stop
  sudo dpkg -G -i graylog_latest.deb
  sudo graylog-ctl reconfigure

Migrate manually from 1.x to 2.0.x
==================================

To update a 1.x appliance to 2.0.x the administrator has to purge the Graylog installation, migrate the stored log data
and install the new version as Omnibus package. Before upgrading read the upgrade `notes <https://github.com/Graylog2/graylog2-server/blob/master/UPGRADING.rst>`_.
This procedure can potentially delete log data or configuration settings. So it's absolutely necessary to perform a backup or a snpashot before!

Stop all services but Elasticsearch::

  sudo -s
  graylog-ctl stop graylog-web
  graylog-ctl stop graylog-server
  graylog-ctl stop mongodb
  graylog-ctl stop nginx
  graylog-ctl stop etcd

Check for index range types. The output of this command should be `{}`, if not `read <https://github.com/Graylog2/graylog2-server/blob/master/UPGRADING.rst#index-range-types>`_  how to fix this::

  curl -XGET <appliance_IP>:9200/_all/_mapping/index_range; echo
  {}

Delete the Graylog index template::

  curl -X DELETE <appliance_IP>:9200/_template/graylog-internal

Migrate appliance configuration::

  cd /etc
  mv graylog graylog2.0
  vi graylog2.0/graylog-secrets.json

  Remove the graylog_web section
  },  << don't forget the comma!
  "graylog_web": {
    "secret_token": "3552c87f3e3..."
  }

  vi graylog2.0/graylog-services.json

  Remove the graylog_web section
  }, << don't forget the comma!
  "graylog_web": {
    "enabled": true
  }

  vi graylog2.0/graylog-settings.json
  
  Remove "rotation_size", "rotation_time", "indices"
  "enforce_ssl": false,
  "rotation_size": 1073741824,
  "rotation_time": 0,
  "indices": 10,
  "journal_size": 1,

Migrate appliance data::

  cd /var/opt
  mv graylog graylog2.0
  mv graylog2.0/data/elasticsearch/graylog2 graylog2.0/data/elasticsearch/graylog

Delete old Graylog version and install new Omnibus package::

  wget http://packages.graylog2.org/releases/graylog-omnibus/ubuntu/graylog_2.0.0-2_amd64.deb
  apt-get purge graylog
  dpkg -i graylog_2.0.0-2_amd64.deb

Move directories back::

  cd /etc
  mv graylog2.0 graylog
  cd /var/opt/
  mv graylog2.0 graylog

Reconfigure and Reboot::

  graylog-ctl reconfigure
  reboot

Graylog should now be updated and old data still available.

**Important:** The index retention configuration moved from the Graylog configuration file to the web interface. After the
first start go to 'System -> Indices -> Update configuration' to re-enable your settings!

.. _graylog_ctl_advanced:

Advanced Settings
=================

To change certain parameters used by `graylog-ctl` during a reconfigure run you can override all default parameters found  in the `attributes <https://github.com/Graylog2/omnibus-graylog2/blob/1.3/files/graylog-cookbooks/graylog/attributes/default.rb>`_ file.
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

Or change the default memory settings used by `graylog-server` or `elasticsearch`::

  "custom_attributes": {
       "graylog-server": {
         "memory": "1700m"
       },
       "elasticsearch": {
         "memory": "2200m"
       }
     }

Again, run ``reconfigure`` and ``restart`` afterwards to activate the changes.

Production readiness
====================

You can use the Graylog appliances (OVA, Docker, AWS, ...) for small production setups but please consider to harden the security of the box before.

 * Set another password for the default ubuntu user
 * Disable remote password logins in /etc/ssh/sshd_config and deploy proper ssh keys
 * Seperate the box network-wise from the outside, otherwise Elasticsearch can be reached by anyone

If you want to create your own customised setup take a look at our :ref:`other installation methods <installing>`.
