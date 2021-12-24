class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.references :movie, null: false, index: true
      t.timestamps :start_time, null: false
      t.timestamps :end_time, null: false
      t.timestamps
    end
    
    add_foreign_key :schedules, :movies, on_delete: :restrict, on_update: :restrict

  end
end
