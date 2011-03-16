module ProjectsHelper
  def secure_edit(time_entry)
    return "" if current_user.id != time_entry.user.id
    return link_to 'Edit', edit_project_time_entry_path(time_entry.project, time_entry)
  end

  def secure_destroy(time_entry)
    return "" if current_user.id != time_entry.user.id
    return link_to 'Destroy', project_time_entry_path(time_entry.project, time_entry), :confirm => 'Are you sure?', :method => :delete
  end
end
