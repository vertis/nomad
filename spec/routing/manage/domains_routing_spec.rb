require "spec_helper"

describe Manage::DomainsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/manage_domains" }.should route_to(:controller => "manage_domains", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/manage_domains/new" }.should route_to(:controller => "manage_domains", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/manage_domains/1" }.should route_to(:controller => "manage_domains", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/manage_domains/1/edit" }.should route_to(:controller => "manage_domains", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/manage_domains" }.should route_to(:controller => "manage_domains", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/manage_domains/1" }.should route_to(:controller => "manage_domains", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/manage_domains/1" }.should route_to(:controller => "manage_domains", :action => "destroy", :id => "1")
    end

  end
end
