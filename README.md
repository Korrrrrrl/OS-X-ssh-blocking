OS-X-ssh-blocking
=================
(Currently not working on OS X Yosemite)

Blocks ssh login attempts after 5 attempts

OS X ssh blocking and logging

Copyright (c) 2013 - 2015, Karl Kernaghan

To install run sudo ./install.sh


System changes:

sshd_fwscan.sh is placed in /etc
This script is called by /Library/LaunchDaemons/com.ssh_block.script.plist
every 15 seconds. This script blocks ssh access after there are more than
5 failed access attempts.


ssh_blocked.sh is placed in /etc
This script creates the format for the log made in /var/log/ssh_blocked.log


log_fix.pl is added to /Users/\<user\>/bin
If ~/bin does not exist it will be created.
This script is to be run manually when issues with logging to var/log/ssh_blocked.log
are noticed. 

Note: Sometimes you may need to run log_fix.pl after a reboot. If you don’t see the blocked IP’s in the logs but do see the same IP address logged at least 5 times you can run this to fix the logs to display the IP as blocked. This issue is being worked on and seems to happen at random.


com.ssh_block.script.plist and com.ssh_blocked.blocked_list.plist
are added to /Library/LaunchDaemons. These are the .plist files that
allow this script and relating scripts to run when required.


The following line is added to /etc/newsyslog.conf to allow rotating of logs every 
day at 12:00AM. 

/var/log/ssh_blocked.log 640 7 * @T00 JN


This entry allows the ssh_blocked.log to be created in /var/log in the 
same fasion as the system.log. This log is set to rotate at 12:00AM 
everyday and saves logs for 7 days.


This install script will also run log_fix.pl to get you started without 
a reboot.

Note: After upgrading OS X /etc/newsyslog.conf is reset to defaults. 
You will have to add /var/log/ssh_blocked.log 640 7 * @T00 JN to 
/etc/newsyslog.conf to continue having rotating logs or run the install again.
