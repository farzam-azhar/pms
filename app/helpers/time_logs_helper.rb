module TimeLogsHelper
  def add_time_log(url)
    link_to url, { remote: true, data: { toggle: 'modal', target: '#time_log-modal' }, class: 'btn btn-primary mt-8' } do
      "<span class='glyphicon glyphicon-plus'></span> Create New Time Log".html_safe
    end
  end

  def render_options(time_log)
    if time_log.valid_user?(current_user)
      render 'time_logs/links', time_log: time_log
    else
      'No Options'
    end
  end

  def is_admin?(user)
    user.admin?
  end

  def is_not_admin?(user)
    user_signed_in? ? !is_admin?(user) : false
  end
end
