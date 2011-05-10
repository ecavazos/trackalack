class Client < ActiveRecord::Base
  has_many :projects

  validates_presence_of :name

  scope :recently_created, lambda { |qty| order('created_at desc').limit(qty) }

  def short_name
    split = self.name.gsub('-', ' ').split(' ')

    a = split.shift
    b = ''

    split.each do |x|
      b = b + x[0]
    end

    (b.empty?) ? a : "#{a} #{b}."
  end

  after_create do |client|
    SearchIndex.create({
      :resource_id => client.id,
      :resource_type => client.class.name,
      :name => client.name
    })
  end

  after_update do |client|
    si = SearchIndex.where(:resource_id => client.id, :resource_type => client.class.name).first
    si.update_attributes({
      :name => client.name
    })
  end
end
