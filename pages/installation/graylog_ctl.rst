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


+-------------------------------------------------+---------------------------------------------+
| Command                                         | Description                                 |
+=================================================+=============================================+
| sudo graylog-ctl set-admin-password <password>  | Set a new admin password                    |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl set-admin-username <username>  | Set a different username for the admin user |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl set-email-config <smtp server> | Configure SMTP settings to send alert mails |
| [--port=<smtp port> --user=<username>           |                                             |
| --password=<password> --no-tls --no-ssl]        |                                             |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl set-timezone <zone acronym>    | Set Graylog's timezone. Make sure system    |
|                                                 | time is also set correctly with             |
|                                                 | ``sudo dpkg-reconfigure tzdata``            |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl set-retention --size=<Gb> OR   | Configure message retention                 |
| --time=<hours> --indices=<number>               |                                             |
| [--journal=<Gb>]                                |                                             |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl enforce-ssl                    | Enforce HTTPs for the web interface         |
+-------------------------------------------------+---------------------------------------------+

**After setting one or more of these options re-run**::

  sudo graylog-ctl reconfigure

You can also edit the full configuration files under ``/opt/graylog/conf`` manually. restart the related service afterwards::

  sudo graylog-ctl restart graylog-server

Or to restart all services::

  sudo graylog-ctl restart

Multi VM setup
==============

At some point it makes sense to not run all services in one VM anymore. For performance reasons you maybe want to add more Elasticsearch
nodes or want to run the web interface separately from the server components. You can reach this by changing IP addresses in the Graylog
configuration files or you can use our canned configurations which come with the ``graylog-ctl`` command.

The idea is to have one VM which is a central point for other VMs to fetch all needed configuration settings to join your cluster.
Typically the first VM you spin up is used for this task. Automatically an instance of etcd is started and filled with the necessary
settings for other hosts.

For example to split the web interface from the rest of the setup, spin up two VMs from the same graylog image. On the first only start
``graylog-server``, ``elasticsearch`` and ``mongodb``::

  vm1> sudo graylog-ctl set-admin-password sEcReT
  vm1> sudo graylog-ctl reconfigure-as-backend

On the second VM, start only the web interface but before set the IP of the first VM to fetch configuration data from::

  vm2> sudo graylog-ctl set-cluster-master <ip-of-vm1>
  vm2> sudo graylog-ctl reconfigure-as-webinterface

This results in a perfectly fine dual VM setup. However if you want to scale this setup out by adding an additional Elasticsearch node,
you can proceed in the same way::

  vm3> sudo graylog-ctl set-cluster-master <ip-of-vm1>
  vm3> sudo graylog-ctl reconfigure-as-datanode

The following configuration modes do exist:

+-------------------------------------------------+---------------------------------------------+
| Command                                         | Services                                    |
+=================================================+=============================================+
| sudo graylog-ctl reconfigure                    | Run all services on this box                |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl reconfigure-as-backend         | Run graylog-server, elasticsearch and       |
|                                                 | mongodb                                     |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl reconfigure-as-webinterface    | Run only the web interface                  |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl reconfigure-as-datanode        | Run only elasticsearch                      |
+-------------------------------------------------+---------------------------------------------+
| sudo graylog-ctl reconfigure-as-server          | Run graylog-server and mongodb              |
|                                                 | (no elasticsearch)                          |
+-------------------------------------------------+---------------------------------------------+

Extend disk space
=================

All data is stored in one directory ``/var/opt/graylog/data``. In order to extend the disk space mount a second drive on this path. Make
sure to move old data to the new drive before and give the graylog user permissions to read and write here.

Example procedure for an OVA appliance on VMWare:

