class HomeController < ApplicationController
  def index
    @time_entries = TimeEntry.
                      includes(:user, :project => :client).
                      order('created_at desc')
  end

end
