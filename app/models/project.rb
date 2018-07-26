class Project < ApplicationRecord
  belongs_to :client

  has_many :payments
  has_many :assignments, dependent: :destroy
  has_many :assigned_users, through: :assignments, source: :user
  has_many :time_logs, dependent: :destroy
  has_many :logged_users, through: :time_logs, source: :user

  validates :title, presence: true
  validates :estimated_price, presence: true
  validates :end_date, presence: true
  validates :description, length: { in: 15..550 }
end
