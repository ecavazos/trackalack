Factory.define :user do |f|
  f.first_name 'luke'
  f.last_name 'skywalker'
  f.email 'skywalker@trackalack.com'
  f.password '1234'
end

Factory.define :time_entry do |f|
  f.date Date.today
  f.duration 3.5
  f.work_type :feature
  f.billing_type :billable
  f.description 'foo'
  f.project { Factory.create(:project) }
end

Factory.define :project do |f|
  f.name 'foo'
  f.client { Factory.create(:client) }
end

Factory.define :client do |f|
  f.name 'foo'
end

Factory.define :search_index do |f|
  f.resource_id 37
  f.name 'foo'
  f.resource_type 'client'
end
