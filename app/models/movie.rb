class Movie < ApplicationRecord
  has_many :schedules
  validates :name, presence: true, uniqueness: true, length: { maximum:160 }, allow_nil: true
  validates :year, length: { maximum:45 }, allow_nil: true
  validates :image_url, length: { maximum:100 }, allow_nil: true
  validates :is_showing, presence: true, allow_nil: true
end
