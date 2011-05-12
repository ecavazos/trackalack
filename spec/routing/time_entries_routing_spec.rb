require "spec_helper"

describe TimeEntriesController do
  describe "routing" do

    it "recognizes and generates new" do
      { :get => "/projects/1/time_entries/new" }.should route_to(:controller => "time_entries", :action => "new", :project_id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/projects/1/time_entries/1/edit" }.should route_to(:controller => "time_entries", :action => "edit", :id => "1", :project_id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/projects/1/time_entries" }.should route_to(:controller => "time_entries", :action => "create", :project_id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/projects/1/time_entries/1" }.should route_to(:controller => "time_entries", :action => "update", :id => "1", :project_id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/projects/1/time_entries/1" }.should route_to(:controller => "time_entries", :action => "destroy", :id => "1", :project_id => "1")
    end

  end
end
