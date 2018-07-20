module Admin::UsersHelper
  def get_gender(gender)
    gender == 'M' ? 'Male' : 'Female'
  end
  
  def get_enable_or_disable_link(user)
    if user.enabled?
      link_to 'Disable', enable_or_disable_user_admin_user_path(user), data: { toggle: "tooltip" }, title: 'Disable User', remote: true
    else
      link_to 'Enable', enable_or_disable_user_admin_user_path(user), data: { toggle: "tooltip" }, title: 'Enable User', remote: true
    end
  end
  
  def promote_to_manager_or_demote_to_user_link(user)
    if user.manager?
      link_to 'Demote to User', promote_to_manager_or_demote_to_user_admin_user_path(user), data: { toggle: "tooltip" }, title: 'Demote to User', remote: true
    else
      link_to 'Promote to Manager', promote_to_manager_or_demote_to_user_admin_user_path(user), data: { toggle: "tooltip" }, title: 'Promote to Manager', remote: true
    end
  end
end
