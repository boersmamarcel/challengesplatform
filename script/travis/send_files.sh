#!/usr/bin/expect -f

spawn scp $1 travis@$SECRET_BUNDLE_IP:~/www
expect "password:"
send $SECRET_BUNDLE_PASS
send "\r"
expect eof
