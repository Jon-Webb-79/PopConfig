#!/usr/bin/bash
# .bash_profile file
# ================================================================================
# ================================================================================
# - Purpose: This file is read during the Bash login process.  i use this to
#            integrate all of the startup files
# 
# Source Metadata
# - Author:    Jonathan A. Webb
# - Date:      December 24, 2020
# - Version:   1.0
# - Copyright: Copyright 2021, Jon Webb Inc.
# ================================================================================
# ================================================================================
# Show Paths
#export PATH="$PATH:/usr/bin/:/.local/include/:/usr/local/bin/"

if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
#export PATH="$PATH:/usr/bin/:/.local/include/:/usr/local/bin/"
# ================================================================================
# ================================================================================
# eof
