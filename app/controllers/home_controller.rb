class HomeController < ApplicationController
  def index
    @time_entries = TimeEntry.
                      includes(:user, :project => :client).
                      order('created_at desc')

    @recent_projects = Project.joins(:time_entries).
                        select('distinct(projects.name)').
                        order('time_entries.updated_at').
                        limit(10)

    @clients = Client.order('created_at desc').limit(10)
    @projects = Project.order('created_at desc').limit(10)
  end

end
