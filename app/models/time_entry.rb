class TimeEntry < ActiveRecord::Base
  belongs_to :project, :touch => true
  belongs_to :user

  validates_presence_of :duration, :date
  validates_numericality_of :duration, :greater_than => 0
  validates_inclusion_of :work_type, :in => WorkTypes.all
  validates_inclusion_of :billing_type, :in => BillingTypes.all

  default_scope order('date desc, created_at desc')

  def work_type
    v = read_attribute(:work_type)
    return v if v.nil?
    v.to_sym
  end

  def work_type= (value)
    write_attribute(:work_type, value.to_s)
  end

  def work_type_display
    self.work_type ? WorkTypes.all[self.work_type] : ''
  end

  def billing_type
    v = read_attribute(:billing_type)
    return v if v.nil?
    v.to_sym
  end

  def billing_type= (value)
    write_attribute(:billing_type, value.to_s)
  end

  def billing_type_display
    self.billing_type ? BillingTypes.all[self.billing_type] : ''
  end

  def duration_display
    "#{self.duration} hrs"
  end

  def abbr_description
    desc = self.description.split(' ')
    if desc.size > 6
      desc = self.description.split(' ')[0,6].join(' ')
      "#{desc} ..."
    else
      self.description
    end
  end

  def self.limit_days(days)
    self.date_range((Date.today - days), Date.today)
  end

  def self.date_range(start_date, end_date)
    end_date = (end_date.instance_of? Date)? end_date : start_date
    where(:date => start_date..end_date)
  end
end
