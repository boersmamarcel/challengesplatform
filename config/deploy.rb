require 'bundler/capistrano'
require 'capistrano/ext/multistage'
set :stages, %w(production staging)
set :default_stage, "staging"
set :application, "Challengesplatform"

role :web, "198.199.77.172"                          # Your HTTP server, Apache/etc
role :app, "198.199.77.172"                          # This may be the same as your `Web` server
role :db, "198.199.77.172", :primary => true         # This may be the same as your `Web` server
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
set :rvm_ruby_string, "1.9.3@challenges" #"ruby-2.0.0-p0@challenges"               # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs
set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}_#{stage}" }

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset

before "deploy", "deploy:deploying"
before "deploy:assets:precompile", "deploy:symlink_db"
after "deploy:symlink_db", "deploy:symlink_keys"
after "deploy:symlink_keys", "deploy:symlink_uploads"
before "deploy:restart", "deploy:prepare_solr"
before "deploy:prepare_solr", "deploy:migrate"
after "deploy", "deploy:done"

require "whenever/capistrano"
require "rvm/capistrano"

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Starts and reindexes the Solr database"
  task :prepare_solr do
    begin
      run("cd #{deploy_to}/current && /usr/bin/env rake sunspot:solr:stop RAILS_ENV=#{rails_env}")
    rescue Exception => error
      puts "***Unable to stop Solr with error: #{error}"
      puts "***Solr may have not been started. Continuing anyway.***"
    end
    begin
      run("cd #{release_path} && /usr/bin/env rake sunspot:solr:start RAILS_ENV=#{rails_env}")
    rescue Exception => error
      puts "***Unable to start Solr with error: #{error}."
      puts "***Continuing anyway.***"
    end
    begin
      run("cd #{release_path} && yes | /usr/bin/env rake sunspot:reindex RAILS_ENV=#{rails_env}")
    rescue Exception => error
      puts "***Unable to reindex Solr with error: #{error}"
      puts "***Continuing anyway.***"
    end
  end

  desc "Runs an audiofile in order to notice the user that deployment has started"
  task :deploying, :on_error => :continue do
    begin
      system "/usr/bin/afplay ~/Dropbox/Notes/deploying.mp3"
    rescue
    end
    begin
      system "ffplay ~/Music/deploying.mp3 -nodisp -autoexit"
    rescue
    end
  end

  desc "Runs an audiofile in order to notice the user that deployment was succesful"
  task :done, :on_error => :continue do
    begin
      system "/usr/bin/afplay ~/Dropbox/Notes/welldone.mp3"
    rescue
    end
    begin
      system "ffplay ~/Music/welldone.mp3 -nodisp -autoexit"
    rescue
    end
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
      run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlinks the keys"
  task :symlink_keys, :roles => :app do
      run "ln -nfs #{deploy_to}/shared/config/initializers/devise_local.rb #{release_path}/config/initializers/devise_local.rb"
      run "ln -nfs #{deploy_to}/shared/config/initializers/google_analytics.rb #{release_path}/config/initializers/google_analytics.rb"
      run "rm #{release_path}/config/initializers/secret_token.rb && ln -nfs #{deploy_to}/shared/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end

  desc "Symlink the uploaded images"
  task :symlink_uploads do
     run "ln -nfs #{deploy_to}/shared/uploads  #{release_path}/public/uploads"
  end
end
