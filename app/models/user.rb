class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :photo, class_name: 'Attachment', as: :attachable
 	accepts_nested_attributes_for :photo

  validates :username, presence: true
  validates :username, length: { in: 6..15 }
  validates :contact, format: { 
  	with: /((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$/, multiline: true, 
		message: 'given format not supported.' 
	}
  validates :gender, presence: true, inclusion: { in: %w(M F), message: 'You must select Male or Female Only.' }
end
