require 'spec_helper'

describe ProjectsHelper do
  describe "#secure_edit(time_entry)" do
    describe "when time_entry is owned by current_user" do

      it "should return a link to edit time" do
        user = Factory.create(:user)
        time = mock_model(TimeEntry).as_null_object
        id = time.id
        time.stub(:user).and_return(user)
        helper.stub(:current_user).and_return(user)

        helper.secure_edit(time).should eq("<a href=\"/projects/#{id}/time_entries/#{id}/edit\" class=\"edit-time-link\">Edit</a>")
      end
    end

    describe "when time_entry is not owned by current_user" do
      it "should return blank" do
        time = mock_model(TimeEntry).as_null_object
        helper.stub(:current_user)
        helper.secure_edit(time).should eq("")
      end
    end
  end

  describe "#secure_destroy" do
    describe "when time_entry is owned by current_user" do
      it "should return a link to destroy time" do
        user = Factory.create(:user)
        time = mock_model(TimeEntry).as_null_object
        id = time.id
        time.stub(:user).and_return(user)
        helper.stub(:current_user).and_return(user)

        helper.secure_destroy(time).should eq("<a href=\"/projects/#{id}/time_entries/#{id}\" data-confirm=\"Are you sure?\" data-method=\"delete\" rel=\"nofollow\">Destroy</a>")
      end
    end

    describe "when time_entry is not owned by current_user" do
      it "should return blank" do
        time = mock_model(TimeEntry).as_null_object
        helper.stub(:current_user)
        helper.secure_destroy(time).should eq("")
      end
    end
  end
end
