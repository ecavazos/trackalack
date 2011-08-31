require 'spec_helper'

describe 'Client new' do

  it 'should allow user to create a new client' do
    sign_in

    Client.count.should == 0

    visit new_client_path

    find('h2').should have_content 'New client'

    fill_in 'client[name]', :with => 'Silly Bits'

    click_button 'Save'

    client = Client.first
    client.name.should == 'Silly Bits'

    current_path.should == client_path( client )

    find('#notice').should have_content 'Client was successfully created.'
  end

  it 'should display errors when user submits invalid values' do
    sign_in

    visit new_client_path

    click_button 'Save'

    within '#error_explanation' do
      page.should have_content "Name can't be blank"
    end
  end
end
