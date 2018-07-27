module CommentsHelper
  def render_action(comment, project)
    comment.persisted? ? comment : [project, comment]
  end

  def comment_form(project)
    if user_signed_in?
      render 'comments/form', project: project, comment: Comment.new
    else
      'You need to Sign in to Comment.'
    end
  end
end
