class Movie < ApplicationRecord
  validates :name,  uniqueness: true
  validates :image_url, length: { maximum: 50 }
  
  # enum is_showing: {not_yet: 0, showing:1}
end
