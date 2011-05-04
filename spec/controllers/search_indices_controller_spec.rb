require 'spec_helper'

describe SearchIndicesController do

  describe "GET 'index'" do
    login_user

    before do
      @idx = new_search_index
      SearchIndex.stub(:where).with('name LIKE ?', "%foo%") {[@idx]}
    end

    it "should be successful" do
      get :index, :term => 'foo'
      response.should be_success
    end

#    it "blah" do
#      @controller.stub(:send).with('client_path', '37')
#      get :index, :term => 'foo'
#      response.body.should eq('poops')
#    end
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
