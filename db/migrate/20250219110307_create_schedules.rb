class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :movie, null: false, foreign_key: true, index: true  # 外部キー制約
      t.time :start_time, null: false, comment: '上映開始時刻'
      t.time :end_time, null: false, comment: '上映終了時刻'
      t.timestamps
    end
  end
end
