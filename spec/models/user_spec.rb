require 'spec_helper'

describe User do

  describe TimeEntry, '#fullname' do

    it 'should return full name' do
      user = Factory.build(:user, :first_name => 'Sam', :last_name => 'Sneed')
      user.fullname.should == 'Sam Sneed'
    end
  end

  describe TimeEntry, '#pathname' do

    it 'should return name formatted for URLs' do
      user = Factory.build(:user, :first_name => 'Sam', :last_name => 'Sneed')
      user.pathname.should == 'sam_sneed'
    end
  end
end
