class MoviesController < ApplicationController

  def index
    byebug
    @movies = Movie.search(search_params[:keyword],
                           search_params[:is_showing])
  end

  private

    def search_params
      params.permit(:keyword, :is_showing, :commit, :controller, :action)
    end
end
