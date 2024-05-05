class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.references :schedule, null: false, foreign_key: true, index: { name: 'reservation_schedule_id_idx' }
      t.references :sheet, null: false, foreign_key: true, index: { name: 'reservation_sheet_id_idx' }
      t.string :email, null: false, comment: '予約者メールアドレス'
      t.string :name, null: false, comment: '予約者名'
      t.timestamps
      end
  
      add_index :reservations, [:date, :schedule_id, :sheet_id], unique: true, name: 'reservation_schedule_sheet_unique'
  end
end
