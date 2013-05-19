#!/usr/bin/expect -f
# exp_internal 1 (For debugging)
set timeout 60
set file [lindex $argv 0]
spawn scp $file travis@198.199.77.172:~/www
expect {
  "key fingerprint" {send "yes\r"; exp_continue}
  "assword:" { send $env(SECRET_BUNDLE_PASS); send "\r" }
}

expect "100%"
expect eof
