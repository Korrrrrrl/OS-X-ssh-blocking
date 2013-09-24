#!/bin/sh

# ssh_blocked.sh
# Version 0.2.7
# Copyright (c) 2013 - Karl Kernaghan
# Email - kkernaghan7@gmail.com

# This script creates a log based on the output of /etc/sshd-fwscan.sh
# This script is called by /Library/LaunchDaemons/com.ssh_blocked.blocked_list.plist
# and is run every 5 minuets printing it's output to /var/log/ssh_blocked.log

echo "****************************" >> /var/log/ssh_blocked.log
date >> /var/log/ssh_blocked.log

echo "[Authentication error]" >> /var/log/ssh_blocked.log
grep authentication\ error /var/log/system.log >> /var/log/ssh_blocked.log

echo "[Failed login attempt - Invalid user]" >> /var/log/ssh_blocked.log
grep Invalid\ user /var/log/system.log >> /var/log/ssh_blocked.log

echo "[Blocked - 5 or more failed login attempts]" >> /var/log/ssh_blocked.log
ipfw list | grep deny >> /var/log/ssh_blocked.log
