class Client < ActiveRecord::Base
  has_many :projects

  validates_presence_of :name

  scope :recently_created, lambda { |qty| order('created_at desc').limit(qty) }

  def short_name
    split = self.name.split(' ')

    a = split.shift
    b = ''

    split.each do |x|
      b = b + x[0]
    end

    return "#{a} #{b}."
  end
end
