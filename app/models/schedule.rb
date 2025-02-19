class Schedule < ApplicationRecord
  belongs_to :movie
  validates :start_time, presence: true
  validates :end_time, presence: true
end
