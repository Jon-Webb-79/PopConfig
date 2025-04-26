***************
Troubleshooting
***************
This Section of the document will describe how to use and troubleshoot 
several utility applications that are available on PopOS.

Cron Tab
========
The Cron tab can be used to schedule actions on your computer.  More information 
can be found on the cron tab from the 
`Arch Linux Cron Wiki <https://wiki.archlinux.org/title/cron>`_. 
First we need to see if Cron is installed with the following command.

.. code-block:: bash 

   which cron 

If the above command does not return anything, then we need to install 
cron with the following command.

.. code-block:: bash 

   sudo apt update 
   sudo apt install cron 

The cron tab has the folllowing format.

.. code-block:: bash 

   # Crontab file for jonwebb
   # https://www.youtube.com/watch?v=IPLFpqPAn5A for examples
   # https://www.youtube.com/watch?v=QZJ1drMQz1A for more examples
   # |-------------- minute (0 -59)
   # | |---------------- hour (0 -23)
   # | | |------------------ day of month (1 - 31)
   # | | | |-------------------- month (1 -12)
   # | | | | |---------------------- day of week (0 - 6) (Sunday to Saturday)
   # | | | | |                                           7 is also Sunday on some systems
   # | | | | |
   # | | | | |
   # * * * * *

The cron files are stored in ``/var/spool/username``.  The root cron files 
are stored in ``/etc/cron.d``.

Cron can be set up to instantiate every time your computer starts with the  
following commands. 

.. code-block:: bash 

   sudo systemctl start cron 
   sudo systemctl enable cron 

You can check the status of ``cron`` with the following command.

.. code-block:: bash 

   sudo systemctl status cron 

The current cron jobs can also be listed with the following command.

.. code-block:: bash 

   crontab -l

Fail2Ban Configuration
======================
Fail2ban is a utility that helps manage the security of our system.  More 
information on Fail2ban can be found at the 
`Arch Linux Fail2Ban Wiki <https://wiki.archlinux.org/title/fail2ban>`_
#. First check to see if fail2ban is already installed

   .. code-block:: bash 

      which fail2ban 

   If the response to the above command returns nothing, then fail2ban is not installed.
   The command to install fail2ban is shown below;

   .. code-block:: bash 

      sudo apt install fail2ban

#. Transition to root user 

   .. code-block:: bash 

      su 

   Enter your root password when prompted.

#. Edit the fail2ban file 

   .. code-block:: bash 

      cd /etc
      nvim fail2ban/fail2ban.conf 

#. Set ``dpurge`` to ``7d``, which will purge the banned list once every 7 days.

#. Close and save the ``fail2ban.conf`` file.

#. Copy the ``fail2ban.conf`` file to ``fail2ban.local`` 

   .. code-block:: bash 

      cp fail2ban/fail2ban.conf fail2ban/fail2ban.local 

#. Configure ``jail.conf``

   .. code-block:: bash 

      nvim /fail2ban/jail 

   Find ``# ignoreip`` and uncomment it.  Write the ip address of any addresses 
   that you do not want banned for incorrectly logging in.

   Set ``findtime`` to ``7m``
   Set ``maxretry`` to ``3``
   Set ``bantime`` to ``1h``
   Set ``send and recieve e-mails`` to your preferred e-mail address for notifications
   Enable all relevant attack vectors

#. Close the ``jail.conf`` file.

#. Copy ``jail.conf`` to ``jail.local``

   .. code-block:: bash

      cp fail2ban/jail.conf fail2ban/jail.local

rsync
=====
Rsync is a utility that allows a user to transfer information from one 
hard drive to another.  This is useful for conducting backups and for 
transmitting information over an ssh socket.  More information on the 
rsync utility can be found at the 
`Arch Linux rsync Wiki <https://wiki.archlinux.org/title/rsync>`_

#. If ``rsync`` is not installed, install it with the following command.

   .. code-block:: bash 

      sudo apt install rsync 

#. The rest of this section will be predicated on the process of backing 
   up the home directory to a thumb drive.  For the sake of this section 
   assume the backup drive is located at ``/run/media/username/drive_1``.

