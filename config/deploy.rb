# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2-p180'
set :rvm_type, :system

# bundler bootstrap
require 'bundler/capistrano'

#main detail

set :application, "50.56.125.42"
role :web, "50.56.125.42"                          # Your HTTP server, Apache/etc
role :app, "50.56.125.42"                          # This may be the same as your `Web` server
role :db,  "50.56.125.42", :primary => true # This is where Rails migrations will run

# server details

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/www.etipitaka.com"
set :deploy_via, :remote_cache
set :user, "passenger"
set :use_sudo, false

# repo details
set :scm, :git
set :scm_username, "git"
set :repository, "git@github.com:ssutee/etipitaka.com.git"
set :branch, "master"
set :git_enable_submodules, 1

#tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
