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

c1 = Client.create(:name => 'The Corporate Business')
c2 = Client.create(:name => 'The Non-Profit')
c3 = Client.create(:name => 'Third Party Vendor')

### Projects ###

c1.projects.create(:name => 'Website')
c1.projects.create(:name => 'WPF App')
c1.projects.create(:name => 'iPad App')
c2.projects.create(:name => 'Database Migration')
c2.projects.create(:name => 'Field App')
c2.projects.create(:name => 'Windows Mobile')
c3.projects.create(:name => 'Design & Analysis')
c3.projects.create(:name => 'iPhone App')
c3.projects.create(:name => 'WinForms App')

### Time Entries ###

30.times do |x|
  i = 0
  projects = Project.all

  attr1 = {
    :date => Date.today - x,
    :duration => 2.5,
    :work_type => :feature,
    :billing_type => :billable,
    :description => "Working on feature requests"
  }

  attr2 = {
    :date => Date.today - x,
    :duration => 3,
    :work_type => :task,
    :billing_type => :no_charge,
    :description => "Small change and redeploy."
  }

  attr3 = {
    :date => Date.today - x,
    :duration => 2.5,
    :work_type => :incident,
    :billing_type => :billable,
    :description => "Bug fixes."
  }

  User.all.each do |u|
    projects[0].time_entries.create(attr1.merge(:user => u))
    projects[3].time_entries.create(attr2.merge(:user => u))
    projects[6].time_entries.create(attr3.merge(:user => u))
    sleep(0.001)
  end

  i += 1
end

