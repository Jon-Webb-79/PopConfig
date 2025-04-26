*************************
Post Installation Options
*************************
This section of documentation covers the process necessary to install all 
software used in my configuration.

Bash 
====
Most of the installations in this document will require the use of ``git``.  
If you did not install ``git`` in the previous sections, install it now with 
the following commands.

.. code-block:: bash 

   (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
   && sudo mkdir -p -m 755 /etc/apt/keyrings \
   && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
   && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
   && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
   && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
   && sudo apt update \
   && sudo apt install gh -y 

next we will install Git Hub Actions which can automate 
uploads of data to `Git Hub <https://github.com/>`_

.. code-block:: bash 

   sudo apt update 
   sudo apt install gh

Github Actions can be configured by typing 

.. code-block:: bash 

   gh auth login 

Follow the prompts.  A secure password will be required for this process.
This password can be generated in the ``settings`` window of Github assuming 
you have a Github account.

.. _ConfigFiles:

Config Files 
============
Once you have installed PopOS and configured Gnome, you are
ready to begin the installation of other packages.  In addition, we 
will also rely on the use of configuration files that can be downloaded
by the following command.

.. code-block:: bash

   mkdir ~/Code_Dev/ 
   mkdir ~/Code_Dev/OS
   git clone https://github.com/Jon-Webb-79/PopConfig.git ~/Code_Dev/OS/PopConfig

For the rest of these documents this will be referred to as the 
``config files directory``.

Update Terminal 
===============
PosOS/Cosmic comes with a capable terminal installed.
However, in this section lets install a better termianl titled 
``ghostty``.

.. code-block:: bash 

   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

In addtion lets install some basic fuzzy finder capability to work with the 
terminal 

.. code-block:: bash 

   sudo apt update
   sudo apt install fzf
   sudo apt install bat

Next we need to create some relevant directories and move some configuration files 
from our ``config files directory`` directory we downloaded from Github eariler.

.. code-block:: bash 

   cp ~/Code_Dev/OS/PopConfig/.config/ghostty ~/.config/

At this point you can open ``ghostty`` and it is configured correctly.

Install snapd
=============
SnapD is used for the installation of several legacy ubuntu packages.  SnapD 
can be installed through the following command;

.. code-block:: bash 

   sudo apt update 
   sudo apt install snapd

.. _dead-snakes:

Install Dead Snakes 
===================
The Ubuntu `apt`` package manager has most packages that a user might need.  However,
`apt` is not updated frequently and as a result, many packages in the `apt`
repository are out od date.  The Dead Snakes repository helps merge modern 
libraries with the `apt` repository.  This can be installed with the following 
command.

.. code-block:: bash 

   sudo apt install software-properties-common
   sudo add-apt-repository ppa:deadsnakes/ppa

Install NeoVim 
==============
Many future installations will require a text editor, so it makes sense to 
install NeoVim now so it is available for the modification of future configuration 
files.  First we need to move some files from our ``config files directory`` with the 
following command.

.. code-block:: bash 

   cp ~/Code_Dev/OS/PopConfig/.config/nvim ~/.config/

In order to ensure that some of the files do not cause an issue, we will temporarily 
move the ``after`` directory to the Desktop with the following command.

.. code-block:: bash 

   mv ~/.config/nvim/after ~/Desktop/

Next we need to install the NeoVim package manager ``Packer``.

.. code-block:: bash 

   git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

Next we will install NeoVim; however, this step relies on the :ref:`Dead Snakes <dead-snakes>` 
package to work correctly.

.. code-block:: bash 

   sudo add-apt-repository ppa:neovim-ppa/unstable
   sudo apt-get update 
   sudo apt-get install neovim 

Close your terminal and reopen it to ensure the neovim install is recognized 
by the session.  Open the ``packer.lua`` file in the ``.config`` directory with 
NeoVim using the following command.  

.. code-block:: bash 

   nvim ~/.config/nvim/lua/core/packer.lua

.. note:: This will lead to the display of many errors that can be ignored.  If errors to appear, press enter until the errors dissapear.

Within the NeoVim session enter into the command mode by pressing `Shift :`.  When in 
command mode enter `so` and then depress enter.  Next enter command mode again and 
type ``PackerSync`` then hit enter.  This should start the process of downloading all 
packages which will resolve any errors.  Next move the ``after`` file back to the appropriate
directory.

.. code-block:: bash 

   mv ~/Desktop/after ~/.config/nvim/ 

Neovim should not be properly configured.  Any file can be opened with the ``nvim``
command.

Hostname 
========
Next we will configure the hostname with the following command 

.. code-block:: bash 

   hostnamectl set-hostname hostname 

We can now verify the hostname is set correctly with the command;

.. code-block:: bash 

   cat /etc/hosts 

Finally we need to ensure the hostname is part of hte network configuration.  Using 
NeoVim lets update the hots file 

.. code-block:: bash 

   nvim /etc/hosts 

Ensure the file configuration looks like this but replace each ``hostname``
with your actual hostname.

.. code-block:: bash 

   127.0.0.1  localhost
   ::1        localhost
   127.0.1.1  hostname.localadmin hostname

Install Shell Environments
==========================
This section will walk a user through the process of setting up environments 
for Bash or ZShell scripting.

Bash 
----
PopOS comes with Bash pre-installed; however, it needs to be configured.  First 
we will set it up with a Powerline satus bar with the following terminal command.

.. code-block:: bash 

   sudo apt install powerline:w 
   sudo cp -r ~/Code_Dev/OS/PopConfig/powerline /usr/share/

Next we need to move the alias files from the ``config files directory`` with the 
following command.

.. code-block:: bash 

   cp -r ~/Code_Dev/OS/PopConfig/.config/bash_scripts ~/.config/ 

Next we need to bring over the hidden bash files with the following commands.

.. code-block:: bash 

   cp ~/code_Dev/OS/PopConfig/.bashrc ~/. ~/.bashrc 
   cp ~/Code_Dev/OS/PopConfig/.bash_profile ~/.bash_profile  

Next update your terminal with the following command.

.. code-block:: bash 

   source ~/.bashrc

ZShell 
------
While Bash is a great shell scripting environment, ZShell has slowly overtaken 
it with modern capabilities.  Unfortunately ZShell does not come pre-installed 
with PopOS and can be installed with the following command.

.. code-block:: bash 

   sudo apt install zsh 

Just like the Bash set up process we will need to execute the following commands 
to import our alias files and hidden files.  This will also install a powerline 
status bar for the configuration.  If you already installed powerline as part 
of the Bash installation you can skip those commands in this section.

.. code-block:: bash 

   sudo apt install powerline:w
   cp -r ~/Code_Dev/OS/PopConfig/.config/zsh_scripts ~/.config/
   cp ~/Code_Dev/OS/PopConfig/.zprofile ~/.zprofile 
   cp ~/Code_Dev/OS/PopConfig/.zshrc ~/.zshrc
   sudo cp -r ~/Code_Dev/OS/PopConfig/powerline /usr/share/

Next we need to switch our shell from Bash to ZShell with the following command.
The value of ``username`` in the below command should be exchanged for your actual 
username.

.. code-block:: 

   chsh -s /usr/bin/zsh username

Next we need to restart our computer for the changes to fully take extent.  Once 
you log back into your account zshell will be the default configuration.

Install tmux 
============
Tmux is the premier terminal emulator that allows a user to run a shell in the 
background.  To install tmux enter the following commands into your terminal.

.. code-block:: bash 

   sudo apt install tmux 
   git clone https://github.com/tmux-plugins/tpm/tpm ~/.tmux/plugins/tpm
   vp ~/Code_Dev/OS/PopConfig/.tmux.conf ~/.tmux.conf 
   tmux source ~/.tmux.conf

Next type ``tmux`` into your terminal to verify that tmux is working correctly.
To exit type ``tmux kill-session``.

Install Software Development Environments 
=========================================
This section describes the process for installing C, C++, and Python programming 
languages to include a tmux based integrated developer environment (IDE).

Install Python 
--------------
PopOS comes pre-installed with an older version of Python, and unfortunately the  
``apt`` repository does not maintain up to date versions of Python.  For this 
reason we will use the dead snakes repository to install python.  If you have not 
yet installed deadsnakes enter the following commands into your terminal.

.. code-block:: bash 

   sudo apt install software-properties-common 
   sudo add-apt-repository ppa:deadsnakes/ppa 
   sudo apt update 

Next lets verify the version of Python already installed with the following command.

.. code-block:: bash 

   python3 --version 

Next lets check to see if the version we want to download is available with the  
following command where XX should be the version of python you are looking for.

.. code-block:: bash 

   sudo apt-cache policy python3.XX

If the version is available type the following command to download the required 
version.

.. code-block:: bash 

   sudo apt install python 3.XX 

At this point the required version of Python has been installed but it will not 
be listed if you type 

.. code-block:: bash 

   python3 --version 

and the following command will not be recognized at all 

.. code-block:: bash 

   python --version 

We will not configure the term ``python`` to be set to the downloaded version and 
``python3`` will be set to the version that existed with the PopOS install.  In these 
commands ``XX`` represents the recently downloaded version and ``YY`` represents the 
initial version.

.. code-block:: bash 

   sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.XX 1 
   sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.YY 2 

Next type the following command which will prompt you for the new default version.

.. code-block:: bash 

   sudo update-alternatives --config python 

Finally lets install the Python package manager ``pip``.

.. code-block:: bash 

   sudo apt install python3-pip

Install Poetry 
--------------
Poetry is one of the more modern Python package managers to compliment ``pip``.
Before we can begin the Poetry install we need to install ``pipx`` with the following 
commands.

.. code-block:: bash 

   sudo apt install pipx 
   pipx ensurepath 

Next we can install Poetry with the following command.

.. code-block:: bash 

   pipx install poetry 

Finally we will set up Poetry to ensure the Python virtual environments are 
managed in project and not stored in the home directory.

.. code-block:: bash 

   poetry config virtualenvs.in-project true 

Install C and C++ Compilers 
---------------------------
The following commands will install ``gcc`` and ``clang`` compilers.

.. code-block:: bash 

   sudo apt install clang 
   sudo apt install gcc 

The following set of commands will use deadsnakes to install CMake 

.. code-block:: bash 

   sudo apt update
   sudo apt install -y apt-transport-https ca-certificates gnupg software-properties-common wget

   wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | \
   gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg > /dev/null

   echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | \
   sudo tee /etc/apt/sources.list.d/kitware.list > /dev/null
    
   sudo apt update
   sudo apt install cmake

Finally we will instal CMocka, a comman unit test environment for the C programming 
language. 

.. code-block:: bash 

   sudo apt update 
   sudo apt install libmocka-dev

Set up IDE 
----------
Finally we need to move over the last set of files from the ``config files directory``
that enables us to use our Integrated Developer Environment.  Type the following  
commands into your temrinal.

.. code-block:: bash 

   cp -r ~/Code_Dev/OS/PopConfig/.config/py_files ~/.config/py_files 
   cp -r ~/Code_Dev/OS/PopConfig/.config/c_files ~/.config/c_files 
   cp -r ~/Code_Dev/OS/PopConfig/.config/c++_files ~/.config/c++_files

With these files transferred you can now take full advantage of the aliases 
maintained in the ``~/.config/bash_scripts`` or ``~/.config/zsh_scripts`` file 
depending on whether you are using Bash or ZShell.  In either case, you should 
inspect the file to ensure you know the range of capabilities at your fingertips.

For example the command 

.. code-block:: bash 

   create_py_dir 

Will prompt the user to enter the name of a Python directory and then it will 
create the directory structure, install the required development packages using  
Poetry to a local virtual environment and then open an Integrated Developer 
Environment using NeoVim and tmux.  The IDE can be closed with the following 
command.

.. code-block:: bash 

   tmux kill-session 

In addition, the IDE for that directory can be reopened with the command 

.. code-block:: bash 

   open_py_ide directory_name 

There are also commands to create python files and test files that are pre-populated 
with header information.  Similar commands exist for the C and C++ programming 
languages.

Install pdfLaTeX 
================
LaTeX is one of the best word processors for well formatted documents.  LaTeX 
can be installed with the following set of commands.

.. code-block:: bash 

   sudo apt-get install texlive-latex-base 
   sudo apt-get install texlive-fonts-recommended 
   sudo apt-get install texlive-fonts-extra 

Install Misc Packages 
=====================
The following commands can be used to install misc packages for use in PopOS.

.. code-block:: bash 

   sudo apt install notepadqq
   sudo apt install tree
   sudo apt install htop
   sudo apt install rsync
   sudo apt install fail2ban
   sudo apt install xclip
   sudo apt install libreoffice
   sudo apt install neofetch
   sudo apt install cron

We also need to install a free PDF Editor with the following instructions.
First, navigate to the `Master PDF Editor <https://code-industry.net/masterpdfeditor/>`_
web site.  Next download the debian version of MasterPDFEditor.  Finally open the terminal 
and navigate to the ``Downloads`` directory.  Once in the ``Downloads`` directory 
enter the following command into the terminal, where ``package_name`` represents 
the name of the recently downloaded MastPDFEditor package as shown in the ``Downloads`` 
directory.

.. code-block:: bash 

   sudo apt install package_name

System Backup 
=============
The following command can be used to set up a system level backup utility 
that utilyzes the ``rsync`` utility.

.. code-block:: bash 

   sudo cp ~/Code_Dev/OS/PopConfig/core_backup /usr/local/bin/core_backup 

Once the file is transferred you should open it with vim to make some changes.
Since this is now in a system directory, you will need to use the ``sudo`` command 
to save any changes.  Within this file you will see a variable titled ``ENABLED``
which is defaulted to ``true``.  This ensures that the file is active for automation.
if set to ``false`` no backups will be allowed.  This is a flag that you may want 
to toggle to ``false`` in time frames where the backup hard drive is not connected.
The variable titled ``BACKUP_DRIVE_LABEL`` is defaulted to ``BackupDrive`` but you will 
want to replace this with the name of your backup drive.  A retention period is 
also listed which you can change at your discretion.

Once this file is moved to the ``/usr/local/bin`` directory you can initiate 
a system backup from the terminal with the following command.

.. code-block:: bash 

   core_backup 

.. note:: In its current configuraiton, this script is run manually

Now lets automate the system backup time frame with the following command.

.. code-block:: bash 

   sudo nvim /etc/systemd/system/core_backup.service

Once in neovim, enter the following data and save as well as close the file.

.. code-block:: bash 

   [Unit]
   Description=Core system backup (rsync snapshot)
   Wants=core_backup.timer

   [Service]
   Type=oneshot
   ExecStart=/usr/local/bin/core_backup

Next create the timer file.

.. code-block:: bash 

   sudo nvim /etc/systemd/system/core_backup.timer

Enter the following data, then save and close the file.

.. code-block:: bash 

   [Unit]
   Description=Run core system backup daily

   [Timer]
   OnCalendar=daily
   Persistent=true

   [Install]
   WantedBy=timers.target

Reload and enable the timer 

.. code-block:: bash 

   sudo systemctl daemon-reexec
   sudo systemctl daemon-reload
   sudo systemctl enable --now core_backup.timer

Next, verify the timer is active.

.. code-block:: bash 

   systemctl list-timers core_backup.timer

Based on the hardware configuration, this set up can sometimes prevent the system 
from waking up following a prolonged inactive period.  If this is the case 
you will need to deactivate the timer and manually run the backup with 
the command 

.. code-block:: bash 

   sudo core_backup 

Manage Memory 
=============
After using a computer for a while it is often the case that the ``Downloads`` folder 
will become overburdened with data that has not been cleaned up.  To help manage 
this we are going to create a ``~/scripts`` directory and populate it with a bash 
script that can be manually run.

First verify if a directory titled ``~/scripts`` already exists 

.. code-block:: bash 

   ls ~/scripts 

if it does not exist,create it.

.. code-block:: bash 

   mkdir ~/scripts 

Next move the ``mngDownloads.sh`` script from the ``config files directory``.

.. code-block:: bash 

   cp ~/Code_Dev/OS/PopConfig/mngDownloads.sh ~/scripts/

Now you can navigate to the script and open it with a text editor.  Look for 
the variable ``period`` in the script.  This variable can be set to ``1HR``,
``1D``, ``1WK``, ``2WK``, or ``1MO``, representing 1 hour, 1 day, 1 week,
2 weeks, or 1 month, as the period between now and the last time the contents 
of the Downloads directory was deleted.  Each time the directory is delete it 
will log the event in the ~/logfiles/downloads.log file.  

.. note:: This script in its current configuration is run manually, but ensure that 
   it is an executable by running the command ``chmod +x mngDownloads.sh``

In addition, the user can also manually manage the cache memory with the following  
commands.  The first command will determine how much memory is being consumed in the 
cache and display it to the user.  The second command will delete the cache.

.. code-block:: bash 

   du -sh ~/.cache/ 
   rm -rf ~/.cache/*

However, deleting the entire cache can temporarily slow your computer down by 
deleting files that store states for the opening and execution of programs.  A script 
titled ``cleanCache.sh`` exists in the ``config files directory`` that can be used 
to only delete cache files older than a certain date or that are larger than a 
certian size.  Lets move that script to the ``scripts`` directory.

.. code-block:: bash 

   cp ~/Code_Dev/OS/PopConfig/cleanCache.sh  ~/scripts/

The user can open the file with a text editor and look for the variables 
``MIN_SIZE`` and ``OLDER_THAN_DAYS`` and set those varibales to a desired 
value.  Once moved this file can be executed manually.

.. note:: This script in its current configuration is run manually, but ensure that 
   it is an executable by running the command ``chmod +x cleanCache.sh``

Next we are going to move a crontab file to the appropriate local directory and 
then activate cron.  This will run the ``mngDownloads.sh`` once every hour.  In each 
iteration it will check the time to determine if it needs to purge the ``Downloads`` directory.
This will also run the ``cleanCache.sh`` file once every 2 days; however, ther frequency 
for cron tab runs can be changed within the file.

.. code-block:: bash 

   crontab -e 

The above command will open the local crontab.  You can then pase the following 
data to the cron tab using vim.  Be sure to replace each instance of ``username``
with your actual username.

.. code-block:: bash 

   # Crontab for username
   # Run mngDownloads.sh every hour
   0 * * * * /home/username/scripts/mngDownloads.sh

   # Run cleanCache.sh every 2 days at 3:00 AM
   0 3 */2 * * /home/username/scripts/cleanCache.sh

Then type the following command to ensure your tasks are running in cron.

.. code-block:: bash 

   crontab -l

At this point also run the following command to ensure that cron is running.

.. code-block:: bash 

   systemctl status cron 

If it is not running, enter these two commands. 

.. code-block:: bash 

   sudo systemctl start cron 
   sudo systemctl enable cron

Then check the status again.

