class TimeLog < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :valid_end_time , if: Proc.new { |log| log.start_time != "" && log.end_time != "" }

  def valid_end_time
    if start_time.to_time + 30.minutes > end_time.to_time
      errors.add(:end_time, "must be at-least 30 minutes after start time")
    end
  end

  def valid_user?(user)
    self.user == user
  end
end
