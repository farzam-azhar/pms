class Client < ApplicationRecord
  enum status: [:enabled, :disabled]

  validates :name, presence: true, length: { in: 5..15 }
  validates :email, presence: true, uniqueness: true, format: { with: Devise::email_regexp }
  validates :country_code, presence: true
  validates :status, presence: true, inclusion: { in: self.statuses.keys }

  default_scope { where(status: :enabled) }

  has_many :projects

  def country_name
    ISO3166::Country[country_code]
  end

  def toggle_status!
    self.enabled? ? self.disabled! : self.enabled!
  end
end
