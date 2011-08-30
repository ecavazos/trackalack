class HomeController < ApplicationController
  def index
    # @time_entries = current_user.time_entries.all_assoc_limited(50)
    @time_entries              = TimeEntry.all_assoc_limited(50)
    @recently_updated_projects = Project.recently_updated(10)
    @clients                   = Client.recently_created(10)
    @projects                  = Project.recently_created(10)
  end

  def stream
    @time_entries = current_user.time_entries.all_assoc_limited(50)
    render '_stream', :layout => false
  end
end
