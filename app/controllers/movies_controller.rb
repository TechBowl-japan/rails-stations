class MoviesController < ApplicationController
	# GET / movies
	def index
		@movies = Movie.all
	end

end
