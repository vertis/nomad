begin
require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end
rescue LoadError
  puts "rspec is not available, skipping rake task"
end