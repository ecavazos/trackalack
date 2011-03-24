class TimeEntriesController < ApplicationController
  before_filter :parse_date, :only => [:create, :update]

  # GET /time_entries
  # GET /time_entries.xml
  def index
    @time_entries = Project.
                      includes(:client, :time_entries => :user).
                      find(params[:project_id]).time_entries

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @time_entries }
    end
  end

  # GET /time_entries/1
  # GET /time_entries/1.xml
  def show
    @time_entry = TimeEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @time_entry }
    end
  end

  # GET /time_entries/new
  # GET /time_entries/new.xml
  def new
    @project = Project.find(params[:project_id])
    @time_entry = TimeEntry.new
    render :new, :layout => false
  end

  def edit
    @time_entry = current_user.time_entries.find(params[:id])
    @project = @time_entry.project
  end

  def create
    @time_entry = current_user.time_entries.build(params[:time_entry])
    @project = Project.find(params[:project_id])
    @time_entry.project = @project

    if @time_entry.save
      render :json => @time_entry
    else
      render :json => @time_entry.errors.map{|k,v| "#{k} #{v}"}, :status => :bad_request
    end
  end

  # PUT /time_entries/1
  # PUT /time_entries/1.xml
  def update
    @time_entry = current_user.time_entries.find(params[:id])
    @project = @time_entry.project

    if @time_entry.update_attributes(params[:time_entry])
      redirect_to project_url(@time_entry.project), :notice => 'Time entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @time_entry = current_user.time_entries.find(params[:id])
    @project = @time_entry.project
    @time_entry.destroy
    redirect_to project_url(@project), :notice => 'Time entry was successfully deleted.'
  end

  private

  def parse_date
    params[:time_entry][:date] = parse_us_date(params[:time_entry][:date])
  end

  def parse_us_date(string)
    return nil if string.blank?
    Date.strptime(string, '%m/%d/%Y')
  end
end
