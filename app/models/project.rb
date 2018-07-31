class Project < ApplicationRecord
  enum status: [:pending, :in_progress, :completed]

  default_scope { where.not(status: :completed) }

  belongs_to :client

  has_many :payments
  has_many :assignments, dependent: :destroy
  has_many :assigned_users, through: :assignments, source: :user
  has_many :time_logs, dependent: :destroy
  has_many :logged_users, through: :time_logs, source: :user
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable, inverse_of: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true
  validates :estimated_price, presence: true
  validates :end_date, presence: true
  validates :description, length: { in: 15..550 }
  validates :status, presence: true, inclusion: { in: self.statuses.keys }
end
