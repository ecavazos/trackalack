require 'spec_helper'

describe Project do
  before do
    @project = Project.new :name => 'foo'
  end

  describe "validations" do
    it "is not valid without name" do
      @project.name = ""
      @project.should_not be_valid
    end
  end
end
