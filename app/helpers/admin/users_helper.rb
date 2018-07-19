module Admin::UsersHelper
  def get_gender(gender)
    gender == 'M' ? 'Male' : 'Female'
  end
  
  def get_enable_or_disable_link(user)
    if user.enabled?
      link_to 'Disable', enable_or_disable_user_admin_user_path(user), data: {toggle: "tooltip"}, title: 'Disable User', remote: true
    else
      link_to 'Enable', enable_or_disable_user_admin_user_path(user), data: {toggle: "tooltip"}, title: 'Enable User', remote: true
    end
  end
end
