class NotificationMailer < ApplicationMailer
  def send_notification(user, project, current_user, comment)
    @greeting = "Hi, The comment has just been made by #{current_user.username} on a Project that you are working on, Have a look."
    @user = user
    @project = project
    @comment = comment

    mail to: user.email, from: 'notifications@kodiak.com',
    subject: "Project - #{project.title} has just been commented"
  end
end
