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
      # binding.pry
      redirect_to admin_movies_path, notice: "投稿しました"
      # binding.pry
    else
      flash.now[:alert] = "入力内容が間違っています"
      render :new
    end
  end

  # def create
  #   @movie = Movie.new(movie_params)
  #   begin
  #     @movie.save
  #     redirect_to admin_movies_path, notice: "投稿しました"
  #   rescue ActiveRecord::ValueTooLong => e
  #     logger.error("エラー内容: #{e.message}")
  #     render "errors/not_found", status: 404
  #     render :new
  #   end
  # end

  private 
  def movie_params
    params.require(:movie).permit(:name, :year, :is_showing, :image_url, :description)
  end

end