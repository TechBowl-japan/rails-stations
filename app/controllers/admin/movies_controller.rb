class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
  end

  def new
  end


  def create
  end
end
