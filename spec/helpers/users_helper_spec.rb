require 'spec_helper'

describe UsersHelper do
  describe "#user_show_time_title" do
    before do
      @params = {
        :start_date => '',
        :end_date => '',
        :days => ''
      }
    end
    describe "when no filter parameters are present" do
      it "should return base message" do
        helper
          .user_show_time_title
          .should eq("Time entries for last 5 days")
      end
    end

    describe "when start and end date parameters are present" do
      it "should return date range message" do
        helper.stub(:params).and_return(@params.merge({
          :start_date => '5/6/2011',
          :end_date => '6/6/2011'
        }))
        helper
          .user_show_time_title
          .should eq("Time entries between 5/6/2011 and 6/6/2011")
      end
    end

    describe "when only the start date parameter is present" do
      it "should return message for the date selected" do
        helper.stub(:params).and_return(@params.merge({ 
          :start_date => '5/6/2011'
        }))
        helper
          .user_show_time_title
          .should eq("Time entries for 5/6/2011")
      end
    end

    describe "when only the days parameter is present" do
      it "should return message for days" do
        helper.stub(:params).and_return(@params.merge({ 
          :days => 15
        }))
        helper
          .user_show_time_title
          .should eq("Time entries for last 15 days")
      end
    end

    describe "when the days parameter is blank and flash contains error or start_date is nil" do
      it "should return base message" do
        @params.delete(:days)
        helper.stub(:params).and_return(@params.merge({ :start_date => nil }))
        helper
          .user_show_time_title
          .should eq("Time entries")
      end

      it "should return base message" do
        @params.delete(:days)
        helper.stub(:flash).and_return({ :error => '' })
        helper.stub(:params).and_return(@params)
        helper
          .user_show_time_title
          .should eq("Time entries")
      end
    end
  end

  describe "#edit_link_data(time)" do
    it "should output hash for edit link" do
      time = mock_model(TimeEntry).as_null_object
      id = time.id
      helper.edit_link_data(time).should eq({
        :name  => "Edit Time",
        :path  => "/projects/#{id}/time_entries/#{id}/edit",
        :class => "edit-time-link"
      })
    end
  end

  describe "#add_link_data(time)" do
    it "should output hash for add link" do
      time = mock_model(TimeEntry).as_null_object
      id = time.id
      helper.add_link_data(time).should eq({
        :name  => "Add Time to Project",
        :path  => "/projects/#{id}/time_entries/new",
        :class => "add-time-link"
      })
    end
  end

  describe "#destroy_link_data(time)" do
    it "should output hash for destroy link" do
      time = mock_model(TimeEntry).as_null_object
      id = time.id
      helper.destroy_link_data(time).should eq({
        :name  => "Destroy",
        :path  => "/projects/#{id}/time_entries/#{id}"
      })
    end
  end
end
