module ProjectsHelper
  def secure_edit(time_entry)
    return "" unless current_user_owns?(time_entry)
    link_to 'Edit', edit_project_time_entry_path(time_entry.project, time_entry), :class => 'edit-time-link'
  end

  def secure_destroy(time_entry)
    return "" unless current_user_owns?(time_entry)
    link_to 'Destroy', project_time_entry_path(time_entry.project, time_entry), :confirm => 'Are you sure?', :method => :delete
  end

  def current_user_owns?(time_entry)
    current_user == time_entry.user
  end
end
