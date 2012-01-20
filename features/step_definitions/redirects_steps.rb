Given /^I am not logged in$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am an existing user$/ do
  @user_email = 'user@example.com'
  @user_password = 'password'
  @user = User.create!(:email => @user_email, :password => @user_password, :password_confirmation => @user_password)
end

Given /^I have have setup a domain named '(.*)' with a catch all of '(.*)'$/ do |source_domain, target_domain|
  @user.domains.create(:name => source_domain, :catch_all => target_domain)
end

Given /^I am logged in$/ do
  visit '/users/sign_in'
  fill_in "user_email", :with=>@user_email
  fill_in "user_password", :with=>@user_password
  click_button "Sign in"
end

When /^I go to '(.*)'$/ do |url|
  server_port = URI.parse(current_url).port
  domain_under_test = URI.parse(url)
  domain_under_test.port = server_port
  visit domain_under_test.to_s
end

Then /^I should be on '(.*)'$/ do |url|
  current_url.should == url
end