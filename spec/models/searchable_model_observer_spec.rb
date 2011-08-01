require 'spec_helper'

describe SearchableModelObserver do

  describe SearchableModelObserver, '#after_create :user' do

    it 'creates a record for new user' do
      Factory.create(:client, :id => 37, :name => 'Money Bagz')
      si = SearchIndex.last
      si.resource_id.should   == 37
      si.resource_type.should == 'Client'
      si.name.should          == 'Money Bagz'
    end
  end

  describe SearchableModelObserver, '#after_update :user' do

    it 'updates the record when user is updated' do
      client = Factory.create(:client, :id => 37, :name => 'Money Bagz')
      si = SearchIndex.last

      si.name.should == 'Money Bagz'

      client.update_attributes(:name => 'Daddy Fat Stacks!')

      si.reload

      si.name.should == 'Daddy Fat Stacks!'
    end
  end
end
