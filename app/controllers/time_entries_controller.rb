class TimeEntriesController < ApplicationController
  before_filter :parse_date, :only => [:create, :update]

  def new
    @project = Project.find(params[:project_id])
    @time_entry = TimeEntry.new
    render :new, :layout => false
  end

  def edit
    @time_entry = current_user.time_entries.find(params[:id])
    @project = @time_entry.project
    render :new, :layout => false
  end

  def create
    @time_entry = current_user.time_entries.build(params[:time_entry])
    @project = Project.find(params[:project_id])
    @time_entry.project = @project

    if @time_entry.save
      render :json => @time_entry
    else
      bad_save_or_update_response
    end
  end

  def update
    @time_entry = current_user.time_entries.find(params[:id])
    @project = @time_entry.project

    if @time_entry.update_attributes(params[:time_entry])
      render :json => @time_entry
    else
      bad_save_or_update_response
    end
  end

  def destroy
    @time_entry = current_user.time_entries.find(params[:id])
    @time_entry.destroy
    redirect_to project_url(@time_entry.project), :notice => 'Time entry was successfully deleted.'
  end

  private

  def bad_save_or_update_response
    render :json => @time_entry.errors.map{|k,v| "#{k} #{v}"}, :status => :bad_request
  end

  def parse_date
    params[:time_entry][:date] = parse_us_date(params[:time_entry][:date])
  end

  def parse_us_date(string)
    return nil if string.blank?
    Date.strptime(string, '%m/%d/%Y')
  end
end
