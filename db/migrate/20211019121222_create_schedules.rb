class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules, auto_increment: true, :null => false do |t|
      t.references :movie, :null => false
      t.time :start_time, :null => false, comment: "上映開始時刻"
      t.time :end_time, :null => false, comment: "上映終了時刻"
      t.timestamps
    end
    add_index :schedules, :movie_id, name: 'movie_id_idx', order: {movie_id: :asc}
  end
end
