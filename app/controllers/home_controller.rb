class HomeController < ApplicationController
  def index
    @time_entries = current_user.time_entries.
                      includes(:user, :project => :client).
                      order('created_at desc').limit(25)

    @recently_updated_projects = Project.recently_updated(10)
    @clients = Client.recently_created(10)
    @projects = Project.recently_created(10)
  end

end
