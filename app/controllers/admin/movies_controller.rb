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
      redirect_to admin_movies_path, notice: "投稿しました"
      # binding.pry
    else
      flash.now[:alert] = "入力内容が間違っています"
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if  @movie.update(movie_params)
      redirect_to admin_movies_path, notice: "#{@movie.id}の情報を更新しました"
    else
      flash.now[:alert] = "入力内容が間違っています"
      render :new
    end
  end

  private 
  def movie_params
    params.require(:movie).permit(:name, :year, :is_showing, :image_url, :description)
  end

end