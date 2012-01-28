Then /^I should be on the manage domain page for '(.+)'$/ do |domain_name|
  current_path.should =~ /#{Domain.where(:name => domain_name).first.id}$/
end

Then /^I go to the manage domain page for '(.+)'$/ do |domain_name|
  domain = Domain.where(:name => domain_name).first
  visit manage_domain_path(domain)
  #current_path.should =~ /#{}$/
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

Then /^I should see a '(.+)' field$/ do |field|
  find_field(field)
end
