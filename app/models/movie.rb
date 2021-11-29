class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum:160 }
  validates :year, length: { maximum:45 }
  validates :image_url, length: { maximum:100 }
  validates :is_showing, presence: true
end
