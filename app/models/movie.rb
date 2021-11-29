class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum:50 }
  validates :year, length: { maximum:45 }
  validates :image_url, length: { maximum:150 }
end
