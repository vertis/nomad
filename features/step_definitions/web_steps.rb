Then /^I should be on the manage domain page for '(.+)'$/ do |domain_name|
  current_path.should =~ /#{Domain.where(:name => domain_name).first.id}$/
end

Then /^I should be on the (.+ page)$/ do |page_name|
  current_path.should == path_to(page_name)
end

When /^I go to the (.+ page)$/ do |page_name|
  visit path_to(page_name)
end

And /^I should see '(.+)' in the '(.+)' field$/ do |value,field|
  find_field(field).value.should == value
end
