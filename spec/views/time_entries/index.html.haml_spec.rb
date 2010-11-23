require 'spec_helper'

describe "time_entries/index.html.haml" do
  before(:each) do
    assign(:time_entries, [
      stub_model(TimeEntry,
        :duration => 1,
        :description => "MyText",
        :project => nil,
        :user => nil
      ),
      stub_model(TimeEntry,
        :duration => 1,
        :description => "MyText",
        :project => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of time_entries" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
