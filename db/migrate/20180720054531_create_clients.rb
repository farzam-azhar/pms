class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email, unique: true
      t.string :country_code, limit: 2

      t.timestamps
    end
    add_index :clients, :email, unique: true
  end
end
