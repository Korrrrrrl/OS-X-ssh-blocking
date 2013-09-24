#!/usr/bin/perl

# log_fix.pl - To fix an issue where entries are not being written to /var/log/ssh_blocked.log
# after a reboot. I have not found a real fix yet and don't know why this happens after a reboot.
# Version 0.1.2
# Copyright (c) 2013 - Karl Kernaghan
# Email - kkernaghan7@gmail.com

# This package is free software and is released under the Perl Artistic License.
# You are free to modify and redistribute this package under these terms. If these
# are your intentions please read and understand the terms of the Perl Artistic License,
# you should have received a copy along with this package, if not, you may view it with
# one of the following commands; man perlartistic  or  perldoc perlartistic

# THIS PACKAGE WAS RELEASED AS THE STANDARD VERSION BY THE COPYRIGHT HOLDER AND IS
# PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

# Setting the message per second limit to 0 to prevent an issue where logs cannot be written.
system ("syslogd -mps_limit 0");

# Need to unload and reload the plist that runs the scripts after setting mps limit to 0
system ("launchctl unload /Library/LaunchDaemons/com.ssh_blocked.blocked_list.plist");
system ("launchctl load /Library/LaunchDaemons/com.ssh_blocked.blocked_list.plist");
# At this point all logs should be writing as expexted.
