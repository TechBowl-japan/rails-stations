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
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      @movie.save
      flash[:success] = "Movie updated"
      redirect_to @movie
    else
      flash.now[:error] = "Could not save client"
      render 'edit'
    end
  end

  def show
    redirect_to edit_movie_path
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:success] = "Movie deleted"
    redirect_to movies_path
  end

  def view
  end

  private

    def movie_params
        params.permit(:name, :year, :is_showing,
                                     :description,:image_url)
    end
end
