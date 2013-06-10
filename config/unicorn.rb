APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))
APP_NAME = 'nomad'
APP_PORT = ENV['PORT'] || 80

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'

worker_processes 4
working_directory APP_ROOT

preload_app true

listen "/tmp/#{APP_NAME}_unicorn.sock", :backlog => 64
listen APP_PORT, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# feel free to point this anywhere accessible on the filesystem
pid "#{APP_ROOT}/tmp/pids/unicorn.pid"

#if Rails.env == 'production'
  #stderr_path "#{APP_ROOT}/log/unicorn.stderr.log"
  #stdout_path "#{APP_ROOT}/log/unicorn.stdout.log"
  #end

before_fork do |server, worker|
  old_pid = "#{APP_ROOT}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Old master alerady dead"
    end
  end
end

