#!/bin/sh

# sshd_fwscan.sh
# Modified by Karl Kernaghan - kkernaghan7@gmail.com
# This script is called by /Library/LaunchDaemons/com.ssh_block.script.plist
# every 15 seconds. 
# This script blocks ssh access after there are more than 5 failed access attempts.

if ipfw show | awk '{print $1}' | grep -q 20000 ; then
        ipfw delete 20000
fi

# This catches repeated attempts for both legal and illegal users
# No check for duplicate entries is performed, since the rule
# has been deleted.

awk '/sshd/ && (/Invalid user/ || /authentication error/) {try[$(NF)]++}
END {for (h in try) if (try[h] > 4) print h}' /var/log/system.log |
while read ip
do
        ipfw -q add 20000 deny tcp from $ip to any in
done
