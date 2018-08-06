class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :country_name
  has_many :projects
end
