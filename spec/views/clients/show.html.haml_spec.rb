require 'spec_helper'

describe "clients/show.html.haml" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
