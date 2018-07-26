module TimeLogsHelper
  def add_time_log(url)
    link_to url, { remote: true, data: { toggle: 'modal', target: '#time_log-modal' }, class: 'btn btn-primary mt-8' } do
      "<span class='glyphicon glyphicon-plus'></span> Create New Time Log".html_safe
    end
  end
end
