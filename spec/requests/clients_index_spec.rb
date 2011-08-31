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

  it 'should prompt the user to create a new client when none exist' do
    user = sign_in

    visit clients_path

    find('.prompt').should have_content 'You have 0 clients. Add a client.'
    page.should_not have_css '.data-table'

    click_link 'Add a client'

    current_path.should == new_client_path
  end

  it 'should link to new client page' do
    user = sign_in

    visit clients_path

    within '#manage-nav' do
      click_link 'New Client'
    end

    current_path.should == new_client_path
  end

  it 'should link to show page' do
    user = sign_in

    client = Client.gen :name => 'Mr. Blue'

    visit clients_path

    within '.data-table tr:nth-child(2)' do
      click_link 'Menu'
      click_link 'Show'
    end

    current_path.should == client_path( client )
  end

  it 'should link to edit page' do
    user = sign_in

    client = Client.gen :name => 'Mr. Blue'

    visit clients_path

    within '.data-table tr:nth-child(2)' do
      click_link 'Menu'
      click_link 'Edit'
    end

    current_path.should == edit_client_path( client )
  end

  it 'should allow user to delete a client' do
    user = sign_in

    client = Client.gen :name => 'Mr. Blue'

    visit clients_path

    Client.exists?( client.id ).should be_true

    page.evaluate_script('window.confirm = function() { return true; }')

    within '.data-table tr:nth-child(2)' do
      click_link 'Menu'
      click_link 'Destroy'
    end

    current_path.should == clients_path

    Client.exists?( client.id ).should be_false
  end

  it 'should allow user to cancel delete' do
    user = sign_in

    client = Client.gen :name => 'Mr. Blue'

    visit clients_path

    Client.exists?( client.id ).should be_true

    page.evaluate_script('window.confirm = function() { return false; }')

    within '.data-table tr:nth-child(2)' do
      click_link 'Menu'
      click_link 'Destroy'
    end

    current_path.should == clients_path

    Client.exists?( client.id ).should be_true
  end
end
