class TimeEntry < ActiveRecord::Base
  belongs_to :project, :touch => true
  belongs_to :user

  validates_presence_of :duration
end
