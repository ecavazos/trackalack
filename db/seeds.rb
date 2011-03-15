### Users ###

User.create!({
  email: 'fake1@trackalack.com',
  first_name: 'Fake',
  last_name: 'User 1',
  password: '1234',
  password_confirmation: '1234'
})

User.create!({
  email: 'fake2@trackalack.com',
  first_name: 'Fake',
  last_name: 'User 2',
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
  i = 0

  30.times do |x|
    attr1 = {
      :date => Date.today - i,
      :duration => 3.5,
      :work_type => :feature,
      :billing_type => :billable,
      :description => "Did a little something for #{p.client.name}.",
      :user => User.find(1)
    }

    attr2 = {
      :date => Date.today - i,
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

    i += 1
  end
end

