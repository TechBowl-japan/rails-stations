class MoviesController < ApplicationController

  def index
    @movies = Movie.search(search_params[:keyword],
                           search_params[:is_showing])
  end

  private

    def search_params
      params.permit(:keyword, :is_showing)
    end
end
