class CreateProblems < ActiveRecord::Migration[8.0]
  def change
    create_table :problems do |t|
      t.string :description, null: false

      t.references :fixing_car, null: false, foreign_key: true
      t.timestamps
    end
  end
end
