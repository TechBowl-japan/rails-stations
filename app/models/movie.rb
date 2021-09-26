class Movie < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :image_url, presence: true, length: { maximum: 50 }
end
