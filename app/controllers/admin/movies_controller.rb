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
      # flash[:success] = "Welcome!"
      redirect_to '/movies'
    else
      flash.now[:danger] = "Error"
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:success] = "Updated"
      redirect_to '/movies'
    else
      flash[:danger] = "Error"
      render 'edit'
    end
  end

  private 

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end

end
