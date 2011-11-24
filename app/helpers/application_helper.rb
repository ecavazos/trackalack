module ApplicationHelper
  def rails_msg(key)
    key = key.to_sym
    unless [:alert, :notice, :error].include?(key)
      raise ArgumentError, 'Can only handle alert, notice and error messages.'
    end

    return '' if flash[key].blank?

    capture_haml do
      haml_tag("##{key}") do
        haml_concat flash[key]
      end
    end
  end

  def format_date(date)
    (date.nil?)? '' : date.strftime('%m/%d/%Y')
  end

  def add_link_data(time)
    project = time.is_a?(TimeEntry) ? time.project : time
    {
      :name  => 'Add Time to Project',
      :path  => new_project_time_entry_path(project),
      :class => 'add-time-link'
    }
  end

  def edit_link_data(time)
    {
      :name  => 'Edit Time',
      :path  => edit_project_time_entry_path( time.project, time ),
      :class => 'edit-time-link'
    }
  end

  def destroy_link_data(time)
    {
      :name => 'Destroy',
      :path => project_time_entry_path( time.project, time )
    }
  end

end
