class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :schedule, null: false, index: true
      t.references :sheet, null: false, index: true
      t.string :email, null: false
      t.string :name, null: false
      t.datetime :date, null: false
      t.timestamps
    end

    add_foreign_key :reservations, :schedules, on_delete: :restrict, on_update: :restrict
    add_foreign_key :reservations, :sheets, on_delete: :restrict, on_update: :restrict
    add_index :reservations, [:date, :schedule_id, :sheet_id], unique: true

  end
end
