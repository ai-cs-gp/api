class CreateFixingCars < ActiveRecord::Migration[8.0]
  def change
    create_table :fixing_cars do |t|
      t.string :state, null: false, default: "pending"
      t.datetime :pending_at
      t.datetime :in_progress_at
      t.datetime :completed_at
      t.datetime :failed_at

      t.references :car, null: false, foreign_key: true
      t.references :technician, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
