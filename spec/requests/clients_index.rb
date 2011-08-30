require 'spec_helper'

describe 'Clients Index', :js => true do

  it 'should list all clients' do
    user = sign_in

    client1 = Client.gen :name => 'Fred'
    client2 = Client.gen :name => 'Barney'

    visit clients_path

    find('h2').should have_content 'Clients'

    # table header
    within '.data-table' do
      find('th:first').should have_content 'Name'

      find('tr:nth-child(2) td:first').should have_content client1.name
      find('tr:nth-child(2) td:last' ).should have_css '.item-menu-button'

      find('tr:nth-child(3) td:first').should have_content client2.name
      find('tr:nth-child(3) td:last' ).should have_css '.item-menu-button'
    end
  end

  it 'should prompt the user to create a new client when none exist'
  it 'should link to new client page'
  it 'should link to show page'
  it 'should link to edit page'
  it 'should link to destroy page'

end
