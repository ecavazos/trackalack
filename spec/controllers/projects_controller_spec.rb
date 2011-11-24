require 'spec_helper'

describe ProjectsController do
  login_user

  def mock_project(stubs={})
    (@mock_project ||= mock_model(Project).as_null_object).tap do |project|
      project.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      includes = mock(Object)
      includes.stub(:all) { [mock_project] }
      Project.stub(:includes) { includes }
      get :index
      assigns(:projects).should eq([mock_project])
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      includes = mock(Object)
      includes.stub(:find).with("37") { mock_project }
      Project.stub(:includes) { includes }
      get :show, :id => "37"
      assigns(:project).should be(mock_project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      Client.stub(:find).with("37") { Client.new }
      Project.stub(:new) { mock_project }
      get :new, :client_id => "37"
      assigns(:project).should be(mock_project)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      before do
        client = mock_model(Client).as_null_object
        client.stub(:build).with({'these' => 'params'}) { mock_project(:save => true) }
        Client.stub(:find).with("37") { client }
        post :create, :client_id => "37", :project => {'these' => 'params'}
      end

      it "assigns a newly created project as @project" do
        assigns(:project).should be(mock_project)
      end

      it "redirects to the created project" do
        response.should redirect_to(projects_url)
      end
    end

    describe "with invalid params" do
      before do
        client = mock_model(Client).as_null_object
        client.stub(:build).with({'these' => 'params'}) { mock_project(:save => false) }
        Client.stub(:find).with("37") { client }
        post :create, :client_id => "37", :project => {'these' => 'params'}
      end

      it "assigns a newly created but unsaved project as @project" do
        assigns(:project).should be(mock_project)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      Project.should_receive(:find).with("37") { mock_project }
      mock_project.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the projects list" do
      Project.stub(:find) { mock_project }
      delete :destroy, :id => "1"
      response.should redirect_to(projects_url)
    end
  end

end
