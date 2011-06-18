require 'spec_helper'

describe SearchIndicesController do

  describe "GET 'index'" do
    login_user

    before do
      @idx = Factory.build(:search_index)
      SearchIndex.stub(:where).with('name LIKE ?', "%foo%") {[@idx]}
    end

    it "should be successful" do
      get :index, :term => 'foo'
      response.should be_success
    end

    it "should return json search results" do
      expected = [{
        :id => 37,
        :name => 'foo',
        :type => 'client',
        :path => '/foo/path/'
      }]

      @controller.should_receive(:client_path).with(37) {'/foo/path/'}
      get :index, :term => 'foo'
      response.body.should eq(expected.to_json)
    end
  end

  describe "when signed out" do
    describe "GET 'index'" do
      it "should redirect to sign in page" do
        get 'index'
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