+-------------------------------------------------+--------------------------------------------------+
| Action                                          | Explanation                                      |
+=================================================+==================================================+
| shutdown the VM                                 | Preparation for creating a consistend snapshot   |
+-------------------------------------------------+--------------------------------------------------+
| take a snapshot through VMWare                  | Use the VMWare GUI to create a snapshot          |
|                                                 | of the VM in case something goes wrong           |
+-------------------------------------------------+--------------------------------------------------+
| attach an additional hard drive                 | Use the VMWare GUI to attach another harddrive   |
|                                                 | suitable for the amount of logs you want to      |
|                                                 | store                                            |
+-------------------------------------------------+--------------------------------------------------+
| start the VM again                              |                                                  |
+-------------------------------------------------+--------------------------------------------------+
| | sudo graylog-ctl stop                         | Stop all running services to prevent disk        |
|                                                 | access                                           |
+-------------------------------------------------+--------------------------------------------------+
| | sudo lshw -class disk                         | Check for the `logical name` of the new hard     |
|                                                 | drive. Usually this is `/dev/sdb`                |
+-------------------------------------------------+--------------------------------------------------+
| | sudo parted -a optimal /dev/sdb mklabel gpt   | Partition and format new disk                    |
| | sudo parted -a optimal -- /dev/sdb unit \\    |                                                  |
| |          compact mkpart primary ext3 "1" "-1" |                                                  |
| | sudo mkfs.ext4 /dev/sdb1                      |                                                  |
+-------------------------------------------------+--------------------------------------------------+
| | sudo mkdir /mnt/tmp                           | Mount disk to temporary mount point              |
| | sudo mount /dev/sdb1 /mnt/tmp                 |                                                  |
+-------------------------------------------------+--------------------------------------------------+
| | cd /var/opt/graylog/data                      | Copy current data to new disk                    |
| | sudo cp -ax * /mnt/tmp/                       |                                                  |
+-------------------------------------------------+--------------------------------------------------+
| | sudo diff -qr --suppress-common-lines \\      | Compare both folders.                            |
| |           /var/opt/graylog/data /mnt/tmp      | Output should be: `Only in /mnt/tmp: lost+found` |
+-------------------------------------------------+--------------------------------------------------+
| | sudo rm -rf /var/opt/graylog/data/*           | Delete old data                                  |
+-------------------------------------------------+--------------------------------------------------+
| | sudo umount /mnt/tmp                          | Mount new disk over data folder                  |
| | sudo mount /dev/sdb1 /var/opt/graylog/data    |                                                  |
+-------------------------------------------------+--------------------------------------------------+
| | sudo nano /etc/fstab                          | Make change permanent                            |
| | /dev/sdb1       /var/opt/graylog/data  ext4\  |                                                  | 
| |                          defaults       0 0   |                                                  |
| | sudo shutdown -r now                          |                                                  |
+-------------------------------------------------+--------------------------------------------------+

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

Configure Message Retention
===========================

Graylog is keeping a defined amount of messages. It is possible to decide whether you want to have a set storage size or a set time period of
messages. Additionally Graylog writes a so called Journal. This is used to buffer messages in case of a unreachable Elasticsearch backend.
To configure those settings use the set-retention command.

Retention by disk size::

  sudo graylog-ctl set-retention --size=3 --indices=10
  sudo graylog-ctl reconfigure

Indices would be rotated when they reach a size of 3Gb and Graylog would keep up to 10 indices, resulting in 30Gb maximum disk space.

Retention by time::

  sudo graylog-ctl set-retention --time=24  --indices=30
  sudo graylog-ctl reconfigure

Indices would be rotated after 24 hours and 30 indices would be kept, resulting in 30 days of stored logs.

Both commands can be extended with the --journal switch to set the maximum journal size in Gb::

  sudo graylog-ctl set-retention --time=24  --indices=30 --journal=5
  sudo graylog-ctl reconfigure

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

Upgrade Graylog
===============

Always perform a full backup or snapshot of the appliance before proceeding. Only upgrade
if the release notes say the next version is a drop-in replacement::

  wget https://packages.graylog2.org/releases/graylog2-omnibus/ubuntu/graylog_latest.deb
  sudo graylog-ctl stop
  sudo dpkg -G -i graylog_latest.deb
  sudo graylog-ctl reconfigure

Advanced Settings
=================

To change certain parameters used by `graylog-ctl` during a reconfigure run you can override all default parameters found `here <https://github.com/Graylog2/omnibus-graylog2/blob/1.2/files/graylog-cookbooks/graylog/attributes/default.rb>`_.
If you want to change the username used by Graylog for example, edit the file `/etc/graylog/graylog-settings.json` like this::

  "custom_attributes": {
    "user": {
      "username": "log-user"
    }
  }

Afterwards run `sudo graylog-ctl reconfigure` and `sudo graylog-ctl restart`. In this way you can change things like the path to the data
directory or memory settings for Graylog and Elasticsearch

Production readiness
====================

You can use the Graylog appliances (OVA, Docker, AWS, ...) for small production setups but please consider to harden the security of the box before.

 * Set another password for the default ubuntu user
 * Disable remote password logins in /etc/ssh/sshd_config and deploy proper ssh keys
 * Seperate the box network-wise from the outside, otherwise Elasticsearch can be reached by anyone

If you want to create your own customised setup take a look at our :ref:`other installation methods <installing>`.
