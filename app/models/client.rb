class Client < ActiveRecord::Base
  has_many :projects

  validates_presence_of :name

  scope :recently_created, lambda { |qty| order('created_at desc').limit(qty) }
end
