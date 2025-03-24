class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.string :name, null: false
      t.string :plate_number, null: false
      t.string :color, null: false
      t.string :brand, null: false # can be choosen from a list
      t.string :model, null: false
      t.integer :year, null: false

      t.references :member, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
