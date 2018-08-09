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
    sum('time_logs.hours')
  }
  scope :by_month_earnings, -> {
    unscoped.joins(:payments).
    group('extract(month from payments.created_at)').
    sum('payments.amount')
  }
  scope :by_month_logs, -> {
    unscoped.joins(:time_logs).
    group('extract(month from time_logs.created_at)').
    sum('time_logs.hours')
  }

  def self.search(title, client_name, assigned_user_name, description)
    unscoped.
    eager_load(:client, :assigned_users).
    where(
      self.where_clause(title, client_name, assigned_user_name, description),
      self.params_hash(title, client_name, assigned_user_name, description)
    )
  end

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
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: self.statuses.keys }


  def total_earnings
    self.payments.map(&:amount).sum
  end

  def self.where_clause(title, client_name, assigned_user_name, description)
    where = []
    where << "LOWER(projects.title) LIKE :title " if title.present?
    where << "LOWER(clients.name) LIKE :client_name " if client_name.present?
    where << "LOWER(users.username) LIKE :assigned_user_name " if assigned_user_name.present?
    where << "LOWER(projects.description) LIKE :description" if description.present?
    where.join(" OR ")
  end

  def self.params_hash(title, client_name, assigned_user_name, description)
    bind_values = {}
    bind_values[:title] = "%#{title.downcase}%" if title.present?
    bind_values[:client_name] = "%#{client_name.downcase}%" if client_name.present?
    bind_values[:assigned_user_name] = "%#{assigned_user_name.downcase}%" if assigned_user_name.present?
    bind_values[:description] = "%#{description.downcase}%" if description.present?
    bind_values
  end
end
