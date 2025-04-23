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
