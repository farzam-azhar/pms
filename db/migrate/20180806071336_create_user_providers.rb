class CreateUserProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_providers do |t|
      t.references :user, foreign_key: true, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
