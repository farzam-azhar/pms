module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-danger"
      when :notice
        "alert-success"
      when :warning
        "alert-warning"
      else
        flash_type.to_s
    end
  end

  def render_session_link
    if user_signed_in?
      render 'shared/logged_in_user.html.erb'
    else
      render 'shared/logged_out_user.html.erb'
    end
  end
  
  def render_admin_links
    if user_signed_in? && current_user.admin?
      content_tag :li do
        link_to 'Manage Users', admin_users_path
      end
    end
  end
end
