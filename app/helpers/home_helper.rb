module HomeHelper
  def user_edit_time_link(time_entry)
    return unless time_entry.user == current_user
    haml_concat('&middot;'.html_safe)
    haml_tag('.activity-meta-item') do
      haml_concat link_to 'Edit', edit_project_time_entry_path(time_entry.project, time_entry),
        :class => 'edit-time-link'
    end
  end
end
