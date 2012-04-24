require 'spec_helper'

describe RedirectsController do

  describe "GET index" do
    context "an exact mapping exists" do
      before(:each) do
        @mock_domain = mock("domain")
        @mock_mappings = mock("mappings")
        @mock_mapping = mock("mapping")
        Domain.should_receive(:where).with(:name => /domain1.test/).and_return([@mock_domain])
      end

      it "should redirect to the mapping" do
        request.env['HTTP_HOST'] = 'domain1.test'

        @mock_domain.should_receive(:mappings).and_return(@mock_mappings)
        @mock_mappings.should_receive(:where).and_return([@mock_mapping])
        @mock_mapping.should_receive(:target).and_return('http://blekko.com/ws/hello')

        get :index, :path => 'hello'
        response.should redirect_to('http://blekko.com/ws/hello')
        response.response_code.should == 301
      end
    end

    context "an exact mapping doesn't exist" do
      before(:each) do
        @mock_domain = mock("domain")
        @mock_mappings = mock("mappings")
        @mock_mapping = mock("mapping")
        Domain.should_receive(:where).with(:name => /domain1.test/).and_return([@mock_domain])
      end

      it "should redirect to catch all" do
        request.env['HTTP_HOST'] = 'domain1.test'

        @mock_domain.should_receive(:mappings).and_return(@mock_mappings)
        @mock_mappings.should_receive(:where).and_return([])

        @mock_domain.should_receive(:catch_all).and_return('http://blekko.com')
        
        @mock_catch = mock("catch")
        @mock_catch.should_receive(:touch)
        @mock_catches = mock("catches")
        @mock_catches.should_receive(:where).with({:source_path=>/^\/no-mapping/}).and_return([])
        @mock_catches.should_receive(:create).with({:source_path=>"/no-mapping"}).and_return(@mock_catch)
        @mock_domain.should_receive(:catches).twice.and_return(@mock_catches)
        
        get :index, :path => 'no-mapping'
        response.should redirect_to('http://blekko.com')
        response.response_code.should == 301
      end
    end

    context "domain is not known" do
      it "should render 404" do
        request.env['HTTP_HOST'] = 'otherdomain.test'
        Domain.should_receive(:where).with(:name => /otherdomain.test/).and_return([])
        get :index, :path => 'no-mapping'
        response.response_code.should == 404
      end
    end
  end
end
