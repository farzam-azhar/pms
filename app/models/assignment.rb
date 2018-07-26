class Assignment < ApplicationRecord
  enum roles: [:software_engineer, :frontend_developer, :QA_engineer]

  belongs_to :user
  belongs_to :project

  validates :role, presence: true
  validates :user_id, uniqueness: {scope: :project_id}
end
