class HomeController < ApplicationController
  def index
    @time_entries = TimeEntry.order('created_at desc')
  end

end
