class Comment < ApplicationRecord
  USER_BATCH_SIZE = 5

  belongs_to :user
  belongs_to :project

  attr_accessor :signed_in_user

  validates :content, presence: true

  after_create :send_email_notifications
  
  def send_email_notifications
    @users = self.project.assigned_users
    @users.find_each(batch_size: Comment::USER_BATCH_SIZE) do |user|
      NotificationMailer.delay.send_notification(user, self.project, self.signed_in_user, self) unless user == self.signed_in_user
    end
  end

  def valid_user?(user)
    self.user == user
  end
end