#. The first time backing up the home directory, use the following command.

   .. code-block:: bash 

      rsync -arvn --dry-run home/ /run/media/username/drive_1

   The above command will only test to ensure that you are backing up the right 
   information, but will not back it up.

#. Assuming the above command was successful then proceed with the following 
   command 

   .. code-block:: bash 

      rsync -arv /home/username /run/media/username/drive_1

   Every time after this, run 

   .. code-block:: bash 

      rsync -arv --delete /home/username/ /run/media/username/drive_1 

   The above command will delete files on the tumb drive, which were in a
   previous backup, but deleted from the primary server since the last 
   backup.

SSH Configuration 
=================
SSH is a utility that allows us to log into one computer or server from 
another computer or server. This section will walk a reader through the 
process of configuring ssh on the client and server side.  More information 
can be found on the 
`Arch Linux ssh Wiki <https://wiki.archlinux.org/title/OpenSSH>`_

Client Side 
-----------
#. Verify that openssh is installed 

   .. code-block:: bash 

      which ssh 

   if the above command returns nothing, then openssh is not installed and needs 
   to be installed 

   .. code-block:: bash 

      sudo apt install openssh-server 

#. Verify that you can ssh into the server of interest, then exit the server. 
   This assumes that the reader knows the ip and port number of the server they 
   are logging into.  In addition, the user can ommit the < and > symbols 
   when they enter the appropriate information.  If you are trying to set up the 
   ability to ssh into a fresh install, the port number is likely 22.  This 
   command should prompt the user for a password given to them by the server 
   administratory.

   .. code-block:: bash 

      ssh -p <portnumber> <username>@<ipaddress>

   Assuming the reader was succesful in ssh'ing into the server, then exit the 
   server by simultaneously pressing the Control and d keys.

#. Generate public/private key set if the server allows you to create one on 
   your computer and send it to the server.

   #. If a ``.ssh`` directory does not exist in your home directory, then create;

      .. code-block:: bash 

         mkdir ~/.ssh

   #. Change to the ``.ssh`` directory.

      .. code-block:: bash 

         cd ~/.ssh 

   #. Generate the ssh key with the following command.  They keytape can be 
      ``rsa``, ``dsa``, ``ecdsa``, or ``ed25519``.  The defauly keytype is 
      ``rsa`` but I prefer to use ``ed25519``.  The description should be one word.

      .. code-block:: bash 

         ssh-keygen -t <keytype> -C <brief_description>

   #. Rename the key to something descriptive of its use.  Renaming should include 
      the path length when prompted.

   #. Give the key a passphrase, preferable different than the password used in 
      step 2.

   #. The completion of the above commands should generate a public ``.pub``
      password file and a private password file.  Never expose the private key.

#. Send the publick key to the server

   #. Send the key to the server 

      .. code-block:: bash 

         ssh-copy-id -i ~/.ssh/<key_name.pub> <username>@<ipaddress>

   #. Enter the password 

   #. Verify the key works 

      .. code-block:: bash 

         ssh -p <portnumber> <username>@<ipaddress>

      In the server, ensure that you are in the ``.ssh`` directory and verify that 
      the authorized key file contains your password.

   #. Exit by depressing ``Control-d``

#. Associate the key on your computer with the server 

   #. Associate key 

      .. code-block:: bash 

         ssh -i ~/.ssh/<private_key> <username>@<ipaddress> 

      This should require the passphrase to be entered, not the password 

   #. Connect 

      .. code-block:: bash 

         ssh -p <portnumber> <username>@<ipaddress> 

      Type the passphrase, not the password 

#. Configure the computer to remember the passphrase 

   #. Determine if the ssh-agent is turned on 

      .. code-block:: bash 

         ps aux | grep ssh-agent

      If the output has th eword grep in it, it is not active.

   #. Enable ssh-agent if it is not running.

      .. code-block:: bash 

         eval "$(ssh-agent)"

      Repeat step the previous to ensure ssh-agent is running.

   #. Add key to ssh-agent 

      .. code-block:: bash
      
         ssh-add ~/.ssh/<private_key_name>

      Enter the passphrase.  ssh into the client to see if it requests they
      passphrase.  If it asks for the passphrase then the reader made a mistake 
      and should repreat the previous step.  Control-d to leave the server

