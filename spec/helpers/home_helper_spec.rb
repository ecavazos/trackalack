require 'spec_helper'

describe HomeHelper do
  describe "#format_date(date)" do
    describe "when given a valid date" do
      it "should format date as mm/dd/yyyy" do
        helper.format_date(Date.new(2011, 5, 5)).should eq('05/05/2011')
      end
    end

    describe "when date is nil" do
      it "should be blank" do
        helper.format_date(nil).blank?.should be_true
      end
    end
  end

  describe "#user_edit_time_link(time_entry)" do
    describe "when current_user owns time_entry" do
      before do
        helper.extend Haml::Helpers
        helper.init_haml_helpers
        
        @user = create_user
        @time_entry = mock_model(TimeEntry).as_null_object
        @time_entry.stub(:user).and_return(@user)
        helper.stub(:current_user).and_return(@user)
      end

      it "should contain link to edit time" do
        id = @time_entry.id
        helper.capture_haml {
          helper.user_edit_time_link(@time_entry)
        }.should match(/<a href="\/projects\/#{id}\/time_entries\/#{id}\/edit\" class="edit-time-link">Edit<\/a>/)
      end

      it "should contain active-meta-item class" do
        helper.capture_haml {
          helper.user_edit_time_link(@time_entry)
        }.should match(/class='activity-meta-item'/)
      end
    end

    describe "when current_user is not the owner of the time_entry" do
      before do
        @time_entry = mock_model(TimeEntry).as_null_object
        helper.stub(:current_user).and_return(nil)
      end

      it "should be nil" do
        helper.user_edit_time_link(@time_entry).should be_nil
      end
    end
  end
end
