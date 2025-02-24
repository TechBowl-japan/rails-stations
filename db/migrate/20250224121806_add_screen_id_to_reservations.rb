class AddScreenIdToReservations < ActiveRecord::Migration[7.1]
  def up
    add_reference :reservations, :screen, null: true, foreign_key: true

    # 既存のデータに `screen_id` を適切に設定
    Reservation.find_each do |reservation|
      schedule = Schedule.find_by(id: reservation.schedule_id)
      if schedule
        reservation.update!(screen_id: schedule.screen_id)
      else
        raise "予約 ID: #{reservation.id} に対応するスケジュールが見つかりません"
      end
    end

    # `screen_id` を NULL 不可にする
    change_column_null :reservations, :screen_id, false
  end

  def down
    remove_foreign_key :reservations, :screens
    remove_reference :reservations, :screen
  end
end
