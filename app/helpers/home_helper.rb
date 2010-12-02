module HomeHelper
  def date_format(date)
    date.strftime('%m/%d/%Y')
  end

  def user_edit_time_link(time_entry)
    return unless time_entry.user == current_user
    haml_tag('.activity-meta-item') do
      haml_concat link_to 'Edit', new_project_time_entry_path(time_entry)
    end
  end
end
