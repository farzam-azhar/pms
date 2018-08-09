class Payment < ApplicationRecord
  enum methods: [:Visa, :Master, :Cash]

  belongs_to :project
  belongs_to :created_by, class_name: 'User'

  validates :amount, presence: true
  validates :method, presence: true
  validates :created_by, presence: true

  def creator
    self.created_by.username + ' - ' + self.created_by.role
  end
end