#. Set up the config file 

   #. cd into the .ssh directory 

      .. code-block:: bash 

         cd ~/.ssh 

   #. Create a file titled ``config``

      .. code-block:: bash 

         nvim config 

      Add the following information to the config file 

      .. code-block:: bash 

         Host <user_defined_short_name> 
         Hostname <ip_address>
         Port <portnumber> 
         User <username> 
         IdentityFile ~/.ssh/<private_key_name> 

#. From now on you can log onto the server by typing 

   .. code-block:: bash 

      ssh <user_defined_short_name>

Server Side 
-----------
#. Verify that the server ssh client exists.

   .. code-block:: bash 

      which sshd 

   If the server side client does not exist, then install it.

   .. code-block:: bash 

      sudo pacman -S ssh-server 

#. Check the status of sshd 

   .. code-block:: bash 

      systemctl status sshd 

#. If necessary we can restart, stop, or enable sshd 

   .. code-block:: bash 

      systemctl restart sshd 
      systemctl stop sshd 
      systemctl start sshd 
      systemctl enable sshd 

#. Modify the ``ssh_config`` file.

   #. ``cd`` to the appropriate directory 

   .. code-block:: bash 
       
      cd /etc/ssh 
   
      **WARNING** Do not delete any files in this directory 

   #. Open the config file 

   .. code-block:: bash 

       sudo nvim sshd_config 

   #. If ``Port`` is set to 22, set it to any other larger number.  You will need 
      to ensure this is reflected on the client side config file.

   #. Add specific users after the ``Allowusers`` keyword

   #. Reset ``PermitRootLogin`` from ``prohibit-password`` to ``no``.

      **NOTE:** Ensure there is a sshkey relationship between all clients before doing this.

   #. Restart and re-enable the ssh server using the previous commands.

#. Lock down the server side files.

   #. Lock down the ``authorized_keys`` file. 

   .. code-block:: bash 

      chmod 400 ~/.ssh/authorized_keys

   #. Set an immutable bit on the ``authorized_keys`` file.  This may require 
      super user privileges

   #. chattr +i ~/.ssh/authorized_keys 

   #. Repeat the previous step on the ``.ssh`` directory 

   .. code-block:: bash 

      chattr +i ~/.ssh 

   #. Immutable bits can be un-set with the following commands 

   .. code-block:: bash 

      chatter -i ~/.ssh/authorized_keys 
      chattr -i ~/.ssh 

#. Login attempts can be viewed with the ``journalctl`` command.

   .. code-block:: bash 

      journalctl --since "5 min ago"

USB
===
This section will describe how to locate and modify a drive connected 
via a USB port.

Determine Mount Location 
------------------------
To determine where a drive is located, type the following command 

.. code-block:: bash 

   df -l

For this example lets assume the drive is located at ``/dev/sda1``.  In 
order to unmount the drive type 

.. code-block:: bash 

   sudo umount /dev/sda1 

Also to format the drive to a Linux format if necessary type the following;

.. code-block:: bash 

   sudo mkfs.ext4 /dev/sda1 

Rename the Drive 
----------------
In order to rename a drive we need to ensure that ``e2label`` is installed.

.. code-block:: bash 

   which e2label 

If it is not installed, then install ``e2label`` 

.. code-block:: bash 

   sudo apt install e2fsprogs

Finally we can re-label the drive with the following command 

.. code-block:: bash 

   sudo e2label /dev/sda1 user_defined_drive_name

NVIDIA Driver Issues 
====================
Unfortunately some NVIDIA drivers were not sufficiently tested for compatibility 
with the 6.12 Linux Kernal.  This sometimes causes issues when updating firmware right 
after installing PopOS.  In order to fix this we will need to first install a fresh 
version of PopOS.  To do this, shut down your computer and restart it.  As soon as 
you restart your computer, repetitively depress the F12 key to enter into Bios mode.

