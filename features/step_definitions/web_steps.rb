Then /^I should be on the (.+)$/ do |page_name|
  current_path.should == path_to(page_name)
end
