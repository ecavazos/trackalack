module UsersHelper
  def day_opts
    {
      '5 days'  => 5,
      '10 days' => 10,
      '30 days' => 30,
      '50 days' => 50
    }
  end

  def user_show_time_title
    base = 'Time entries'

    if no_filter_params?
      return "#{base} for last 5 days"
    elsif params[:start_date] && !params[:start_date].empty? && !params[:end_date].empty?
      return "#{base} between #{params[:start_date]} and #{params[:end_date]}"
    elsif params[:start_date] && !params[:start_date].empty?
      return "#{base} for #{params[:start_date]}"
    elsif params[:days]
      return "#{base} for last #{params[:days]} days"
    elsif flash[:error] || params[:start_date].nil?
      return base
    end
  end

  private

  def no_filter_params?
    !(params[:days] || params[:start_date] || params[:end_date])
  end

end
