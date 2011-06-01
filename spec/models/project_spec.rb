require 'spec_helper'

describe Project do
  before do
    @project = Project.new :name => 'foo'
  end

  context "validations" do
    it "is not valid without name" do
      @project.name = ""
      @project.should_not be_valid
    end
  end

  context "after create" do
    it "should create search index for new project" do
      SearchIndex.should_receive(:create).with({
        :resource_id => 1,
        :resource_type => 'Project',
        :name => 'foo'
      })
      create_project(:name => 'foo')
    end
  end

  context "after update" do
    it "should update search index for project" do
      project = create_project
      project.update_attributes(:name => 'ibm')
      SearchIndex.first.name.should == 'ibm'
    end
  end
end
