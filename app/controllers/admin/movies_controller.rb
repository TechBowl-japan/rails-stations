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
    else
      flash.now[:alert] = "入力内容が間違っています"
      render :new
    end
  end

  # def create
  #   begin
  #     Movie.create(movie_params)
  #       redirect_to admin_movies_path, notice: "投稿しました"
  #   rescue ActiveRecord::ValueTooLong => e
  #     logger.error("エラー内容: #{e.message}")
  #     flash.now[:alert] = "入力内容が間違っています"
  #     render :new
  #   end
  # end

  private 
  def movie_params
    params.permit(:name, :year, :is_showing, :image_url, :description)
  end

end