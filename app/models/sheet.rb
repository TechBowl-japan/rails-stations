class Sheet < ApplicationRecord
  has_many :reservations

  def reserved?(schedule)
    reservations.exists?(schedule: schedule)
  end
end
