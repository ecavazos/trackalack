require 'spec_helper'

describe 'Signing in', :js => true do
  it 'should' do
    visit new_user_session_path

    fill_in 'user_email', :with => 'test@trackalack.com'
    fill_in 'user_password', :with => 'test'
  end
end
