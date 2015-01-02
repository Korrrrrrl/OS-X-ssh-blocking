#!/bin/bash

# Installer script for OS X ssh blocking and logging
# Version 0.1.3
# Copyright (c) 2013 - Karl Kernaghan
# Email - kkernaghan7@gmail.com
#
# To install run sudo ./install.sh
#
# System changes:
#
# sshd_fwscan.sh is placed in /etc
# This script is called by /Library/LaunchDaemons/com.ssh_block.script.plist
# every 60 seconds. This script blocks ssh access after there are more than
# 5 failed access attempts.
#
# ssh_blocked.sh is placed in /etc
# This script creates the format for the 
# log made in /var/log/ssh_blocked.log
#
# log_fix.pl is added to /Users/<user>/bin
# If ~/bin does not exist it will be created.
# This script is to be used after every reboot for the time being as I 
# have not found out why things don't work right after a reboot.
#
# com.ssh_block.script.plist and com.ssh_blocked.blocked_list.plist
# are added to /Library/LaunchDaemons. These are the .plist files that 
# allow this script and relating scripts to run when required. 
#
# The following line is added to /etc/newsyslog.conf
#
# /var/log/ssh_blocked.log                640  7     *    @T00  JN
#
# This entry allows the ssh_blocked.log to be created in /var/log in the 
# same fasion as the system.log. This log is set to rotate at 12:00AM 
# everyday and saves logs for 7 days.
#
# This install script will also run log_fix.pl to get you started without 
# a reboot. For now after each reboot you will need to run ~/bin/log_fix.pl
# if you've decided to find a way to run this during boot, please email me
# and let me know what you did. Thanks.

echo "Creating ~/bin if not already there"
mkdir bin ~/bin
echo "Copying log_fix.pl to ~/bin"
cp bin/log_fix.pl ~/bin
sleep 3
echo "Setting permissions"
chmod +x ~/bin/log_fix.pl
sleep 3

echo "Adding /var/log/ssh_blocked.log                640  7     *    @T00  JN to /etc/newsyslog.conf"
sleep 3
echo "/var/log/ssh_blocked.log                640  7     *    @T00  JN" >> /etc/newsyslog.conf
sleep 3

echo "Copying ssh_blocked.sh and sshd_fwscan.sh to /etc"
cp etc/ssh_blocked.sh /etc
cp etc/sshd_fwscan.sh /etc
sleep 3

echo "Setting permissions"
chmod +x /etc/ssh_blocked.sh
chmod +x /etc/sshd_fwscan.sh
sleep 3

echo "Copying com.ssh_block.script.plist and com.ssh_blocked.blocked_list.plist to /Library/LaunchDaemons"
cp Library/LaunchDaemons/com.ssh_block.script.plist /Library/LaunchDaemons
cp Library/LaunchDaemons/com.ssh_blocked.blocked_list.plist /Library/LaunchDaemons
sleep 3

echo "Running log_fix.pl"
~/bin/log_fix.pl
sleep 5

echo "All files are installed now. You should now see ssh_blocked.log in /var/log/"
