# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


### Users ###

User.create({ :full_name => 'Cheech Marin',
              :email    => 'cheech@cc.com' })

User.create({ :full_name => 'Thomas Chong',
              :email    => 'chong@cc.com' })

### Clients ###

Client.create(:name => 'Tokers Plus')
Client.create(:name => 'Local Gov')
Client.create(:name => 'High Skewl Kidz')

### Projects ###

Client.all.each do |c|
  c.projects.create(:name => 'Website')
  c.projects.create(:name => 'iPad App')
  c.projects.create(:name => 'Database Migration')
end

### Time Entries ###

Project.all.each do |p|
  50.times do |x|
    attr1 = {
      :date => Date.today,
      :duration => 3.5,
      :description => 'Blah some more blah. And super blah even.',
      :user => User.find(1)
    }

    attr2 = {
      :date => Date.today,
      :duration => 4.5,
      :description => 'Blah some more blah. And super blah even.',
      :user => User.find(2)
    }

    p.time_entries.create(attr1)
    sleep(0.1)

    p.time_entries.create(attr2)
    sleep(0.1)
  end
end

