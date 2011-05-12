require 'spec_helper'

describe WorkTypes do
  describe "#all" do
    it "should contain all work types" do
      WorkTypes.all.should eq({:feature => 'Feature', :task => 'Task', :incident => 'Incident'})
    end
  end

  describe "#for_select" do
    it "should return an array for use in select helper" do
      WorkTypes.for_select.should eq([["Feature", :feature], ["Task", :task], ["Incident", :incident]])
    end
  end
end
