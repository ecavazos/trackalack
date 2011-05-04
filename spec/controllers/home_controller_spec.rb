require 'spec_helper'

describe HomeController do
  describe "when signed in" do
    login_user

    describe "GET 'index'" do
      it "assigns @time_entries" do
        time = mock_model(TimeEntry).as_null_object
        TimeEntry.stub(:all_assoc_limited).with(50) { [time] }
        get 'index'
        assigns(:time_entries).should eq([time])
      end

      it "assigns @recently_updated_projects" do
        proj = mock_model(Project)
        Project.stub(:recently_updated).with(10) { [proj] }
        get 'index'
        assigns(:recently_updated_projects).should eq([proj])
      end

      it "assigns @clients" do
        client = mock_model(Client)
        Client.stub(:recently_created).with(10) { [client] }
        get 'index'
        assigns(:clients).should eq([client])
      end

      it "assigns @projects" do
        project = mock_model(Project)
        Project.stub(:recently_created).with(10) { [project] }
        get 'index'
        assigns(:projects).should eq([project])
      end

      it "should be successful" do
        get 'index'
        response.should be_success
      end
    end
  end

  describe "when signed out" do
    describe "GET 'index'" do
      it "should redirect to sign in page" do
        get 'index'
        response.should redirect_to(new_user_session_url)
      end
    end

    describe "GET 'stream'" do
      it "should redirect to sign in page" do
        get :stream
        response.should redirect_to(new_user_session_url)
      end
    end
  end

end
