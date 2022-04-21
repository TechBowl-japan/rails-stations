class Admin::MoviesController < ApplicationController
	# GET admin/movies
	def index
		@movie = Movie.all
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def new
		@movie = Movie.new()
	end

	def create
		@movie = Movie.new(movie_params)
		begin
			@movie.save!
			flash[:notice] = "データの登録が完了しました"
			redirect_to admin_movies_path
		rescue ActiveRecord::RecordInvalid
			flash[:alert]= "データの登録に失敗しました"
			redirect_to new_admin_movie_path
		end

	end

	private

	def movie_params
		params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
	end

end
