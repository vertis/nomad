Given /^I am on the manage domains page$/ do
  visit '/manage/domains'
end

Then /^I should see '(.*)'$/ do |text|
  page.should have_content(text)
end

When /^I click on the '(.*)' link$/ do |link|
  click_link link
end

Then /^I should be on the new domain page$/ do
  current_path.should  == '/manage/domains/new'
end

When /^I enter '(.*)' into the '(.*)' field$/ do |value,field_name|
  fill_in field_name, :with => value
end

When /^I click the '(.*)' button$/ do |button_name|
  click_button(button_name)
end

Then /^I should be on the manage domains page$/ do
  current_path.should == '/manage/domains'
end