class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
  end
end
