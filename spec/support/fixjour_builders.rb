require 'fixjour'

Fixjour do
  define_builder(User, :first_name => 'foo', :last_name => 'bar', :email => "testuser@trackalack.com", :password => '1234')
  define_builder(SearchIndex, :resource_id => '37', :name => 'foo', :resource_type => 'client')
  define_builder(TimeEntry, :date => Date.new, :duration => 3.5, :work_type => :feature, :billing_type => :billable, :description => 'foo')
end

