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
      render 'new'
    end
  end

  private

    def movie_params
        params.require(:movie).permit(:name, :year, :is_showing,
                                     :description,:image_url)
    end
end
