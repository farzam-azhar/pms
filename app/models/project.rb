class Project < ApplicationRecord
  enum status: [:pending, :in_progress, :completed]

  default_scope { where.not(status: :completed) }
  scope :top_projects, -> { unscoped.preload(:payments).joins(:payments).group('projects.id').order("sum(payments.amount) DESC") }
  scope :bottom_projects, -> { top_projects.reorder("sum(payments.amount) ASC") }
  scope :current_month_earnings, -> {
    unscoped.joins(:payments).
    where('payments.created_at >= ? AND payments.created_at <= ?', Date.today.beginning_of_month, Date.today.end_of_month).
    group('projects.id').
    sum('payments.amount')
  }
  scope :current_month_time_logs, -> {
    unscoped.joins(:time_logs).
    where('time_logs.created_at >= ? AND time_logs.created_at <= ?', Date.today.beginning_of_month, Date.today.end_of_month).
    group('projects.id').
    sum('time_logs.end_time - time_logs.start_time')
  }
  scope :by_month_earnings, -> {
    unscoped.joins(:payments).
    group('MONTHNAME(payments.created_at)').
    sum('payments.amount')
  }
  scope :by_month_logs, -> {
    unscoped.joins(:time_logs).
    group('MONTHNAME(time_logs.created_at)').
    sum('time_logs.end_time - time_logs.start_time')
  }

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

  def total_earnings
    self.payments.map(&:amount).sum
  end
end
