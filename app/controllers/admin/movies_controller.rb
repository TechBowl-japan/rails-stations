class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.paginate(page: params[:page], per_page: 16)
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules.paginate(page: params[:page], per_page: 16)
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      # flash[:success] = "Welcome!"
      redirect_to admin_movies_path
    else
      flash.now[:alert] = "Error"
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      # flash[:success] = "Updated"
      redirect_to admin_movies_path
    else
      flash.now[:alert] = "Error"
      render 'edit'
    end
  end

  def destroy
    Movie.find(params[:id]).destroy
    flash.now[:success] = "Movie deleted"
    redirect_to admin_movies_path
  end

  private 

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end

end
