class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.float :amount
      t.string :method, limit: 10
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :project, foreign_key: true, index: true

      t.timestamps
    end
  end
end
