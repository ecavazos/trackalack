require 'spec_helper'

describe SearchIndex do

  describe SearchIndex, '#to_path_method' do

    it 'should append "_path" to the resource type' do
      SearchIndex.new(
        :resource_type => 'Client'
      ).to_path_method.should == 'client_path'
    end
  end
end
