Given /^I am not logged in$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am an existing user$/ do
  @user_email = 'user@example.com'
  @user_password = 'password'
  @user = User.create!(:email => @user_email, :password => @user_password, :password_confirmation => @user_password)
end

Given /^I have setup a domain named '(.*)' with a catch all of '(.*)'$/ do |source_domain, target_domain|
  @user.domains.create(:name => source_domain, :catch_all => target_domain)
end

Given /^I have setup a mapping for the domain named '(.+)' with a source of '(.+)' and a target of '(.+)'$/ do |domain_name, source_path, target|
  @domain = Domain.where(:name => domain_name).first
  @domain.mappings.create(:source_path => source_path, :target => target) 
end


Given /^I am logged in$/ do
  visit '/users/sign_in'
  fill_in "user_email", :with=>@user_email
  fill_in "user_password", :with=>@user_password
  click_button "Sign In"
end

When /^I go to '(.*)'$/ do |url|
  visit '/' # Need to have the server running to get the correct port for domain based tests
  domain_under_test = URI.parse(url)
  domain_under_test.port = Capybara::Server.ports[Capybara.app.object_id]
  visit domain_under_test.to_s
end

Then /^I should be on '(.*)'$/ do |url|
  current_url.should == url
end