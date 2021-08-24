class MoviesController < ApplicationController
  def index
    if params[:name].present?
      @movies = Movie.where("name LIKE?","%#{params[:name]}%")
    else
      @movies = Movie.all
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.save
      redirect_to movies_path
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
      redirect_to "/admin/movies"
    else
      flash.now[:error] = "Could not save client"
      render 'edit'
    end
  end

  def show
    redirect_to "/admin/movies/:id/edit"
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:success] = "Movie deleted"
    redirect_to "/admin/movies"
  end

  def view
    @movies = Movie.all
  end

  private

    def movie_params
        params.require(:movie).permit(:name, :year, :is_showing,
                                     :description,:image_url)
    end
end
