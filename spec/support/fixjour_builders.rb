require 'fixjour'

Fixjour do
  define_builder(User, :first_name => 'foo', :last_name => 'bar', :email => "testuser@trackalack.com", :password => '1234')
#  define_builder(User) do |klass, overrides|
#    klass.new(:first_name => 'foo', :last_name => 'bar', :email => "testuser@trackalack.com", :password => '1234')
#  end
end

