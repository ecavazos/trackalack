class Project < ActiveRecord::Base
  belongs_to :client
  has_many :time_entries

  validates_presence_of :name

  # scopes
  scope :recently_updated, lambda { |qty| includes(:client).order('updated_at desc').limit(qty) }
  scope :recently_created, lambda { |qty| order('created_at desc').limit(qty) }

  after_create do |project|
    SearchIndex.create({
      :resource_id => project.id,
      :resource_type=> project.class.name,
      :name => project.name
    })
  end

  after_update do |project|
    si = SearchIndex.where(:resource_id => project.id, :resource_type => project.class.name).first
    si.update_attributes({
      :name => project.name
    })
  end
end
