# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

unless User.first
  @user = User.create(:email => 'luke.a.chadwick@gmail.com', :password => 'password', :password_confirmation => 'password')
  @domain = @user.domains.create(:name => 'domain1.test', :catch_all => 'http://blekko.com')
  @domain.mappings.create(:source_path => '/servers.html', :target => 'http://blekko.com/ws/servers')
end
