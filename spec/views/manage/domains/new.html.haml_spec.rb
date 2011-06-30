require 'spec_helper'

describe "manage_domains/new.html.haml" do
  before(:each) do
    assign(:domain, stub_model(Manage::Domain,
      :name => "MyString",
      :catch_all => "MyString",
      :alternative_names => ""
    ).as_new_record)
  end

  it "renders new domain form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => manage_domains_path, :method => "post" do
      assert_select "input#domain_name", :name => "domain[name]"
      assert_select "input#domain_catch_all", :name => "domain[catch_all]"
      assert_select "input#domain_alternative_names", :name => "domain[alternative_names]"
    end
  end
end
