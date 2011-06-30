require 'spec_helper'

describe "manage_domains/show.html.haml" do
  before(:each) do
    @domain = assign(:domain, stub_model(Manage::Domain,
      :name => "Name",
      :catch_all => "Catch All",
      :alternative_names => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Catch All/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
