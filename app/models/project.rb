class Project < ApplicationRecord
  belongs_to :client
  has_many :payments

  validates :title, presence: true
  validates :estimated_price, presence: true
  validates :end_date, presence: true
  validates :description, length: { in: 15..550 }
end
