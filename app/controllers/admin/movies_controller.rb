class Admin::MoviesController < ApplicationController
	# GET admin/movies
	def index
		@movies = Movie.all
	end
end
