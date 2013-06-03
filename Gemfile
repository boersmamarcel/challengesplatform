source 'https://rubygems.org'

# Rails essentials
gem 'rails', '3.2.13'
gem 'pg' #Database Postgres
gem 'jquery-rails' # Jquery for rails
gem 'jquery-ui-rails' # Jquery ui for rails
gem 'haml' # Haml template rendering

#Add gems for devise authentication and Google oauth
gem 'devise' # Authentication Gem
gem 'omniauth-google-oauth2' # O-Auth plugin for google
gem 'omniauth' # O-Auth plugin
gem 'gravatar-ultimate' # Gravatar api
gem "devise_mailchimp"  # Mailchimp

gem 'draper', '~> 1.0' # For modeldecorators

gem 'carrierwave', '~> 0.8' # For file uploading
gem "mini_magick" # For image resizing. OSX: `brew install imagemagick`. UNIX: http://www.imagemagick.org/script/binary-releases.php#unix

gem 'redis'
gem 'split', :require => 'split/dashboard'
gem 'split-analytics', :require => 'split/analytics'

gem 'redcarpet', '~> 2.3.0' # Markdown renderer

gem 'kaminari' # Pagination and sorting gem


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem "bootstrap-sass", '~> 2.3.1.0'
  gem "font-awesome-rails", "~> 3.1.1.2"
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'capistrano' # Easy deployment
  gem 'rvm-capistrano' # Enabling RVM support for capistrano
  gem 'thin'
  gem 'debugger' # Debugging plugin for rails
end

group :test, :development  do
  gem 'coveralls', require: false # Testing coverage report
  gem 'factory_girl_rails' # Factories for tests
  gem 'rspec' # Testing framework for rails
  gem 'rake'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner' # Database cleaner used for tests where transactions are not possible
  gem 'rspec-rails', '~> 2.0' #Rspec for rails
  gem 'poltergeist' # PhantomJS (headless browser)
end
