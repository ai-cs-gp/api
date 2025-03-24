class CreatePartUsages < ActiveRecord::Migration[8.0]
  def change
    create_table :part_usages do |t|
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.references :part, null: false, foreign_key: true
      t.references :solution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
