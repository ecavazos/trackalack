require 'spec_helper'

describe 'Project Edit' do

  before do
    sign_in
    @client = Client.gen :name => 'Fanny-Pack'
  end

  it 'should allow user to update the project' do
    project = Project.gen :name => 'Spank Bottom', :client => @client

    visit edit_client_project_path( @client, project )

    find('h2').should have_content('Edit project')

    page.should have_content("Client #{ @client.name }")

    fill_in 'Name', :with => 'Love Muffin'

    click_button 'Save'

    project.reload.name.should == 'Love Muffin'

    current_path.should == client_project_path(@client, project)

    find('#notice').should have_content('Project was successfully updated.')
  end

  it 'should display errors when user submits invalid values' do
    project = Project.gen :name => 'Spank Bottom', :client => @client

    visit edit_client_project_path( @client, project )

    fill_in 'Name', :with => ''

    click_button 'Save'

    project.reload.name.should == 'Spank Bottom'

    within '#error_explanation' do
      find('h2').should have_content('1 error prohibited this project from being saved:')
      page.should have_content("Name can't be blank")
    end
  end
end

