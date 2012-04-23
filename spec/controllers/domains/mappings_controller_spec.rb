require 'spec_helper'

describe Domains::MappingsController do
  before(:each) do
    @user = User.make!
    sign_in @user
    @mock_domain = mock("domain", :name => 'domain1.test')
    @mock_domains = mock("domains")
    @mock_mappings = mock("mappings")
    @mock_mapping = mock("mapping")
    controller.current_user.should_receive(:domains).and_return(@mock_domains)
    @mock_domains.should_receive(:by_name).with("domain1.test").and_return(@mock_domain)
    @mock_domain.should_receive(:mappings).and_return(@mock_mappings)
  end

  describe "GET 'new'" do
    it "should assign a domain" do
      @mock_mappings.should_receive(:new).and_return(@mock_mapping)
      get :new, :domain_id => "domain1.test"
      assigns[:domain].should == @mock_domain
    end
    
    it "should assign a mapping" do
      @mock_mappings.should_receive(:new).and_return(@mock_mapping)
      get :new, :domain_id => "domain1.test"
      assigns[:mapping].should == @mock_mapping
    end
  end
  
  describe "POST 'create'" do
    it "should be successful" do
      @mock_domain.should_receive(:name).and_return('domain1.test')
      @mock_mappings.should_receive(:new).and_return(@mock_mapping)
      @mock_mapping.should_receive(:save).and_return(true)
      post :create, :domain_id => "domain1.test"
      response.should be_redirect
    end
  end
  
  describe "GET 'edit'" do
    it "should assign a domain" do
      @mock_mapping.should_receive(:slug).and_return('/example')
      @mock_mappings.should_receive(:find).with("1").and_return(@mock_mapping)
      get :edit, :domain_id => "domain1.test", :id => "1"
      assigns[:domain].should == @mock_domain
    end
    
    it "should assign a mapping" do
      @mock_mapping.should_receive(:slug).and_return('/example')
      @mock_mappings.should_receive(:find).with("1").and_return(@mock_mapping)
      get :edit, :domain_id => "domain1.test", :id => "1"
      assigns[:mapping].should == @mock_mapping
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      @mock_domain.should_receive(:name).and_return('domain1.test')
      @mock_mappings.should_receive(:find).with("1").and_return(@mock_mapping)
      @mock_mapping.should_receive(:update_attributes).and_return(true)
      put :update, :domain_id => "domain1.test", :id => "1"
      response.should be_redirect
    end
  end

  describe "DELETE 'destroy'" do
    it "should be successful" do
      @mock_domain.should_receive(:name).and_return('domain1.test')
      @mock_mappings.should_receive(:find).with("1").and_return(@mock_mapping)
      @mock_mapping.should_receive(:destroy).and_return(true)
      delete :destroy, :domain_id => "domain1.test", :id => "1"
      response.should be_redirect
    end
  end

end
