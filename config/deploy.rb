require 'bundler/capistrano'
require 'capistrano/ext/multistage'
set :stages, %w(production staging)
set :default_stage, "staging"
set :application, "Challengesplatform"

role :web, "198.199.77.172"                          # Your HTTP server, Apache/etc
role :app, "198.199.77.172"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"
set :keep_releases, 3

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :repository, "git@github.com:boersmamarcel/challengesplatform.git"  # Your clone URL
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rvm_install_with_sudo, true
after "deploy:restart", "deploy:cleanup"
set :rvm_type, :system
set :rvm_ruby_string, "ruby-2.0.0-p0@challenges"               # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset

before "deploy", "deploy:deploying"
before "deploy:restart", "deploy:symlink_db"
before "deploy:restart", "deploy:symlink_keys"
after "deploy:restart", "deploy:done"
after "deploy", "deploy:migrate"
require "rvm/capistrano"

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Runs an audiofile in order to notice the user that deployment has started"
  task :deploying, :on_error => :continue do
    system "/usr/bin/afplay ~/Downloads/deploying.mp3"
  end

  desc "Runs an audiofile in order to notice the user that deployment was succesful"
  task :done, :on_error => :continue do
    system "/usr/bin/afplay ~/Downloads/welldone.mp3"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
      run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
  desc "Symlinks the keys"
  task :symlink_keys, :roles => :app do
      run "ln -nfs #{deploy_to}/shared/config/initializers/devise_local.rb #{release_path}/initializers/devise_local.rb"
  end
end
