class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true, index: true
      t.references :project, foreign_key: true, index: true
      t.string :role, limit: 20

      t.timestamps
    end
  end
end
