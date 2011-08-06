require 'spec_helper'

describe WorkTypes do

  describe WorkTypes, '.all' do

    it 'should contain all work types' do
      WorkTypes.all.should == {
        :feature  => 'Feature',
        :task     => 'Task',
        :incident => 'Incident'
      }
    end
  end

  describe WorkTypes, '.for_select' do

    it 'should return an array for use in select helper' do
      WorkTypes.for_select.should == [
        ['Feature', :feature],
        ['Task', :task],
        ['Incident', :incident]
      ]
    end
  end
end
