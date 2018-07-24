class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :estimated_price
      t.date :end_date
      t.references :client, foreign_key: true, index: true

      t.timestamps
    end
  end
end
