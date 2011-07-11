require 'spec_helper'

describe 'Home Page', :js => true do

  before do
    @user = sign_in
  end

  context 'within recent time entries section' do

    it 'has title' do
      visit root_path
      page.should have_content 'Recent Time Entries'
    end

    it 'displays time entries by created at date descending' do

      with_timestamping_disabled TimeEntry do
        Factory.create :time_entry, :description => 'foo3', :user => @user, :created_at => Time.now.ago(2.day)
        Factory.create :time_entry, :description => 'foo2', :user => @user, :created_at => Time.now.ago(1.day)
        Factory.create :time_entry, :description => 'foo1', :user => @user, :created_at => Time.now
      end

      visit root_path

      entries = all('#stream .activity')

      entries[0].should have_content 'foo1'
      entries[1].should have_content 'foo2'
      entries[2].should have_content 'foo3'
    end

    context 'a single time entry' do

      before do
        @client     = Factory.create :client, :name => 'Seven Eleven'
        @project    = Factory.create :project, :name => 'Make Awesome!', :client => @client
        @time_entry = Factory.create :time_entry, :description => 'Delivered awesomeness!', :user => @user, :project => @project
      end

      it 'links to the associated client' do

        visit root_path

        within '#stream .activity' do
          click_link 'Seven Eleven'
        end

        current_path.should == client_path(@client)
      end

      it 'links to the associated project' do

        visit root_path

        within '#stream .activity' do
          click_link 'Make Awesome!'
        end

        current_path.should == project_path(@project)
      end

      it 'links to the associated user' do

        visit root_path

        within '#stream .activity' do
          click_link 'Luke Skywalker'
        end

        current_path.should == user_path(@user)
      end

      it 'shows description' do

        visit root_path

        within '#stream .activity' do
          page.should have_content 'Delivered awesomeness!'
        end
      end

      it 'allows user to add time entries to associated project' do
        visit root_path

        page.should have_no_content 'Time Entry'

        within '#stream .activity' do
          click_link 'Add time'
        end

        within '.ui-dialog' do
          page.should have_content 'Time Entry'

          page.execute_script("$('#time_entry_work_type option:eq(1)').attr('selected', 'selected');")
          page.execute_script("$('#time_entry_billing_type option:eq(2)').attr('selected', 'selected');")

          find('label', :text => 'Date').click
          fill_in 'Date', :with => Date.today.strftime('%m/%d/%Y')
        end

        find('#ui-datepicker-div .ui-state-highlight').click

        within '.ui-dialog' do
          fill_in 'Duration',    :with => '2.5'
          fill_in 'Description', :with => 'I had a nice time with your mom.'
          click_button 'Save'
        end

        time_entry = TimeEntry.first
        time_entry.project.should      == @project
        time_entry.work_type.should    == :task
        time_entry.billing_type.should == :no_charge
        time_entry.date.should         == Date.today
        time_entry.duration.should     == 2.5
        time_entry.description.should  == 'I had a nice time with your mom.'

        within '#stream .activity' do
          page.should have_content 'I had a nice time with your mom.'
        end
      end

      it 'allows owner to edit' do

        visit root_path

        page.should have_no_content 'Time Entry'

        within '#stream .activity' do
          click_link 'Edit'
        end

        within '.ui-dialog' do
          page.should have_content 'Time Entry'
          fill_in 'Description', :with => 'Make that super-awesomeness!'
          click_button 'Save'
        end

        @time_entry.reload
        @time_entry.description.should == 'Make that super-awesomeness!'

        # TODO: page should refresh the updated time entry *ONLY*
      end

      it "hides edit for other user's time entries" do
        other_user = Factory.create :user, :email => 'foo@bar.com'
        Factory.create :time_entry, :description => 'not my time entry.', :user => other_user, :project => @project

        visit root_path

        within '#stream .activity' do
          page.should have_no_content 'Edit'
        end
      end
    end
  end

end
