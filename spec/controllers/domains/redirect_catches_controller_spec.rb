require 'spec_helper'

describe Domains::RedirectCatchesController do
  describe "PUT ignore" do
    before(:each) do
      @user = User.make!
      sign_in @user
      @mock_domain = mock("domain", :name => 'domain1.test')
      @mock_domains = mock("domains")
      @mock_catches = mock("catches")
      @mock_catch = mock("catch")
      controller.current_user.should_receive(:domains).and_return(@mock_domains)
      @mock_domains.should_receive(:by_name).with("domain1.test").and_return(@mock_domain)
      @mock_domain.should_receive(:catches).and_return(@mock_catches)
      @mock_catches.should_receive(:find).with("1").and_return(@mock_catch)
      @mock_catch.should_receive(:update_attributes).with({:ignore => true}).and_return(true)
    end
    
    it "should redirect back to domains" do
      put :ignore, :domain_id => "domain1.test", :id => "1"
      response.should be_redirect
    end
  end
end
