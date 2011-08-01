require 'spec_helper'

describe Client do

  describe Client, '#name=' do

    it 'requires name' do
      Client.new(:name =>             nil).should_not be_valid
      Client.new(:name => 'Turd Ferguson').should be_valid
    end
  end

  describe Client, "#short_name" do

    it 'does NOT alter single word names' do
      Client.new(:name => 'Blah').short_name.should == 'Blah'
    end

    it 'uses only the first inital after the first word' do
      Client.new(
        :name => 'Monster Like Kitties'
      ).short_name.should == 'Monster LK.'
    end

    it 'removes dashes' do
      Client.new(:name => 'Foo Dash-Bar').short_name.should == 'Foo DB.'
    end

    it 'does NOT add a period to names that already end with a period' do
      Client.new(:name => 'Foo Bar Inc.').short_name.should == 'Foo BI.'
    end
  end
end
