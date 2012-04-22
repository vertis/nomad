And /^I should see '(.+)' in the '(.+)' field$/ do |value,field|
  find_field(field).value.should == value
end

Then /^I should see a '(.+)' field$/ do |field|
  find_field(field)
end
