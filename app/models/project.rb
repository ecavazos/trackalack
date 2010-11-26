class Project < ActiveRecord::Base
  belongs_to :client
  has_many :time_entries

  validates_presence_of :name
end
