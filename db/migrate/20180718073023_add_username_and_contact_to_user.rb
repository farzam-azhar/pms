class AddUsernameAndContactToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :contact, :string
  end
end
