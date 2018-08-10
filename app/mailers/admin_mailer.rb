class AdminMailer < ApplicationMailer
  def user_created_notification(user)
    @greeting = "Hi, New User named #{user.username} just signed up."
    mail to: "admin@example.com", from: 'kodiak@notifications.com', subject: 'New User Signed Up!'
  end
end
