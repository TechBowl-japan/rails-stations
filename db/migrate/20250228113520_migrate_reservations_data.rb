class MigrateReservationsData < ActiveRecord::Migration[7.1]
  def up
    User.transaction do
      Reservation.find_each do |reservation|
        user = User.find_or_create_by!(email: reservation.email) do |u|
          u.name = reservation.name
          u.password = SecureRandom.hex(10) # 仮のパスワードを設定
        end
        reservation.update!(user_id: user.id)
      end
    end

    change_column_null :reservations, :user_id, false
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end