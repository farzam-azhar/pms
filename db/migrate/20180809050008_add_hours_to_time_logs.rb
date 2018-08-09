class AddHoursToTimeLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :time_logs, :hours, :integer
  end
end
