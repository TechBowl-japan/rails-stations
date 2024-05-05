class AddUserIdToReservations < ActiveRecord::Migration[6.1]
  def change
    # add_reference :reservations, :user, null: false, foreign_key: true
  end
end
