class Admin::MoviesController < ApplicationController
	# GET admin/movies
	def index
		@movie = Movie.all
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		begin
			# 更新処理
			@movie.update!(movie_params)
			flash[:notice] = "データの更新が完了しました"
			redirect_to admin_movies_path
		rescue ActiveRecord::RecordInvalid
			flash[:alert]= "データの更新に失敗しました"
			redirect_to edit_admin_movie_url(@movie.id)
		end
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
