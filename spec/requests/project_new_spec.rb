require 'spec_helper'

describe 'Project new' do

  before do
    sign_in
    @client = Client.gen :name => 'Fanny-Pack'
  end

  it 'should allow user to create a new project' do
    Project.count.should == 0

    visit new_client_project_path(@client)

    find('h2').should have_content('New project')

    page.should have_content("Client #{ @client.name }")

    fill_in 'Name', :with => 'Food Face'

    click_button 'Save'

    Project.count.should == 1

    project = Project.first
    project.name.should == 'Food Face'

    current_path.should == projects_path

    find('#notice').should have_content('Project was successfully created.')
  end

  it 'should display errors when user submits invalid values' do
    visit new_client_project_path(@client)

    click_button 'Save'

    within '#error_explanation' do
      find('h2').should have_content('1 error prohibited this project from being saved:')
      page.should have_content("Name can't be blank")
    end
  end
end
