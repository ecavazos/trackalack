module ProjectsHelper
  def secure_edit(time_entry)
    return "" if not_owned_by_user?(time_entry)
    return link_to 'Edit', edit_project_time_entry_path(time_entry.project, time_entry), :class => 'edit-time-link'
  end

  def secure_destroy(time_entry)
    return "" if not_owned_by_user?(time_entry)
    return link_to 'Destroy', project_time_entry_path(time_entry.project, time_entry), :confirm => 'Are you sure?', :method => :delete
  end

  def not_owned_by_user?(time_entry)
    return current_user.id != time_entry.user.id
  end
end
