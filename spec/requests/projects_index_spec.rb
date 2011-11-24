require 'spec_helper'

describe 'Projects Index', :js => true do

  before do
    @user = sign_in
  end

  it 'lists all projects' do
    client1 = Client.gen :name => 'Dirt Bagz'
    client2 = Client.gen :name => 'Sleez Wiz'

    3.times { |i| Project.gen :name => "Proj: #{i}", :client => client1 }
    3.times { |i| Project.gen :name => "Proj: #{i}", :client => client2 }

    visit projects_path

    find('h2').text.should  == 'Listing projects'

    rows = all('tr')

    # displays all the projects for client 1
    rows[0..2].each do |row|
      page.should have_content(client1.name)
      page.should have_content(client1.projects.first.name)
      page.should have_content(client1.projects.second.name)
      page.should have_content(client1.projects.third.name)
    end

    # displays all the projects for client 2
    rows[3..5].each do |row|
      page.should have_content(client2.name)
      page.should have_content(client2.projects.first.name)
      page.should have_content(client2.projects.second.name)
      page.should have_content(client2.projects.third.name)
    end
  end

  it 'should sort some kind of way'

  it 'links to project show page' do
    client  = Client.gen  :name => 'Dirt Bagz'
    project = Project.gen :name => 'Website', :client => client

    visit projects_path

    within 'tbody tr' do
      click_link 'Menu'
      click_link 'Show'
    end

    current_path.should == project_path(project)
  end
end
