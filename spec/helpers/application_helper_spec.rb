require 'spec_helper'

describe ApplicationHelper do
  describe "#rails_msg(key)" do
    before do
      helper.extend Haml::Helpers
      helper.init_haml_helpers
    end

    describe "when called with a valid key" do
      it "should output alert message" do
        helper.stub(:flash).and_return({:alert => "foo!"})
        helper.rails_msg(:alert).should eq("<div id='alert'>\n  foo!\n</div>\n")
      end

      it "should output notice message" do
        helper.stub(:flash).and_return({:notice => "foo!"})
        helper.rails_msg('notice').should eq("<div id='notice'>\n  foo!\n</div>\n")
      end

      it "should output error message" do
        helper.stub(:flash).and_return({:error => "foo!"})
        helper.rails_msg(:error).should eq("<div id='error'>\n  foo!\n</div>\n")
      end
    end

    it "should be blank when the flash for the given key is blank" do
      helper.rails_msg(:alert).should eq("")
    end

    it "should raise ArgumentError when invalid key is used" do
      proc { 
        helper.rails_msg(:poop)
      }.should raise_error(ArgumentError)
    end
  end
end
