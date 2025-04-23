#!/usr/bin/zsh
# .zshrc file
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
# Basic input

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jonwebb/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
bindkey -v

#increase the stacksize
ulimit -S -s hard
# --------------------------------------------------------------------------------
# Make vim the default editor and set github token

export EDITOR=nvim
# --------------------------------------------------------------------------------
# Set up debug info

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
# -------------------------------------------------------------------------------

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
# Install powerline status
#
POWERLINE_ZSH_CONTINUATION=1
POWERLINE_ZSH_SELECT=1
source /usr/share/powerline/bindings/zsh/powerline.zsh
# --------------------------------------------------------------------------------
# Install plugins

# Syntax highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
source ~/.config/zsh_scripts/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions.git
source ~/.config/zsh_scripts/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Web search
# git clone https://github.com/sinetoami/web-search.git
source ~/.config/zsh_scripts/plugins/web-search/web_search.plugin.zsh 
# --------------------------------------------------------------------------------
# Reference alias files

# Generic aliases
source ~/.config/zsh_scripts/.zsh_aliases

# Arch Linux aliases
source ~/.config/zsh_scripts/.zsh_arch_aliases

# git aliases
source ~/.config/zsh_scripts/.zsh_git_aliases
# ================================================================================
# SET UP PATH

export PATH="$PATH:/usr/bin/:/.local/include/:/usr/local/bin/:/home/jonwebb/.local/bin"

export VCPKG_ROOT=/home/jonwebb/Code_Dev/C++/vcpkg
export CMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
# ================================================================================
# ================================================================================
# eof
