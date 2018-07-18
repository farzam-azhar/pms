class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  has_attached_file :data, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :data, content_type: ['application/pdf', 'application/msword', 'text/plain', 'image/png', 'image/jpg', 'image/jpeg']
end
