class Movie < ApplicationRecord
  validates :name,  uniqueness: true
  validates :image_url, length: { maximum: 50 }

  # validates :email, presence: true, length: { maximum: 255 },
  #           uniqueness: true
end
