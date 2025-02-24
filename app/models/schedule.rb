class Schedule < ApplicationRecord
  belongs_to :screen
  belongs_to :movie
  has_many :reservations
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :screen_id, presence: true
end
