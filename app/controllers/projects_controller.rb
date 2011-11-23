class ProjectsController < ApplicationController
  before_filter :find_client_and_project, :only => [:edit, :update]

  def index
    @projects = Project.includes(:client).all
  end

  def show
    @project = Project.includes(:client, :time_entries => [:user, :project]).find params[:id]
  end

  def new
    @client = Client.find params[:client_id]
    @project = Project.new
  end

  def create
    @client = Client.find params[:client_id]
    @project = @client.projects.build params[:project]

    if @project.save
      redirect_to projects_path, :notice => 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes params[:project]
      redirect_to client_project_path(@client, @project), :notice => 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

  private

  def find_client_and_project
    @client  = Client.find params[:client_id]
    @project = @client.projects.find params[:id]
  end
end
