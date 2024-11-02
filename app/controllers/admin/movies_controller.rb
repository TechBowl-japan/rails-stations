class Admin::MoviesController < ApplicationController
  index do
    @movies = Movie.all
  end
end
