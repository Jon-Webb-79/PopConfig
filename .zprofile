#!/usr/bin/zsh
# .zprofile file
# ================================================================================
# ================================================================================
# - Purpose: This file is read during the Bash login process.  i use this to
#            integrate all of the startup files
# 
# Source Metadata
# - Author:    Jonathan A. Webb
# - Date:      March 08, 2022
# - Version:   1.0
# - Copyright: Copyright 2022, Jon Webb Inc.
# ================================================================================
# ================================================================================
# Show Paths
#export PATH="$PATH:/usr/bin/:/.local/include/:/usr/local/bin/"
if [ -n "$ZSH_VERSION" -a -n "$PS1" ]; then
    # include .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
    . "$HOME/.zshrc"
    fi
fi

#export PATH="$PATH:/usr/bin/:/.local/include/:/usr/local/bin/"
# ================================================================================
# ================================================================================
# eof
