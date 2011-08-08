require 'spec_helper'

describe SearchableModelObserver do

  describe SearchableModelObserver, '#after_create :client' do

    it 'creates an index record for new client' do
      Factory.create(:client, :id => 37, :name => 'Money Bagz')

      search_index = SearchIndex.last

      search_index.resource_id.should   == 37
      search_index.resource_type.should == 'Client'
      search_index.name.should          == 'Money Bagz'
    end
  end

  describe SearchableModelObserver, '#after_update :client' do

    it 'updates the search index when client is updated' do
      client = Factory.create(:client, :id => 37, :name => 'Money Bagz')
      search_index = SearchIndex.last

      search_index.name.should == 'Money Bagz'

      client.update_attributes(:name => 'Daddy Fat Stacks!')

      search_index.reload

      search_index.name.should == 'Daddy Fat Stacks!'
    end
  end

  describe SearchableModelObserver, '#after_create :project' do

    it 'creates an index record for new project' do
      Factory.create(:project, :id => 37, :name => 'Make Look Nice')

      search_index = SearchIndex.last

      search_index.resource_id.should   == 37
      search_index.resource_type.should == 'Project'
      search_index.name.should          == 'Make Look Nice'
    end
  end

  describe SearchableModelObserver, '#after_update :project' do

    it 'updates the search index when project is updated' do
      project = Factory.create(:project, :id => 37, :name => 'Make Look Nice')
      search_index = SearchIndex.last

      search_index.name.should == 'Make Look Nice'

      project.update_attributes(:name => 'Make Pretty')

      search_index.reload

      search_index.name.should == 'Make Pretty'
    end
  end

  describe SearchableModelObserver, '#after_create :user' do

    it 'creates an index record for new user' do
      Factory.create(:user, :id => 37, :first_name => 'Sam', :last_name => 'Sneed')

      search_index = SearchIndex.last

      search_index.resource_id.should   == 37
      search_index.resource_type.should == 'User'
      search_index.name.should          == 'Sam Sneed'
    end
  end

  describe SearchableModelObserver, '#after_update :project' do

    it 'updates the search index when user is updated' do
      user = Factory.create(:user,
                            :id         => 37,
                            :first_name => 'Sam',
                            :last_name  => 'Sneed')

      search_index = SearchIndex.last

      search_index.name.should == 'Sam Sneed'

      user.update_attributes(:first_name => 'John', :last_name => 'Cage')

      search_index.reload

      search_index.name.should == 'John Cage'
    end
  end
end
