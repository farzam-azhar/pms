class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  has_attached_file :data, styles: { medium: "300x300>", thumb: "35x35#" },
  default_url: lambda { |image| ActionController::Base.helpers.asset_path('default.png') }
  validates_attachment_content_type :data, content_type: ['application/pdf', 'application/msword', 'text/plain', 'image/png', 'image/jpg', 'image/jpeg']
end
