class ChangeLimitOfGenderInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :gender, :string, limit: 10
  end
end
