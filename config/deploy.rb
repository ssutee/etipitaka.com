# RVM bootstrap
# $:.unshift(File.expand_path("~/.rvm/lib"))

# set :rvm_ruby_string, '1.9.2-p180'
# set :rvm_ruby_string, '1.9.3-p194'

set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

require 'rvm/capistrano'
set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

#main detail

set :application, "203.114.103.69"
role :web, "203.114.103.69"                          # Your HTTP server, Apache/etc
role :app, "203.114.103.69"                          # This may be the same as your `Web` server
role :db,  "203.114.103.69", :primary => true # This is where Rails migrations will run

# server details

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/home/sutee/www/etipitaka"
set :deploy_via, :remote_cache
set :user, "sutee"
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
    run "ln -nfs #{shared_path}/files #{release_path}/public/files"
    run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
    run "ln -nfs #{shared_path}/db/thai #{release_path}/db/thai"
    run "ln -nfs #{shared_path}/db/thai_name.txt #{release_path}/db/thai_name.txt"
    run "ln -nfs #{shared_path}/db/pali #{release_path}/db/pali"
    run "ln -nfs #{shared_path}/db/pali_name.txt #{release_path}/db/pali_name.txt"
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
