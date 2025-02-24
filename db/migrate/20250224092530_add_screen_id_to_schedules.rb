class AddScreenIdToSchedules < ActiveRecord::Migration[7.1]
  def up
    add_reference :schedules, :screen, null: true, foreign_key: true
    
    Screen.transaction do
      screen = Screen.first || Screen.create!(name: 'スクリーン1')
      Schedule.update_all(screen_id: screen.id)
      change_column_null :schedules, :screen_id, false
    end
  end

  def down
    remove_foreign_key :schedules, :screens
    remove_reference :schedules, :screen
  end
end
