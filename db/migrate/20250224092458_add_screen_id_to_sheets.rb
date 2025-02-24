class AddScreenIdToSheets < ActiveRecord::Migration[7.1]
  def up
    add_reference :sheets, :screen, null: true, foreign_key: true
    
    Screen.transaction do
      screen = Screen.find_or_create_by!(name: 'スクリーン1')
      Sheet.update_all(screen_id: screen.id)
      change_column_null :sheets, :screen_id, false
    end
  end

  def down
    remove_foreign_key :sheets, :screens
    remove_reference :sheets, :screen
  end
end