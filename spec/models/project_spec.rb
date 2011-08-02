require 'spec_helper'

describe Project do

  describe Project, '#name=' do

    it 'is required' do
      Project.new(:name =>                nil).should_not be_valid
      Project.new(:name => 'Fascinating Work').should be_valid
    end
  end

  describe Project, '#client=' do

    it 'can be associated with a client' do
      Factory.create(:project, :client =>        nil).should be_valid
      Factory.create(:project, :client => Client.new).should be_valid
    end
  end

  describe Project, '#time_entries=' do

    it 'can have many time_entries' do
      Factory.create(:project, :time_entries => []).should be_valid
      time_entries = Array.new(2) { Factory.create :time_entry }
      Factory.create(:project, :time_entries => time_entries).should be_valid
    end
  end
end
