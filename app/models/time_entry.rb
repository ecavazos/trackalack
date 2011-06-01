class TimeEntry < ActiveRecord::Base
  extend EnumAttributes

  belongs_to :project, :touch => true
  belongs_to :user

  validates_presence_of :duration, :date
  validates_numericality_of :duration, :greater_than => 0
  validates_inclusion_of :work_type, :in => WorkTypes.all
  validates_inclusion_of :billing_type, :in => BillingTypes.all

  default_scope order('date desc, created_at desc')

  scope :all_assoc_limited, lambda { |qty| includes(:user, :project => :client).order('created_at desc').limit(qty) }

  enum_attr :work_type
  enum_attr :billing_type

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
    self.date_range((Date.today - (days - 1)), Date.today)
  end

  def self.date_range(start_date, end_date)
    end_date = (end_date.instance_of? Date)? end_date : start_date
    where(:date => start_date..end_date)
  end
end
