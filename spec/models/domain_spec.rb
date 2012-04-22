require 'spec_helper'

describe Domain do
  describe "#name" do
    context "invalid" do
      it "should be invalid if the name is nil" do
        @domain = Domain.new(:name => nil, :catch_all => 'http://google.com')
        @domain.valid?.should be_false
      end

      it "should be invalid if it starts with http://" do
        @domain = Domain.new(:name => 'http://google.com', :catch_all => 'http://google.com')
        @domain.valid?.should be_false
      end
    end
    
    context "valid" do
      it "should strip a leading www from the name" do
        @domain = Domain.new(:name => 'www.google.com', :catch_all => 'http://google.com')
        @domain.save
        @domain.name.should == 'google.com'
        @domain.valid?.should be_true
      end
    end
  end

  describe "#catch_all" do
    context "invalid" do
      it "should be invalid if it's nil" do
        @domain = Domain.new(:name => 'hello.com', :catch_all => nil)
        @domain.valid?.should be_false
      end

      it "should be invalid if it doesn't include the http://" do
        @domain = Domain.new(:name => 'hello.com', :catch_all => 'something.com')
        @domain.valid?.should be_false
      end
    end
  end
end
