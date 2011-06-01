class Client < ActiveRecord::Base
  has_many :projects

  validates_presence_of :name

  scope :recently_created, lambda { |qty| order('created_at desc').limit(qty) }

  def short_name
    split = self.name.gsub('-', ' ').split(' ')

    a = split.shift
    b = split.map { |word| word[0] }.join

    (b.empty?) ? a : "#{a} #{b}."
  end
end
