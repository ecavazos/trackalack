require 'spec_helper'

describe TimeEntry do
  before do
    @time_entry = TimeEntry.new({
      :date => Date.today,
      :duration => 2,
      :work_type => :feature,
      :billing_type => :billable
    })
  end

  describe "validations" do
    it "is valid with valid attributes" do
      @time_entry.should be_valid
    end

    it "is not valid without duration" do
      @time_entry.duration = nil
      @time_entry.should_not be_valid
    end

    it "is not valid without date" do
      @time_entry.date = nil
      @time_entry.should_not be_valid
    end

    it "is not valid when duration is 0" do
      @time_entry.duration = 0
      @time_entry.should_not be_valid
    end

    it "is not valid when duration is less than 0" do
      @time_entry.duration = -1
      @time_entry.should_not be_valid
    end

    it "is not valid when work_type is not an allowed work type" do
      @time_entry.work_type = :foo
      @time_entry.should_not be_valid
    end

    it "is not valid when billing_type is not an allowed billing type" do
      @time_entry.billing_type = :foo
      @time_entry.should_not be_valid
    end
  end

  describe "default_scope" do
    before do
      create_time_entry
      create_time_entry
      (1..4).each { |i| create_time_entry(:date => Date.today - i, :created_at => Time.now - (i)) }
    end

    let(:entries) { TimeEntry.all }

    it "should order by date desc" do
      entries[0].date.should be == entries[1].date
      entries[1].date.should be > entries[2].date
      entries[3].date.should be > entries[4].date
    end

    context 'then' do
      it "should order by created_at desc" do
        entries[0].created_at.should be > entries[1].created_at
        entries[1].created_at.should be > entries[2].created_at
      end
    end
  end

  describe "#work_type" do
    it "should return feature" do
      @time_entry.work_type.should eq(:feature)
    end

    it "should return when nil when nil" do
      TimeEntry.new.work_type.should be_nil
    end
  end

  describe "#work_type_display" do
    it "should return empty string when work_type is nil" do
      TimeEntry.new.work_type_display.should eq('')
    end

    it "should return dispay value for work_type" do
      @time_entry.work_type_display.should eq("Feature")
    end
  end

  describe "#billing_type" do
    it "should return billable" do
      @time_entry.billing_type.should eq(:billable)
    end

    it "should return when nil when nil" do
      TimeEntry.new.billing_type.should be_nil
    end
  end

  describe "#billing_type_display" do
    it "should return empty string when billing_type is nil" do
      TimeEntry.new.billing_type_display.should eq('')
    end

    it "should return dispay value for billing_type" do
      @time_entry.billing_type_display.should eq("Billable")
    end
  end

  describe "#duration_display" do
    it "should append hrs to duration" do
      @time_entry.duration_display.should eq('2.0 hrs')
    end
  end

  describe "#abbr_description" do
    it "should return first 6 words and '...'" do
      @time_entry.description = "one two three four five six seven eight nine ten"
      @time_entry.abbr_description.should eq("one two three four five six ...")
    end

    it "should return all the words if less than 6 words" do
      @time_entry.description = "one two three"
      @time_entry.abbr_description.should eq("one two three")
    end
  end

  describe "#limit_days(days)" do
    before do
      (0..6).each { |i| create_time_entry(:date => Date.today - i) }
    end

    it { TimeEntry.limit_days(1).should have(1).time_entries }
    it { TimeEntry.limit_days(3).should have(3).time_entries }
  end

  describe "#date_range(start_date, end_date)" do
    before do
      (0..6).each { |i| create_time_entry(:date => Date.today - i) }
    end

    it { TimeEntry.date_range(Date.today - 2, Date.today).should  have(3).time_entries }
    it { TimeEntry.date_range(Date.today - 3, nil).should  have(1).time_entries }
  end
end
