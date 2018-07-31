module ProjectsHelper
  def add_project(url)
    link_to url, { remote: true, data: { toggle: 'modal', target: '#project-modal' }, class: 'btn btn-primary mt-8' } do
      "<span class='glyphicon glyphicon-plus'></span> Create New Project".html_safe
    end
  end

  def project_attachments(project)
    if project.attachments.present?
      render project.attachments
    else
      'No Attachments Yet.'
    end
  end
end
