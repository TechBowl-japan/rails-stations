class Movie < ApplicationRecord
	has_many :schedules
	validates :name, presence: true, uniqueness: true
	validates :image_url, presence: true, length: { maximum: 50 }

	def self.search(keyword, is_showing)
		@movies = Movie.all
		if keyword.present?
			@movies = @movies.where('name LIKE ? OR description LIKE ?',
				 "%#{keyword}%", "%#{keyword}%")
		end
		if is_showing.present?
			@movies = @movies.where(is_showing: is_showing)
		end
		@movies
	end
end
