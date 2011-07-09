require 'spec_helper'

describe Client do
  before do
    @client = Client.new :name => 'foo'
  end

  describe "validations" do
    it "is not be valid without name" do
      @client.name = ""
      @client.should_not be_valid
    end
  end

  describe "#short_name" do
    it "should do nothing when name is only one word" do
      @client.name = "Blah"
      @client.short_name.should eq("Blah")
    end

    it "should stip dashes" do
      @client.name = "Foo Dash-Bar"
      @client.short_name.should eq("Foo DB.")
    end

    it "should handle many words" do
      @client.name = "Monster Like Kitties"
      @client.short_name.should eq("Monster LK.")
    end

    it "should not double up periods and the end of a name" do
      @client.name = "Foo Bar Inc."
      @client.short_name.should eq("Foo BI.")
    end
  end

  context "after create" do
    it "should create search index for new client" do
      SearchIndex.should_receive(:create).with({
        :resource_id => 37,
        :resource_type => 'Client',
        :name => 'foo'
      })
      Factory.create(:client, :id => 37, :name => 'foo')
    end
  end

  context "after update" do
    it "should update search index for client" do
      client = Factory.create(:client)
      client.update_attributes(:name => 'pedro')
      SearchIndex.first.name.should == 'pedro'
    end
  end
end
