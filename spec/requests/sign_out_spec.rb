require 'spec_helper'

describe 'Sign out' do

  it 'should sign user out' do
    sign_in

    page.should_not have_content 'Sign in'

    click_link 'Sign Out'

    page.should have_content 'Sign in'
  end
end
