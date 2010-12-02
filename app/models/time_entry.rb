class TimeEntry < ActiveRecord::Base
  belongs_to :project, :touch => true
  belongs_to :user

  validates_presence_of :duration
  validates_inclusion_of :work_type, :in => [:feature, :task, :incident]

  default_scope order('date desc, created_at desc')

  def work_type
    v = read_attribute(:work_type)
    return v if v.nil?
    v.to_sym
  end

  def work_type= (value)
    write_attribute(:work_type, value.to_s)
  end

end
