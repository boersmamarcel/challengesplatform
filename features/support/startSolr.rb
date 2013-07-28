#
# Auto-starts Solr for cucumber tests
#

system('bundle exec rake sunspot:solr:start')

at_exit do
  system('bundle exec rake sunspot:solr:stop')
end