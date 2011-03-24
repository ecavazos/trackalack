module HomeHelper
  def format_date(date)
    return '' if date.nil?
    date.strftime('%m/%d/%Y')
  end

  def user_edit_time_link(time_entry)
    return unless time_entry.user == current_user
    haml_tag('.activity-meta-item') do
      haml_concat link_to 'Edit', edit_project_time_entry_path(time_entry.project, time_entry),
        :class => 'edit-time-link'
    end
  end
end
