module ClientsHelper
  def valid_role?
    user_signed_in? && ( current_user.admin? or current_user.manager? )
  end
  
  def add_client(url)
    link_to url, { remote: true, data: { toggle: 'model', target: '#myModel' }, class: 'btn btn-primary mt-8' } do
      "<span class='glyphicon glyphicon-plus'></span> Create New Client".html_safe
    end
  end
end
