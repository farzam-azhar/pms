class User < ApplicationRecord
  attr_writer :login
  
  enum status: [:enabled, :disabled]
  enum role: [:user, :manager, :admin]
  enum genders: [:Male, :Female]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  scope :except_admin, -> { where.not(role: :admin) }
  scope :not_assigned_users, -> (project) { all - project.assigned_users }

  has_one :photo, class_name: 'Attachment', as: :attachable
  accepts_nested_attributes_for :photo

  has_many :assignments, dependent: :destroy
  has_many :working_projects, through: :assignments, source: :project
  has_many :time_logs, dependent: :destroy
  has_many :logged_projects, through: :time_logs, source: :project

  validates :username, presence: true, length: { in: 6..15 }, uniqueness: true
  validates :contact, format: { 
    with: /((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$/, multiline: true, 
    message: 'given format not supported.' 
  }
  validates :gender, presence: true, inclusion: { in: self.genders.keys, message: 'You must select Male or Female Only.' }

  def active_for_authentication?
    super && enabled?
  end
  
  def inactive_message
    enabled? ? super : :not_enabled
  end
  
  def login
    @login || self.username || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def toggle_status!
    self.disabled? ? self.enabled! : self.disabled!
  end
  
  def toggle_role!
    self.manager? ? self.user! : self.manager!
  end

  def image(size = :thumb)
    image = self.photo.present? ? self.photo.data.url(size) : 'default'
  end

  def to_s
    username
  end

  def get_projects
    self.manager? ? Project.all : self.working_projects
  end
end
