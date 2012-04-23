require 'spec_helper'

describe Mapping do
  describe "#source_path" do
    context "invalid" do
      it "should be invalid if the source_path is nil" do
        @mapping = Mapping.new(:target => 'http://vertis.github.com')
        @mapping.valid?.should be_false
      end
      
      it "should be invalid if there isn't a slash at the start" do
        @mapping = Mapping.new(:source_path => 'invalidpath', :target => 'http://vertis.github.com')
        @mapping.valid?.should be_false
      end
    end
  end
  
  describe "#target" do
    context "invalid" do
      it "should be invalid if the target is nil" do
        @mapping = Mapping.new(:source_path => '/validpath')
        @mapping.valid?.should be_false
      end
      
      it "should be invalid if there isn't a http at the start" do
        @mapping = Mapping.new(:source_path => '/validpath', :target => 'invalidurl')
        @mapping.valid?.should be_false
      end
    end
  end
  
  describe "#slug"do
    it "should not have a slash at the start" do
      @mapping = Mapping.new(:source_path => '/validpath')
      @mapping.slug.should == 'validpath'
    end
    
    it "should be shortened to 20 characters" do
      @mapping = Mapping.new(:source_path => '/hello-i-am-longer-than-20-characters')
      @mapping.slug.gsub(' ...','').length == 20
    end
  end
end
