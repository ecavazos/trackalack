require "spec_helper"

describe TimeEntriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/time_entries" }.should route_to(:controller => "time_entries", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/time_entries/new" }.should route_to(:controller => "time_entries", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/time_entries/1" }.should route_to(:controller => "time_entries", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/time_entries/1/edit" }.should route_to(:controller => "time_entries", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/time_entries" }.should route_to(:controller => "time_entries", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/time_entries/1" }.should route_to(:controller => "time_entries", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/time_entries/1" }.should route_to(:controller => "time_entries", :action => "destroy", :id => "1")
    end

  end
end
