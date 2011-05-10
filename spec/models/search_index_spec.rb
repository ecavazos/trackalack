require 'spec_helper'

describe SearchIndex do
  
  describe "#to_path_method" do
    it "should append '_path' to the resource type" do
      si = SearchIndex.new :resource_type => 'Client'
      si.to_path_method.should eq('client_path')
    end
  end
end
