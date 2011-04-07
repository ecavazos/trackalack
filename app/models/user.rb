class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :first_name, :last_name

  has_many :time_entries

  def fullname
    "#{first_name} #{last_name}"
  end

  def pathname
    fullname.downcase.gsub(' ', '_')
  end

  after_create do |user|
    SearchIndex.create({
      :resource_id => user.id,
      :resource_type => user.class.name,
      :name => user.fullname
    })
  end

  after_update do |user|
    si = SearchIndex.where(:resource_id => user.id, :resource_type => user.class.name).first
    si.update_attributes({
      :name => user.fullname
    })
  end
end
