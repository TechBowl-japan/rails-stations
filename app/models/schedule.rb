class Schedule < ApplicationRecord
    belongs_to :movie
    has_many :reservations
    has_many :sheets
end
