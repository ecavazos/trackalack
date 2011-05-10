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

  describe "#after_create" do
    it "should create a search index record" do
#      @client.save
#      SearchIndex.should_receive(:create).with({
#        :resource_id => @client.id,
#        :resource_type => @client.class.name,
#        :name => @client.name
#      })
    end
  end
end
