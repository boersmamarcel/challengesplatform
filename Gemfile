source 'https://rubygems.org'

# Rails essentials
gem 'rails', '3.2.13'
gem 'pg' #Database Postgres
gem 'jquery-rails' # Jquery for rails
gem 'jquery-ui-rails' # Jquery ui for rails
gem 'haml' # Haml template rendering

# Enhance SQL queries
gem 'squeel' # DSL for SQL queries

# Search engine (will replace squeel)
gem 'sunspot_rails'
gem 'sunspot_test'
gem 'sunspot_solr' # Ideally, we'll switch to a standalone Solr server...
gem 'progress_bar'

#Add gems for devise authentication and Google oauth
gem 'devise', '>= 3.0.1' # Authentication Gem
gem 'omniauth-google-oauth2' # O-Auth plugin for google
gem 'omniauth' # O-Auth plugin
gem 'gravatar-ultimate' # Gravatar api
# Change me to the default devise_mailchimp once Bram's pull request has been approved
gem 'devise_mailchimp', :git => 'https://github.com/bcleenders/devise_mailchimp.git'  # Mailchimp

gem 'draper', '~> 1.0' # For modeldecorators

gem 'carrierwave', '~> 0.8' # For file uploading
gem "mini_magick" # For image resizing. OSX: `brew install imagemagick`. UNIX: http://www.imagemagick.org/script/binary-releases.php#unix

gem 'redis'
gem 'split', :require => 'split/dashboard'
gem 'split-analytics', :require => 'split/analytics'

gem 'redcarpet', '~> 2.3.0' # Markdown renderer

gem 'kaminari' # Pagination and sorting gem

gem 'whenever', :require => false # Crons

gem 'roadie' # Changes CSS formatting to inline because of lame mail clients

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem "bootstrap-sass", '~> 2.3.2.0'
  gem "font-awesome-rails", "~> 3.2.0.0"
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :assets, :test, :development do
  gem 'rake'
end

group :development do
  gem 'capistrano' # Easy deployment
  gem 'rvm-capistrano' # Enabling RVM support for capistrano
  gem 'debugger' # Debugging plugin for rails
  gem 'thin'
end

group :test, :development  do
  gem 'coveralls', require: false # Testing coverage report
  gem 'factory_girl_rails' # Factories for tests
  gem 'rspec' # Testing framework for rails
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner' # Database cleaner used for tests where transactions are not possible
  gem 'rspec-rails', '~> 2.0' #Rspec for rails
  gem 'poltergeist' # PhantomJS (headless browser)
end
