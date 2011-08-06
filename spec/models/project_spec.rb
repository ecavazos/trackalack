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
      Factory.build(:project, :client =>        nil).should be_valid
      Factory.build(:project, :client => Client.new).should be_valid
    end
  end

  describe Project, '#time_entries=' do

    it 'can have many time_entries' do
      Factory.build(:project, :time_entries => []).should be_valid
      time_entries = Array.new(2) { Factory.build :time_entry }
      Factory.build(:project, :time_entries => time_entries).should be_valid
    end
  end
end
