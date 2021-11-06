class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      # moviesモデルのidがbigintでなくintなためreferencesで作成すると不一致でエラーが起きる。アソエーションで, foreign_keyを付与すればいけるか？
      t.datetime :start_time, null: false, comment: "上映開始時刻"
      t.datetime :end_time, null: false, comment: "上映終了時刻"
      t.integer :movie_id, foreign_key: true, null: false
      t.timestamps
    end
    add_index :schedules, :movie_id
  end
end
