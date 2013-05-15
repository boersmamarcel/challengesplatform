#!/usr/bin/expect -f
set file [lindex $argv 0]
spawn scp $file travis@$SECRET_BUNDLE_IP:~/www
expect "password:"
send $SECRET_BUNDLE_PASS
send "\r"
expect eof
