class AddGenderToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :string, limit: 1
  end
end
