class TimeLogSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time

  belongs_to :user
  belongs_to :project
end
