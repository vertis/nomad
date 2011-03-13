p ARGV
Domain.where(:name => ARGV.first).first.redirects.each do |redirect|
 puts "#{redirect.old_path}:#{redirect.target}" unless redirect.ok?
end