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
from our ``PopConfig`` directory we downloaded from Github eariler.

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
TBD
