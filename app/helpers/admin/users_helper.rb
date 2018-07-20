module Admin::UsersHelper
  def update_status_link(user)
    status = user.enabled?  ? 'Disable' : 'Enable'
    
    link_to status, update_status_admin_user_path(user), data: { toggle: "tooltip" }, title: "#{status} User", remote: true
  end
  
  def update_role_link(user)
    role = user.manager?  ? 'Demote to' : 'Promote to'
    resource = user.manager?  ? ' User' : ' Manager'
    
    link_to role + resource, update_role_admin_user_path(user), data: { toggle: "tooltip" }, title: role + resource, remote: true
  end
end
