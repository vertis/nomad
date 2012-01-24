Then /^I should see '(.*)'$/ do |text|
  page.should have_content(text)
end

When /^I click on the '(.*)' link$/ do |link|
  click_link link
end

When /^I enter '(.*)' into the '(.*)' field$/ do |value,field_name|
  fill_in field_name, :with => value
end

When /^I click the '(.*)' button$/ do |button_name|
  click_button(button_name)
end
