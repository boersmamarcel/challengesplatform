#!/bin/bash

k=false # Kill previous rails server
s=false # Run rails server
b=false # Run bundle
d=false # Run database reset
h=false # Help
c=false # Run cucumber tests

while getopts ":ksbdhc" opt; do
  case $opt in
    k) k=true >&2 ;;
    s) s=true >&2 ;;
    b) b=true >&2 ;;
    d) d=true >&2 ;;
    h) h=true >&2 ;;
    c) c=true >&2 ;;
    \?)
      echo "Invalid option: -$OPTARG"
      echo "$0 -h for help"
      exit 1
    ;;
  esac
done

if $h; then
  echo "Call $0 to reset the environment."
  echo "     -k to kill any servers (port 3000 tcp only)"
  echo "     -b to execute bundle"
  echo "     -d to reset database"
  echo "     -c to run cucumber tests"
  echo "     -s to execute rails s when done resetting"
  echo "     -h you're looking at it (and terminate)"
  exit 0
fi

if $k; then
  echo "Killing server on TCP port 3000"
  fuser -k 3000/tcp
fi

if $b; then
  echo "Running bundle"
  bundle install
fi

if $d; then
  echo "Resetting database"
  rake db:reset
  rake db:test:prepare
fi

if $s; then
  echo "Starting rails server as a background process"
  echo "Running on http://localhost:3000"
  echo "Call $0 -k to terminate server"
  (rails s >> /dev/null) &
fi

if $c; then
  echo "Starting cucumber tests..."
  if $s; then
    echo "    (psst; server is still running)"
  fi
  cucumber
fi