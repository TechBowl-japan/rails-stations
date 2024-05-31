class Sheet < ApplicationRecord
  has_many :reservations

  def reserved?(schedule)
    # reservations.exists?(schedule: schedule)
    reservations.joins(:schedule).exists?(schedule: schedule, schedules: { screen_id: schedule.screen_id })
  end
end
