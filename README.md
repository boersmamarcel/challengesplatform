ScienceChallenges Online Platform
==================
[![Build Status](https://travis-ci.org/boersmamarcel/challengesplatform.png?branch=master)](https://travis-ci.org/boersmamarcel/challengesplatform)
[![Dependency Status](https://gemnasium.com/boersmamarcel/challengesplatform.png)](https://gemnasium.com/boersmamarcel/challengesplatform)
[![Code Climate](https://codeclimate.com/github/boersmamarcel/challengesplatform.png)](https://codeclimate.com/github/boersmamarcel/challengesplatform)
[![Coverage Status](https://coveralls.io/repos/boersmamarcel/challengesplatform/badge.png?branch=master)](https://coveralls.io/r/boersmamarcel/challengesplatform?branch=master)
  
# Quick Start Guide

This guide will serve as a quick start to hosting your own ScienceChallenges site. At the end of this guide you should have a running local copy.

## Installing your OS

ScienceChallenges will work on most systems, but our staging and production are running Ubuntu Server version 12.10. This guide will assume you follow the basic installation steps for this particular OS. After you have installed your system, make sure the package list is up to date so we can breeze through the rest of the steps by using

~~~~
sudo apt-get update
~~~~

## Installing RVM

RVM is the Ruby Version Manager. This makes it easier to keep track of which version of Ruby you might want to use for different projects. To install RVM you need something to download it from the internet. We will use curl, which is not installed by default on our system. To install curl and then RVM, enter the following into your terminal:

~~~~
sudo apt-get install curl
curl -L get.rvm.io | bash -s stable
~~~~

This will download and install RVM. Now you need to load it:

~~~~
source ~/.rvm/scripts/rvm
~~~~

RVM has some additional dependencies that need to be installed. RVM can take care of this if you want by executing the following commands:

~~~~
rvm autolibs enable
rvm requirements
~~~~

Note that there is some time where it appears the last script is hanging -- but it's really just doing work in the background!

## Installing Ruby

Now that we have RVM we can use it to install a specific version of Ruby. ScienceChallenges has been developed using Ruby 1.9.3. Simply type in:

~~~~
rvm install 1.9.3
rvm use 1.9.3 --default
~~~~

To install Ruby 1.9.3 and enable it as the default Ruby version to use throughout your system.

### Installing RubyGems

Next we need to install RubyGems to manage installing all necessary gems for Rails and the project.

~~~~
rvm rubygems current
~~~~

### Installing Rails

Now that we have Ruby and RubyGems installed we can install Rails.

~~~~
gem install rails
~~~~

## Installing passenger and nginx

To host the website we are going to install Passenger and nginx. To do so, execute the following commands (note, you might have to install extra dependencies in the second step. The software will guide you through it):

~~~~
gem install passenger
rvmsudo passenger-install-nginx-module
~~~~

The next step is create a startup script. We are going to use an existing one from the internet, install it like this:

~~~~
wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh
sudo mv init-deb.sh /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults
~~~~

Restart the webserver and confirm you see a "Welcome to nginx screen" if you browse to [localhost](http://localhost).

~~~~
sudo /etc/init.d/nginx stop
sudo /etc/init.d/nginx start
~~~~

In a later step we will come back to configuring nginx.

## Installing dependencies of the platform

There are a few external dependencies like the PostgreSQL server. To install all these packages at once, use the following:

~~~~
sudo apt-get install postgresql-9.1 libpq-dev redis-server postfix nodejs imagemagick
~~~~

Follow the easy installation instructions of each of these packages if applicable. For Postfix, use "Internet Site".

## Installing Git and cloning the repository

Before we install the webserver that is going to host the site, let's first install git and make a local copy of the ScienceChallenges project. Since git is not installed by default, run the following:

~~~~
sudo apt-get install git-core
~~~~

Once git is installed, clone the project into a new directory somewhere. For now we will create a sciencechallenges folder in the home directory of the user.

~~~~
cd /var/www
git clone https://github.com/boersmamarcel/challengesplatform.git
~~~~

### Setting up PostgreSQL

The PostgreSQL Server is now installed, but we need to create a user and database for the site:

~~~~
sudo -u postgres createuser -D -P challengesuser
~~~~

Pick a password and make this user a superuser. Next, create a database:

~~~~
sudo -u postgres createdb -O challengesuser challengesdb
~~~~

In order to be able to login, we need to switch the authentication mode from __peer__ to __md5__:

~~~~
sudo nano /etc/postgressql/9.1/main/pg_hba.conf
~~~~

Change `local all all peer` into `local all all md5` and restart the server:

~~~~
sudo service postgresql restart
~~~~

### Adding your database credentials to the project

Create the database.yml file, in the cloned __challengesplatform/config__ folder and add your user and database (be sure to use spaces, not tabs):

~~~~
sudo nano database.yml

development:
  adapter: postgresql
  host: localhost
  username: challengesuser
  database: challengesdb
  password: passwordhere
~~~~

### Installing required gems and running database migrations

To use this project we need to install pieces of software called gems. To install all the required gems, navigate to the root of the project (e.g. the __challengesplatform__ folder) and run the following command (this might take a while):

~~~~
bundle install
~~~~

Then run a migration of the database as follows:

~~~~
rake db:migrate
~~~~

### Create local config files

Some functionality requires third party keys. This section will describe shortly how to setup the required keys.

* **Google Analytics**: Setup your key via the [Google API console](https://www.google.nl/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CCkQFjAA&url=http%3A%2F%2Fcode.google.com%2Fapis%2Fconsole&ei=XffKUbOvMO6c0wXiwYCQBQ&usg=AFQjCNFikY2jzXn9SOuZu0UcyS-59LlsTw&bvm=bv.48340889,d.d2k)
* **Mailchimp**: Setup your key in [Mailchimp](http://kb.mailchimp.com/article/where-can-i-find-my-api-key) and create a mailing list named _Challenges_
* **Google OAuth2**: Setup your key via the [Google API console](https://www.google.nl/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CCkQFjAA&url=http%3A%2F%2Fcode.google.com%2Fapis%2Fconsole&ei=XffKUbOvMO6c0wXiwYCQBQ&usg=AFQjCNFikY2jzXn9SOuZu0UcyS-59LlsTw&bvm=bv.48340889,d.d2k)

There are two ways for adding your keys, one is in the _devise.rb_ file and the other way is by adding a new initialiser file.

_devise.rb_
```
  #google authentication
  require "omniauth-google-oauth2"
  config.omniauth :google_oauth2, ENV["OAUTH2CLIENTID"], ENV["OAUTH2CLIENTSECRET"], { :access_type => "offline", :approval_prompt => "" } 

  Devise.mailchimp_api_key = ENV["MAILCHIMPKEY"]
  Devise.mailing_list_name = 'Challenges'
```
Replace **ENV["OAUTH2CLIENTID"]** with the Google OAuth2 Client id and **ENV["OAUTH2CLIENTSECRET"]** with the Google OAuth2 Client secret. Furthermore **ENV["MAILCHIMPKEY"]** can be replace by your mailchimp api key.

**Alternative**

Create a file _devise_local.rb_ inside the _config/initializers/_ folder
```
   require "omniauth-google-oauth2"
    
    config.omniauth :google_oauth2, "GOOGLECLIENTID", "GOOGLESECRET", 
    { :access_type => "offline", 
      :approval_prompt => "auto",
    }
    
    Devise.mailchimp_api_key = 'MAILCHIMPKEY'
    Devise.mailing_list_name = 'Challenges'
```
Replace **ENV["OAUTH2CLIENTID"]** with the Google OAuth2 Client id and **ENV["OAUTH2CLIENTSECRET"]** with the Google OAuth2 Client secret. Furthermore **ENV["MAILCHIMPKEY"]** can be replace by your mailchimp api key.

## Configuring nginx

Now that we have everything in place we need to hookup your new clone to the nginx webserver. You can do that as follows:

~~~~
sudo nano /opt/nginx/conf/nginx.conf
~~~~

And then make sure it looks something like this:

~~~~
...
  passenger_root /home/username/.rvm/gems/ruby-1.9.3-p392@challenges/gems/passenger-4.0.2;
  passenger_ruby /home/username/.rvm/wrappers/ruby-1.9.3-p392@challenges/ruby;

  ...

  server {
      listen 80;
      server_name yourdomainname.tld;
      passenger_enabled on;
      root /var/www/challengesplatform/public;
      rails_env development;
  }
...
~~~~

Make sure you remove the block where it says _location /_. When you are done editing, be sure to restart the webserver:

~~~~
sudo /etc/init.d/nginx stop
sudo /etc/init.d/nginx start
~~~~

## Well done!

You now have completed the quick start guide to getting the ScienceChallenges platform running! From here you can continue with a more [advanced setup](https://github.com/boersmamarcel/challengesplatform/wiki).
