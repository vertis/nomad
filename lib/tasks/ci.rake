require 'nokogiri'

desc "Run everything on the CI server with all its outcomes (deploy etc)"
task :ci do
  Rake::Task['spec'].invoke
  ensure_coverage 100
  Rake::Task['cucumber'].invoke
end


def ensure_coverage(threshold)
  doc = Nokogiri::HTML File.read("coverage/index.html")
  node = doc.css("h2:first .covered_percent").first
  covered = node.content.to_f
  raise "The test coverage #{covered}% is below the threshold of #{threshold}%. Not good enough, sorry." if covered < threshold
end
