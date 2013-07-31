#!/bin/bash

k=false # Kill previous rails server
s=false # Run rails server
b=false # Run bundle
d=false # Run database reset
m=false # Run database migrate
i=false # Reindex Solr
h=false # Help
c=false # Run cucumber tests
t=false # update cronTab
r=false #

while getopts ":ksbdmhctir" opt; do
  case $opt in
    k) k=true >&2 ;;
    s) s=true >&2 ;;
    b) b=true >&2 ;;
    d) d=true >&2 ;;
    m) m=true >&2 ;;
    i) i=true >&2 ;;
    h) h=true >&2 ;;
    c) c=true >&2 ;;
    r) r=true >&2 ;;
  t) t=true >&2 ;;
    \?)
      echo "Invalid option: -$OPTARG"
      echo "$0 -h for help"
      exit 1
    ;;
  esac
done

if $h || !($k || $s || $b || $d || $m || $c || $r || $i); then
  echo "Call $0 to reset the environment."
  echo "     -k to kill any servers (port 3000 tcp only)"
  echo "     -b to execute bundle"
  echo "     -d to reset database"
  echo "     -m to migrate database"
  echo "     -i to reindex Solr (required when changing schemes/db info outside regular flow)"
  echo "     -c to run cucumber tests"
  echo "     -s to execute rails s when done resetting (auto-starts Solr)"
  echo "     -h you're looking at it (and terminate)"
  echo "     -t to update the crontab"
  echo "     -r to run rspec"
  echo ""
  echo "On new pull/fetch/deploy, run;"
  echo "     $0 -kbmis"
  exit 0
fi

# Solr has to be started for reindexing or running the rails server
if $i || $s; then
  echo "Starting Solr (bundle exec rake sunspot:solr:start)"
  bundle exec rake sunspot:solr:start
fi

if $r || $c; then
  echo "Preparing test database (rake db:test:prepare)"
  rake db:test:prepare
fi

if $k; then
  echo "Killing server on TCP port 3000"
  fuser -k 3000/tcp
fi

if $b; then
  echo "Running bundle install"
  bundle install
fi

if $d; then
  echo "Resetting database (migrate, reset, prepare)"
  rake db:migrate
  rake db:reset
  rake db:test:prepare
  echo "Don't forget to reindex ($0 -i) if you updated schemes"
fi

if $m; then
  echo "Migrating database"
  rake db:migrate
  rake db:migrate RAILS_ENV=test
  echo "Don't forget to reindex ($0 -i) if you updated schemes"
fi

if $i; then
  yes | bundle exec rake sunspot:solr:reindex
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

if $r; then
  rspec
fi

if $t; then
  echo "Updating crontab"
  bundle exec whenever --update-crontab sciencechallenges
fi