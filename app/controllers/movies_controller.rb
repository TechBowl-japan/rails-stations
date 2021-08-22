class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.save
      redirect_to new_movie_path
    else
      flash.now[:error] = "Could not save client"
      render 'new'
    end
  end

  def edit
    @movie = Movie.new
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:success] = "Movie updated"
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def show
    redirect_to edit_movie_path
  end

  private

    def movie_params
        params.require(:movie).permit(:name, :year, :is_showing,
                                     :description,:image_url)
    end
end
