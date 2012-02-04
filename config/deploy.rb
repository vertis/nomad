$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3@nomad'       # Or whatever env you want it to run in.
require "bundler/capistrano"

set :application, "nomad"
set :repository,  "git@github.com:vertis/nomad.git"

set :scm, :git
ssh_options[:forward_agent] = true

ssh_options[:user_known_hosts_file] = ["/dev/null"]

set :branch, "master"
set :deploy_via, :remote_cache

set(:use_sudo) { false }
set :user, "root"


nodes = {
  "nomad01" => "173.230.157.250",
  "nomad02" => "173.255.221.195"
}

# role :web, "173.230.157.250"                          # Your HTTP server, Apache/etc
# role :app, "173.230.157.250"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"
role :web, nodes[ENV['NODE']]
role :app, nodes[ENV['NODE']]

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

namespace :assets do
  task :precompile do
    run "cd #{release_path} && rake assets:precompile"
  end
end


namespace :nginx do
  task :symlink_and_restart do
    require 'fileutils'
    run "ln -sf #{release_path}/config/deploy/nomad_nginx.conf /etc/nginx/sites-enabled/nomad.conf"
    run "/etc/init.d/nginx restart"
  end
end

namespace :unicorn do
  task :copy_and_restart do
    #run "cd #{release_path} && nohup bundle exec foreman start -D"
    #run "cd #{release_path} && bundle exec foreman export inittab /etc/init.d/nomad -l /opt/apps/nomad/shared/log/ -u root"
    require 'fileutils'
    #FileUtils.cp("#{release_path}/config/deploy/unicorn.sh", "/etc/init.d/nomad")
    run "cp -f #{release_path}/config/deploy/unicorn.sh /etc/init.d/nomad"
    run "/etc/init.d/nomad restart"
  end
end

namespace :rvm do
  task :create_gemset do
    disable_rvm_shell do
      run "source /usr/local/rvm/scripts/rvm && rvm use --create #{rvm_ruby_string}"
    end
  end
end

namespace :github do
  task :trust_host do
    run "ssh -o StrictHostKeyChecking=no git@github.com; true"
  end
end

before "deploy:setup", "rvm:create_gemset"
before "deploy:setup", "github:trust_host"

after "deploy", "rvm:trust_rvmrc"
#after "deploy", "assets:precompile"
after "deploy", "unicorn:copy_and_restart"
after "deploy", "nginx:symlink_and_restart"

def disable_rvm_shell(&block)
  old_shell = self[:default_shell]
  self[:default_shell] = nil
  yield
  self[:default_shell] = old_shell
end