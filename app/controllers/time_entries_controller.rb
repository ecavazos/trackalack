class TimeEntriesController < ApplicationController
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @time_entry }
    end
  end

  def edit
    @time_entry = TimeEntry.find(params[:id])
  end

  def create
    @time_entry = TimeEntry.new(params[:time_entry])

    # TODO: get current user and assign it as creator of this entry

    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to(@time_entry, :notice => 'Time entry was successfully created.') }
        format.xml  { render :xml => @time_entry, :status => :created, :location => @time_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_entries/1
  # PUT /time_entries/1.xml
  def update
    @time_entry = TimeEntry.find(params[:id])

    respond_to do |format|
      if @time_entry.update_attributes(params[:time_entry])
        format.html { redirect_to(@time_entry, :notice => 'Time entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_entries/1
  # DELETE /time_entries/1.xml
  def destroy
    @time_entry = TimeEntry.find(params[:id])
    @time_entry.destroy

    respond_to do |format|
      format.html { redirect_to(time_entries_url) }
      format.xml  { head :ok }
    end
  end
end
