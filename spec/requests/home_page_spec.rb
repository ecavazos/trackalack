require 'spec_helper'

describe 'Home Page', :js => true do

  context 'Recent Time Entries' do
    it 'has title' do
      visit root_path
      should have_content 'Recent Time Entries'
    end

    it 'displays time entries by created at date descending' do
      user = sign_in

      with_timestamping_disabled TimeEntry do
        Factory.create :time_entry, :description => 'foo3', :user => user, :created_at => Time.now.ago(2.day)
        Factory.create :time_entry, :description => 'foo2', :user => user, :created_at => Time.now.ago(1.day)
        Factory.create :time_entry, :description => 'foo1', :user => user, :created_at => Time.now
      end

      visit root_path

      entries = all('#stream .activity')

      entries[0].should have_content 'foo1'
      entries[1].should have_content 'foo2'
      entries[2].should have_content 'foo3'
    end
  end

end