Once in Bios mode, select the ``recovery mode`` option.  Follow the prompts to reinstall 
a fresh version of PopOS.  Once a fresh installation has been added, shut the computer 
down again, and one more time enter into the ``recovery mode`` with the F12 key.  
Start the process of reinstalling PopOS; however, this time continue to select 
the default options until you get to a menu option for clean install or Refresh install 
options.  On the bottom left you will see another option for Demo Mode.  Click 
the Demo Mode option.  At this point ensure you have a hard link connection to the 
internet in case wireless drops.

Open a terminal and type the following command;

.. code-block:: bash 

   lsblk 

This should display a list of connected drives.  Assuming you are using an NVME 
drive, you should see an option like ``/dev/nvme0n1p3``.  Make sure this exists 
before proceeding any further.

Unencrypt Disk 
--------------
This section is predicated on the fact you have an encrpted disk.  We need to unlock 
the encrypted disk with the following command.

.. code-block:: bash 

   sudo cryptsetup luksOpen /dev/nvme0n1p3 cryptdata

Next we need to check our logical volumes with the following commands.

.. code-block:: bash 

   sudo lvscan
   sudo vgchange -ay

This should yield a volume with the designator ``data-root``.

Next mount this drive 

.. code-block:: bash 

   sudo mount /dev/mapper/data-root /mnt

Mount the efi partitian 

.. code-block:: bash 

   sudo mount /dev/nvme0n1p1 /mnt/boot/efi

   for i in /dev /dev/pts /proc /sys /run; do sudo mount -R $i /mnt$i; done
   sudo chroot /mnt

Next exit ``chroot`` and reboot 

.. code-block:: bash 

   exit 
   reboot 

Finally run these commands to purge your system of any previous driver information 
and reinstall the correct data.

.. code-block:: bash 

   sudo apt purge ~nnvidia
   sudo dpkg --configure -a
   sudo apt purge system76-driver-nvidia
   sudo dpkg --configure -a
   sudo apt install system76-driver-nvidia
   sudo dpkg --configure -a

   sudo apt clean
   sudo apt update
   sudo dpkg --configure -a
   sudo apt install -f
   sudo apt full-upgrade
   sudo apt autoremove --purge
    
Syncthing 
=========
Syncthing is a file service that allows you to sync computers to a central server.
While it is preferable to have a central server for this service, you can also 
use a desktop of laptop to act as the central server.  To install, navigate 
to the `Syncthing Downloads <https://apt.syncthing.net/>`_ web page.  The instructions 
below should mirror the instructions on the web site.

First verify the package authenticity with the following command.

.. code-block:: bash 

   sudo mkdir -p /etc/apt/keyrings
   sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

Next add the stable channel to your apt sources 

.. code-block:: bash 

   echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

Next install the updated repository 

.. code-block:: bash 

   sudo apt update
   sudo apt install syncthing

.. note:: The web site for syncthing asks you to use ``apt-get``, but this is not necessary and you can just use ``apt``

Verify that syncthign is installed with a ``which`` command.

.. code-block:: bash 

   which syncthing

Next lets set up systemd to automate syncthing.  Navigate to the 
`syncthing GitHub <https://github.com/syncthing/syncthing/tree/main/etc/linux-systemd>`_
web page.  Navigate to the system/syncthing@.service document and open it.  Download the 
contents with the command 

.. code-block:: bash 

   wget https://raw.githubusercontent.com/syncthing/syncthing/refs/heads/main/etc/linux-systemd/system/syncthing%40.service 
   sudo chown root: syncthing@.service 
   sudo mv syncthing@.service /etc/systemd/system/
   sudo systemctl daemon-reload

Verify that syncthing is running on systemctl.  Replace ``username`` with your actual username

.. code-block:: bash 

   systemctl status syncthing@username

If it is not running, enable it with the following command;

.. code-block:: bash 

   sudo systemctl enable syncthing@username 
   sudo systemctl start syncthing@username

You can again check the status to ensure it is now running.
