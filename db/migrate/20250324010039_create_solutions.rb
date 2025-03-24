class CreateSolutions < ActiveRecord::Migration[8.0]
  def change
    create_table :solutions do |t|
      t.string :description, null: false

      t.references :problem, null: false, foreign_key: true
      t.timestamps
    end
  end
end
