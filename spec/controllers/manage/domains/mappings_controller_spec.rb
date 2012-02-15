require 'spec_helper'

describe Manage::Domains::MappingsController do
  before(:each) do
    @user = User.make!
    sign_in @user
    @mock_domain = mock("domain")
    @mock_domains = mock("domains")
    @mock_mappings = mock("mappings")
    @mock_mapping = mock("mapping")
    controller.current_user.should_receive(:domains).and_return(@mock_domains)
    @mock_domains.should_receive(:find).with("37").and_return(@mock_domain)
    @mock_domain.should_receive(:mappings).and_return(@mock_mappings)
  end

  describe "GET 'create'" do
    it "should be successful" do
      @mock_mappings.should_receive(:new).and_return(@mock_mapping)
      @mock_mapping.should_receive(:save).and_return(true)
      get :create, :domain_id => "37"
      response.should be_redirect
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      @mock_mappings.should_receive(:find).with("1").and_return(@mock_mapping)
      @mock_mapping.should_receive(:update_attributes).and_return(true)
      get :update, :domain_id => "37", :id => "1"
      response.should be_redirect
    end
  end

  describe "DELETE 'destroy'" do
    it "should be successful" do
      @mock_mappings.should_receive(:find).with("1").and_return(@mock_mapping)
      @mock_mapping.should_receive(:destroy).and_return(true)
      delete :destroy, :domain_id => "37", :id => "1"
      response.should be_redirect
    end
  end

end
