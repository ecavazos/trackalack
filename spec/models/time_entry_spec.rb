require 'spec_helper'

describe TimeEntry do

  describe TimeEntry, '#duration=' do

    it 'should be required' do
      Factory.build(:time_entry, :duration => nil).should_not be_valid
      Factory.build(:time_entry, :duration => 2.5).should     be_valid
    end

    it 'should be a number' do
      Factory.build(:time_entry, :duration => 'poop').should_not be_valid
      Factory.build(:time_entry, :duration =>    2.5).should     be_valid
    end

    it 'should be greater than 0' do
      Factory.build(:time_entry, :duration => -1).should_not be_valid
      Factory.build(:time_entry, :duration =>  0).should_not be_valid
      Factory.build(:time_entry, :duration =>  5).should     be_valid
    end
  end

  describe TimeEntry, '#date=' do

    it 'should be required' do
      Factory.build(:time_entry, :date =>      nil).should_not be_valid
      Factory.build(:time_entry, :date => Time.now).should     be_valid
    end
  end

  describe TimeEntry, '#work_type=' do

    it 'should be in allowed work types' do
      Factory.build(:time_entry, :work_type =>      :foo).should_not be_valid
      Factory.build(:time_entry, :work_type =>  :feature).should     be_valid
      Factory.build(:time_entry, :work_type =>     :task).should     be_valid
      Factory.build(:time_entry, :work_type => :incident).should     be_valid
    end
  end

  describe TimeEntry, '#billing_type=' do

    it 'should be in allowed billing types' do
      Factory.build(:time_entry, :billing_type =>          :foo).should_not be_valid
      Factory.build(:time_entry, :billing_type =>     :billable).should     be_valid
      Factory.build(:time_entry, :billing_type => :non_billable).should     be_valid
      Factory.build(:time_entry, :billing_type =>    :no_charge).should     be_valid
    end
  end

  describe TimeEntry, '.all' do

    before do
      2.times { Factory.create(:time_entry, :date => Date.today) }

      (1..4).each do |i|
        Factory.create(:time_entry,
                       :date       => Date.today - i,
                       :created_at => Time.now   - i)
      end
    end

    let(:entries) { TimeEntry.all }

    it 'should order by date desc' do
      entries[0].date.should be == entries[1].date
      entries[1].date.should be > entries[2].date
      entries[3].date.should be > entries[4].date
    end

    context 'then' do

      it 'should order by created_at desc' do
        entries[0].created_at.should be > entries[1].created_at
        entries[1].created_at.should be > entries[2].created_at
      end
    end
  end

  describe TimeEntry, '#work_type_display' do

    it 'should return work type in a human readable form' do
      time_entry = Factory.build(:time_entry, :work_type => :feature)
      time_entry.work_type_display.should == 'Feature'
    end
  end

  describe TimeEntry, '#billing_type_display' do

    it 'should return billing type in a human readable form' do
      time_entry = Factory.build(:time_entry, :billing_type => :non_billable)
      time_entry.billing_type_display.should == 'Non-Billable'
    end
  end

  describe TimeEntry, '#duration_display' do

    it 'should append duration in a human readable form' do
      time_entry = Factory.build(:time_entry, :duration => 2)
      time_entry.duration_display.should == '2.0 hrs'
    end
  end

  describe TimeEntry, '#abbr_description' do

    it 'should add "..." after the first 6 words' do
      description = 'one two three four five six seven eight nine ten'
      time_entry  = Factory.build(:time_entry, :description => description)
      time_entry.abbr_description.should == 'one two three four five six ...'
    end

    it 'should return all the words if less than 6 words' do
      description = 'one two three'
      time_entry  = Factory.build(:time_entry, :description => description)
      time_entry.abbr_description.should == 'one two three'
    end
  end

  describe TimeEntry, '#limit_days(days)' do

    before do
      (0..6).each { |i| Factory.create(:time_entry, :date => Date.today - i) }
    end

    it 'should return latest time entries for 1 day' do
      TimeEntry.limit_days(1).should have(1).time_entries
    end

    it 'should return latest time entries for 3 days' do
      TimeEntry.limit_days(3).should have(3).time_entries
    end
  end

  describe TimeEntry, '#date_range(start_date, end_date)' do

    before do
      (0..6).each { |i| Factory.create(:time_entry, :date => Date.today - i) }
    end

    it 'should find time entries within date range' do
      s = Date.today - 2
      e = Date.today
      TimeEntry.date_range(s, e).should have(3).time_entries
    end

    it 'should find time entries for the given day' do
      TimeEntry.date_range(Date.today - 3, nil).should  have(1).time_entries
    end
  end
end
