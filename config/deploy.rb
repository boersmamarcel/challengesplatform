set :application, "Challengesplatform"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "198.199.77.172"                          # Your HTTP server, Apache/etc
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
set :deploy_to, "/var/www/staging"
set :user, "root"  # The server's user for deploys
# set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end