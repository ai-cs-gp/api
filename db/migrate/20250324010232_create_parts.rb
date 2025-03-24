class CreateParts < ActiveRecord::Migration[8.0]
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :brand, null: false
      t.string :model, null: false
      t.integer :year, null: false

      t.references :member, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
