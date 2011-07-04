require 'spec_helper'

describe 'Signing in', :js => true do
  it 'should sign in successfully' do
    Factory.create :user

    visit new_user_session_path

    page.should have_content 'Sign in'

    fill_in 'user_email', :with => 'skywalker@trackalack.com'
    fill_in 'user_password', :with => '1234'

    click_button 'Sign in'

    page.should have_content 'Signed in successfully.'
    current_path.should == root_path
  end

  it 'should notify user of invalid sign in' do
    visit new_user_session_path

    page.should have_content 'Sign in'

    fill_in 'user_email', :with => 'eeeeh@trackalack.com'
    fill_in 'user_password', :with => 'wrong'

    click_button 'Sign in'

    page.should have_content 'Invalid email or password.'
    current_path.should == new_user_session_path
    save_and_open_page
  end
end
