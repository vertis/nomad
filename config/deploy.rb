$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3@nomad'       # Or whatever env you want it to run in.
require "bundler/capistrano"

set :application, "nomad"
set :repository,  "git@github.com:vertis/nomad.git"

set :scm, :git
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache

set(:use_sudo) { false }
set :user, "root"



role :web, "173.230.157.250"                          # Your HTTP server, Apache/etc
role :app, "173.230.157.250"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

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

set :deploy_to, "/opt/apps/#{application}"

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

namespace :nginx do
  task :symlink_and_restart do
    require 'fileutils'
    FileUtils.ln_sf "#{release_path}/config/deploy/noman_nginx.conf", "etc/nginx/sites-enabled/nomad.conf"
    run "/etc/init.d/nginx restart"
  end
end

namespace :foreman do
  task :symlink_and_restart do
    run "foreman export inittab"
  end
end

after "deploy", "rvm:trust_rvmrc"
after "deploy", "foreman:symlink_and_restart"
after "deploy", "nginx:symlink_and_restart"