require 'spec_helper'

describe "time_entries/edit.html.haml" do
  before(:each) do
    @time_entry = assign(:time_entry, stub_model(TimeEntry,
      :new_record? => false,
      :duration => 1,
      :description => "MyText",
      :project => nil,
      :user => nil
    ))
  end

  it "renders the edit time_entry form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => time_entry_path(@time_entry), :method => "post" do
      assert_select "input#time_entry_duration", :name => "time_entry[duration]"
      assert_select "textarea#time_entry_description", :name => "time_entry[description]"
      assert_select "input#time_entry_project", :name => "time_entry[project]"
      assert_select "input#time_entry_user", :name => "time_entry[user]"
    end
  end
end