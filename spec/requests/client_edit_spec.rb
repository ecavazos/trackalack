require 'spec_helper'

describe 'Client Edit' do

  it 'should allow user to update the client' do
    client = Client.gen :name => 'Monkey King'

    sign_in

    visit edit_client_path( client )

    find('h2').should have_content('Client Edit')

    fill_in 'client[name]', :with => 'Lion King'

    click_button 'Save'

    client.reload.name.should == 'Lion King'

    current_path.should == client_path( client )

    find('#notice').should have_content('Client was successfully updated.')
  end

  it 'should display errors when user submits invalid values' do
    client = Client.gen :name => 'Sammy Sung'

    sign_in

    visit edit_client_path( client )

    fill_in 'client[name]', :with => ''

    click_button 'Save'

    client.reload.name.should == 'Sammy Sung'

    within '#error_explanation' do
      page.should have_content("Name can't be blank")
    end
  end
end
