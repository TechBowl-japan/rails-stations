class Schedule < ApplicationRecord
  belongs_to :movie
  accepts_nested_attributes_for :movie
  validates :movie_id, presence: true
  REGISTRABLE_ATTRIBUTES = %i(
    start_time(1i) start_time(2i) start_time(3i) start_time(4i) start_time(5i)
    end_time(1i) end_time(2i) end_time(3i) end_time(4i) end_time(5i)
  )
end
