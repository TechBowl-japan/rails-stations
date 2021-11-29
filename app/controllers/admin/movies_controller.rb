class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:success] = "Welcome!"
      redirect_to @movie
    else
      flash[:warning] = "Error"
      render 'new'
    end
  end
end
