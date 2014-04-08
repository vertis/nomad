require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

#require 'mina/rbenv'

set :rbenv_path, '/usr/local/rbenv'
# Basic settings:
# domain     - The hostname to SSH to
# deploy_to  - Path to deploy into
# repository - Git repo to clone from (needed by mina/git)
# user       - Username in the  server to SSH to (optional)

set :domain, 'nomad.cx'
set :deploy_to, '/opt/apps/nomad'
set :repository, 'git@github.com:vertis/nomad.git'
set :user, 'root'
set :shared_paths, %w(tmp log public/system)

set :tag, 'master'

task :'rbenv:load' do
  queue %{
    echo "-----> Loading rbenv"
    #{echo_cmd %{export PATH="#{rbenv_path}/bin:$PATH"}}

    if ! which rbenv >/dev/null; then
      echo "! rbenv not found"
      echo "! If rbenv is installed, check your :rbenv_path setting."
      exit 1
    fi

    #{echo_cmd %{eval "$(rbenv init -)"}}
  }
end

# To fix heartbleed, but probably useful in future as well
task :'update-system' do
  queue 'apt-get update && apt-get -y upgrades && service nginx restart'
end

task :environment do
  invoke :'rbenv:load'
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'bundle:install'
    invoke :'rails:assets_precompile'
    #queue "cd #{release_path} && rm -rf #{tmp}"
    #queue "cd #{release_path} && rm -rf #{log}"
    invoke :'connect_shared_paths'
    #invoke :'deploy:link_shared_paths'

    to :launch do
      #queue 'kill `cat tmp/pids/passenger.80.pid`; bundle exec passenger start -e production -d -p 80'
      queue 'service nginx restart'
    end
  end
end

task :connect_shared_paths do
  cmds = settings.shared_paths!.map do |dir|
    echo_cmd %{mkdir -p #{deploy_to}/#{shared_path}/#{dir}}
  end
  cmds += settings.shared_paths!.map do |dir|
    echo_cmd %{rm -rf "./#{dir}"}
  end
  cmds += settings.shared_paths!.map do |dir|
    echo_cmd %{ln -sf #{deploy_to}/#{shared_path}/#{dir} "./#{dir}"}
  end
  queue %{
    echo "-----> Symlinking shared paths"
    #{cmds.join(" &&\n ")}
  }
end
