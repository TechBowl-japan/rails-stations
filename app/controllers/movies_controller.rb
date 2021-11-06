class MoviesController < ApplicationController
  def index
    # パラメータが空であればMovie.allを表示させる
    if movie_search_params[:search].blank? && movie_search_params[:keyword].blank? && movie_search_params[:is_showing].blank?
      @movies = Movie.all
    else
      @movies = Movie.search(movie_search_params)
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end

  def movie_search_params
    params.fetch(:search, {}).permit(:keyword, :is_showing)
  end

  def movie_search_params
    params.fetch(:search, {}).permit(:keyword, :is_showing)
  end
end

# fetchメソッド
# params.fetch(:search, {})は、params[:search]が空の場合{}をparams[:search]が空でない場合、params[:search]を返す

