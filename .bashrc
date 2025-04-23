#!/usr/bin/bash 
# .bashrc file
# ================================================================================
# ================================================================================
# - Purpose: This file contains all information relevant to interactive
#            Bash sessions to include reference calls to the .bashrc file
#
# Source Metadata
# - Author:    Jonathan A. Webb
# - Date:      February 22, 2022
# - Version:   1.0
# - Copyright: Copyright 2022, Jon Webb Inc.
# ================================================================================
# ================================================================================
# Begin script


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Increase the stacksize
ulimit -S -s hard
# --------------------------------------------------------------------------------


# Make vim the default editor
export EDITOR=nvim
# --------------------------------------------------------------------------------
# Set up debug info

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
# --------------------------------------------------------------------------------

# Apply Colors to
# no = global default  fi = Normal File  di = directory
# ln = Symbolic Link   bd = block device cd = Character Device
# ex = executable file *.extension = Example *.mp3

# Colors to apply
# 31 = red            32 = green      33 = orange      34 = blue
# 35 = purple         36 = cyan       37 = grey        90 = dark grey
# 91 = light red      92 = light blue 93 = yellow      94 = light blue
# 95 = light purple   96 = turqoise   97 = white       40 = black background
# 41 = red background 42 = green back 43 = orange back 44 = blue back
# 45 = purple back    46 = cyan back  47 = grey back  100 = dark grey back
# 101 = light red back 103 = light green back  104 = light blue back 
# 105 = light purple back 106 = turqoise back 107 = white back 

# Applications
# 0 = default color 1 = bold 4 = underlined 5 = flashing
# 7 = reverse field 8 =  concealed
LS_COLORS='di=1;91:fi=0;97:ex=4;32'
export LS_COLORS
# --------------------------------------------------------------------------------
# Install Powerline-status


powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
# --------------------------------------------------------------------------------
# Spell Check

shopt -s cdspell

# Generic aliases
source ~/.config/bash_scripts/.bash_aliases

# Arch Linux aliases
source ~/.config/bash_scripts/.bash_arch_aliases

# git aliases
source ~/.config/bash_scripts/.bash_git_aliases
# --------------------------------------------------------------------------------
# Install aliases

