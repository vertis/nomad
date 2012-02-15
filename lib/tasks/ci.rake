require 'nokogiri'

desc "Run everything on the CI server with all its outcomes (deploy etc)"
task :ci do
  Rake::Task['spec'].invoke
  ensure_coverage
  Rake::Task['cucumber'].invoke
end


def ensure_coverage
  raise "The test coverage #{current_coverage}% is below the threshold of #{threshold}%. Not good enough, sorry." if current_coverage < threshold
  update_threshold(current_coverage)
end

def current_coverage
  return @covered if @covered
  doc = Nokogiri::HTML File.read("coverage/index.html")
  node = doc.css("h2:first .covered_percent").first
  @covered = node.content.to_f
end

def threshold
  @threshold ||= File.read(Rails.root + "config/ratchet.txt").to_f
  @threshold || 100
end

def update_threshold(value)
  File.open(Rails.root + "config/ratchet.txt", 'w') do |f|
    f.write value
  end
end
