require 'spec_helper'

describe "manage/domains/show.html.haml" do
  before(:each) do
    @domain = assign(:domain, stub_model(Domain,
      :name => "Name",
      :catch_all => "Catch All",
    ))
    @mappings = []
  end

  it "renders attributes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Catch All/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
