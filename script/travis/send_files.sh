#!/usr/bin/expect -f
set file [lindex $argv 0]
spawn scp $file travis@$env(SECRET_BUNDLE_IP):~/www
expect "password:"
send $env(SECRET_BUNDLE_PASS)
send "\r"
expect eof
