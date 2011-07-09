require 'spec_helper'

describe User do

  before do
    @user = User.new(:first_name => 'Foo', :last_name => 'Bar')
  end

  describe "#fullname" do
    subject { @user.fullname }

    it { should eq('Foo Bar') }
  end

  describe "#pathname" do
    subject { @user.pathname }

    it { should eq('foo_bar') }
  end

  context "after create" do
    it "should create search index for new user" do
      SearchIndex.should_receive(:create).with({
        :resource_id => 37,
        :resource_type => 'User',
        :name => 'foo bar'
      })
      Factory.create(:user, :id => 37, :first_name => 'foo', :last_name => 'bar')
    end
  end

  context "after update" do
    it "should update search index for user" do
      user = Factory.create(:user)
      user.update_attributes(:first_name => 'john', :last_name => 'cage')
      SearchIndex.first.name.should == 'john cage'
    end
  end
end
