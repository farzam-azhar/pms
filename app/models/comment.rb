class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :content, presence: true

  def valid_user?(user)
    self.user == user
  end
end
