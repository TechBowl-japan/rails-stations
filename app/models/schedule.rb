class Schedule < ApplicationRecord
  belongs_to :movie
  accepts_nested_attributes_for :movie
  validates :movie_id, presence: true
end
