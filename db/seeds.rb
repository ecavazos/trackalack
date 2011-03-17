### Users ###

User.create!({
  email: 'emilio@trackalack.com',
  first_name: 'Emilio',
  last_name: 'Fake',
  password: '1234',
  password_confirmation: '1234'
})

User.create!({
  email: 'jeff@trackalack.com',
  first_name: 'Jeff',
  last_name: 'Fake',
  password: '1234',
  password_confirmation: '1234'
})

User.create!({
  email: 'kevin@trackalack.com',
  first_name: 'Kevin',
  last_name: 'Fake',
  password: '1234',
  password_confirmation: '1234'
})

User.create!({
  email: 'josh@trackalack.com',
  first_name: 'Josh',
  last_name: 'Fake',
  password: '1234',
  password_confirmation: '1234'
})

User.create!({
  email: 'mike@trackalack.com',
  first_name: 'Mike',
  last_name: 'Fake',
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
      :description => "Did a little something for #{p.client.name}."
    }

    attr2 = {
      :date => Date.today - i,
      :duration => 1,
      :work_type => :task,
      :billing_type => :no_charge,
      :description => "#{p.name} required some updates."
    }

    User.all.each do |u|
      p.time_entries.create(attr1.merge(:user => u))
      p.time_entries.create(attr2.merge(:user => u))
      sleep(0.01)
    end

    i += 1
  end
end

