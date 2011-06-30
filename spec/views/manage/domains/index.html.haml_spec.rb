require 'spec_helper'

describe "manage_domains/index.html.haml" do
  before(:each) do
    assign(:manage_domains, [
      stub_model(Manage::Domain,
        :name => "Name",
        :catch_all => "Catch All",
        :alternative_names => ""
      ),
      stub_model(Manage::Domain,
        :name => "Name",
        :catch_all => "Catch All",
        :alternative_names => ""
      )
    ])
  end

  it "renders a list of manage_domains" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Catch All".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
