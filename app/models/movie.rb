class Movie < ApplicationRecord
  validates :title, presence: true 
  validates :image, presence: true 
end
