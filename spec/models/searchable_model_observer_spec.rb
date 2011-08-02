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
end
