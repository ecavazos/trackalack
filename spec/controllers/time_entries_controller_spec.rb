require 'spec_helper'

describe TimeEntriesController do
  login_user

  def mock_time_entry(stubs={})
    (@mock_time_entry ||= mock_model(TimeEntry).as_null_object).tap do |time_entry|
      time_entry.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET new" do
    before do
      @project = Project.new
      Project.stub(:find).with("37") { @project }
      TimeEntry.stub(:new) { mock_time_entry }
      get :new, :project_id => "37"
    end

    it "assigns the requested project as @project" do
      assigns(:project).should be(@project)
    end

    it "assigns a new time_entry as @time_entry" do
      assigns(:time_entry).should be(mock_time_entry)
    end
  end

  describe "GET edit" do
    it "assigns the requested time_entry as @time_entry" do
      mock_user = mock_model(User).as_null_object
      @controller.stub(:current_user) { mock_user }
      mock_user.stub(:find).with("37") { mock_time_entry }
      get :edit, :id => "37", :project_id => "37"
      assigns(:time_entry).should be(mock_time_entry)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      before do
        @project = mock_model(Project)
        Project.stub(:find).with("37") { @project }
        mock_user = mock_model(User).as_null_object
        @controller.stub(:current_user) { mock_user }
        mock_user.stub(:build).with({'these' => 'params', "date" => nil }) { mock_time_entry(:save => true) }
        mock_time_entry.should_receive(:project=).with(@project)
        post :create, :project_id => "37", :time_entry => {'these' => 'params'}
      end

      it "assigns a newly created time_entry as @time_entry" do
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "assigns the found project to @project" do
        assigns(:project).should be(@project)
      end

      it "redirects to the created time_entry" do
        response.should be_success
      end

      it "should return json"
    end

    describe "with invalid params" do
      before do
        mock_user = mock_model(User).as_null_object
        @controller.stub(:current_user) { mock_user }
        mock_user.stub(:build).with({'these' => 'params', 'date' => nil }) { mock_time_entry(:save => false ) }
        Project.stub(:find).with("37")
        post :create, :project_id => "37", :time_entry => {'these' => 'params'}
      end

      it "assigns a newly created but unsaved time_entry as @time_entry" do
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "returns a status of 400" do
        response.status.should eq(400)
      end

      it "should return json error messages"
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      before do
          mock_user = mock_model(User).as_null_object
          @mock_project = mock_model(Project).as_null_object
          @controller.stub(:current_user) { mock_user }
          mock_user.stub(:find).with("37") { mock_time_entry }
          mock_time_entry.should_receive(:update_attributes).with({'these' => 'params', 'date' => nil}).and_return(true)
          mock_time_entry.stub(:project) { @mock_project }
          # @controller.stub(:render).with(:json => mock_time_entry)

          put :update, {
            :project_id => "27",
            :id => "37",
            :time_entry => {'these' => 'params'}
          }
      end

      it "assigns the requested time_entry as @time_entry" do
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "assigns the time_entry's project as @project" do
        assigns(:project).should be(@mock_project)
      end

      it "should be success" do
        response.should be_success
      end
    end

    describe "with invalid params" do
      before do
          mock_user = mock_model(User).as_null_object
          @mock_project = mock_model(Project).as_null_object
          @controller.stub(:current_user) { mock_user }
          mock_user.stub(:find).with("37") { mock_time_entry(:update_attribues => false) }
          mock_time_entry.should_receive(:update_attributes)
          mock_time_entry.stub(:project) { @mock_project }

          put :update, {
            :project_id => "27",
            :id => "37",
            :time_entry => {}
          }
      end

      it "assigns the time_entry as @time_entry" do
        assigns(:time_entry).should be(mock_time_entry)
      end

      it "assigns the time_entry's project as @project" do
        assigns(:project).should be(@mock_project)
      end

      it "returns status of 400" do
        response.status.should eq(400)
      end
    end

  end

  describe "DELETE destroy" do
    before do
      mock_user = mock_model(User).as_null_object
      @controller.stub(:current_user) { mock_user }
      mock_user.stub(:find).with("37") { mock_time_entry(:update_attribues => false) }
    end

    it "destroys the requested time_entry" do
      mock_time_entry.should_receive(:destroy)
      delete :destroy, :project_id => "27", :id => "37"
    end

    it "redirects to the time_entries list" do
      mock_project = mock_model(Project).as_null_object
      mock_time_entry.stub(:project) { mock_project }
      delete :destroy, :project_id => "27", :id => "37"
      response.should redirect_to(project_url(mock_project))
    end
  end

end
