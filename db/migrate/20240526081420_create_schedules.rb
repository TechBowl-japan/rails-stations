class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.references :movie, null: false, foreign_key: true
      t.time :start_time, null: false, comment: '上映開始時刻'
      t.time :end_time, null: false, comment: '上映終了時刻'

      t.timestamps
    end
  end
end
