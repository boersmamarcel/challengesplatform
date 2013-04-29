source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use PostgreSQL
gem 'pg'

gem 'devise'
gem 'omniauth-google-oauth2'
gem 'omniauth'

gem 'haml'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem "bootstrap-sass", '~> 2.3.1.0'
  gem "font-awesome-rails", "~> 3.0.2.0"
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :develop do
  gem 'capistrano'
end

group :test, :develop  do

    gem 'factory_girl_rails'
    gem 'rspec'
    gem 'rake'
    gem 'cucumber-rails', :require => false
    # database_cleaner is not required, but highly recommended
    gem 'database_cleaner'
    gem 'rspec-rails', '~> 2.0'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
gem 'rvm-capistrano'
