# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


### Users ###

User.create!({
  email: 'bob@trackalack.com',
  first_name: 'Bob',
  last_name: 'Stone',
  password: '1234',
  password_confirmation: '1234'
})

User.create!({
  email: 'rob@trackalack.com',
  first_name: 'Rob',
  last_name: 'Rock',
  password: '1234',
  password_confirmation: '1234'
})

### Clients ###

Client.create(:name => 'The Business People')
Client.create(:name => 'Local Government')
Client.create(:name => 'Technology Consultants')

### Projects ###

Client.all.each do |c|
  c.projects.create(:name => 'Website')
  c.projects.create(:name => 'WPF App')
  c.projects.create(:name => 'iPad App')
  c.projects.create(:name => 'Database Migration')
end

### Time Entries ###

Project.all.each do |p|
  30.times do |x|
    attr1 = {
      :date => Date.today,
      :duration => 3.5,
      :work_type => :feature,
      :billing_type => :billable,
      :description => "Did a little something for #{p.client.name}.",
      :user => User.find(1)
    }

    attr2 = {
      :date => Date.today,
      :duration => 4.5,
      :work_type => :task,
      :billing_type => :no_charge,
      :description => "#{p.name} required some updates.",
      :user => User.find(2)
    }

    p.time_entries.create(attr1)
    sleep(0.01)

    p.time_entries.create(attr2)
    sleep(0.01)
  end
end

