class Client < ApplicationRecord
  validates :name, presence: true, length: { in: 5..15 }
  validates :email, presence: true, uniqueness: true, format: { with: Devise::email_regexp }
  validates :country_code, presence: true
  
  def country_name
    country = ISO3166::Country[country_code]
  end
end
