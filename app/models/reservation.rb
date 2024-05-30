class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet
end
