class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end
  
	def create
		@movie = Movie.new(movie_params)
		if @movie.save
			redirect_to admin_movies_path
		else
      flash.now[:danger] = "新規データ登録に失敗しました"
			render 'new'
		end
	end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to admin_movies_path
    else
      flash.now[:danger] = "データの更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to admin_movies_path, notice: "データの削除に成功しました"
    else
      flash.now[:danger] = "データの削除に失敗しました"
      render 'index'
    end
  end

	private

		def movie_params
			params.require(:movie).permit(:name, :image_url, :description, :year, :is_showing)
		end
end
