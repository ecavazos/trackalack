require 'spec_helper'

describe 'Home Page', :js => true do

  before do
    @user = sign_in
  end

  context 'navigation' do

    it 'links to clients page' do
      visit root_path
      click_link 'Clients'
      current_path.should == clients_path
    end

    it 'links to projects page' do
      visit root_path
      click_link 'Projects'
      current_path.should == projects_path
    end

    it 'links to users page' do
      visit root_path
      click_link 'Users'
      current_path.should == users_path
    end
  end

  context 'recent time entries section' do

    it 'has title' do
      visit root_path
      page.should have_content 'Recent Time Entries'
    end

    it 'displays time entries by created at date descending' do

      with_timestamping_disabled TimeEntry do
        TimeEntry.gen(:description => 'foo3',
                      :user        => @user,
                      :created_at  => Time.now.ago(2.day))

        TimeEntry.gen(:description => 'foo2',
                      :user        => @user,
                      :created_at  => Time.now.ago(1.day))

        TimeEntry.gen(:description => 'foo1',
                      :user        => @user,
                      :created_at  => Time.now)
      end

      visit root_path

      entries = all('#stream .activity')

      entries[0].should have_content 'foo1'
      entries[1].should have_content 'foo2'
      entries[2].should have_content 'foo3'
    end

    context 'a single time entry' do

      before do
        @client     = Client.gen  :name => 'Seven Eleven'
        @project    = Project.gen :name => 'Make Awesome!', :client => @client
        @time_entry = TimeEntry.gen(:description => 'Delivered awesomeness!',
                                    :user        => @user,
                                    :project     => @project)
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
        other_user = User.gen :email => 'foo@bar.com'

        TimeEntry.gen(:description => 'not my time entry.',
                      :user        => other_user,
                      :project     => @project)

        visit root_path

        within '#stream .activity' do
          page.should have_no_content 'Edit'
        end
      end
    end
  end

  context 'recent projects section' do

    it 'has title' do
      visit root_path
      find('#recent_projects h3').should have_content 'Recent Projects'
    end

    it 'displays projects ordered by (updated at) desc and limited to 10' do
      13.times do |i|
        client = Client.gen :name => "Client #{i}"
        Project.gen :name => "Project #{i}", :client => client
      end

      Project.first.update_attribute 'name', 'Was Project 0'

      visit root_path

      within '#recent_projects' do
        entries = all('li')

        entries.length.should == 10

        entries[0].should have_content 'Was Project 0'
        entries[1].should have_content 'Project 12'
        entries[2].should have_content 'Project 11'
        entries[3].should have_content 'Project 10'
        entries[4].should have_content 'Project 9'
        entries[5].should have_content 'Project 8'
        entries[6].should have_content 'Project 7'
        entries[7].should have_content 'Project 6'
        entries[8].should have_content 'Project 5'
        entries[9].should have_content 'Project 4'
      end
    end

    it 'links to project' do
      project = Project.gen :name => 'Operation Flying Turtle'
      visit root_path

      within '#recent_projects' do
        click_link 'Operation Flying Turtle'
      end

      current_path.should == project_path(project)
    end

    it 'links to client' do
      client = Client.gen :name => 'The Cookie Makers'
      Project.gen :client => client

      visit root_path

      within '#recent_projects' do
        click_link 'The CM.'
      end

      current_path.should == client_path(client)
    end
  end
end
