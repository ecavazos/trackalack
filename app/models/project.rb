class Project < ActiveRecord::Base
  belongs_to :client
  has_many :time_entries

  validates_presence_of :name

  # scopes
  scope :recently_updated, lambda { |qty| includes(:client).order('updated_at desc').limit(qty) }
  scope :recently_created, lambda { |qty| order('created_at desc').limit(qty) }
end
