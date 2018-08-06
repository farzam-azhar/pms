class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :description, :estimated_price, :end_date
  belongs_to :client
end
