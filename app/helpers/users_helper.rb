module UsersHelper
  def day_opts
    { '5 days' => 5, '10 days' => 10, '30 days' => 30, '50 days' => 50 }
  end

  def user_show_time_title
    base = 'Time entries'

    if params[:days]
      return "#{base} for last #{params[:days]} days"
    elsif flash[:error] || params[:start_date].nil?
      return base
    elsif !params[:start_date].empty? && !params[:end_date].empty?
      return "#{base} between #{params[:start_date]} and #{params[:end_date]}"
    elsif !params[:start_date].empty? && params[:end_date].empty?
      return "#{base} for #{params[:start_date]}"
    end
  end
end
