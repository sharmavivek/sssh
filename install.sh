#!/bin/bash

# Get the latest file from github
wget $file_name

# Change the permisison to file to exe
chmod + $__file

# Creating conf files
mkdir -p /home/`$whoami`/.config/sssh
mkdir -p /home/`$whoami`/.config/sssh

# Put default entries in the above file.
echo "" > /home/`$whoami`/.config/sssh/sssh_profile
echo "" > /home/`$whoami`/.config/sssh/sssh_history


# Running the installer
# 
./$__file
mv $__file /usr/bin
rm


#/home/`$whoami`/.local/share/Trash
