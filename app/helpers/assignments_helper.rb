module AssignmentsHelper
  def add_assignment(project)
    content_tag :div, class: 'pull-right mt-4' do
      link_to new_project_assignment_path(project), remote: true, data: { toggle: "tooltip" }, title: 'Assign Another User', class: 'btn btn-success' do
        "<span class='glyphicon glyphicon-plus'></span>".html_safe
      end
    end
  end

  def render_users(assignment, project)
    assignment.persisted? ? User.except_admin : User.except_admin.not_assigned_users(project)
  end
end
