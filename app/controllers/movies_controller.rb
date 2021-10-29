class MoviesController < ApplicationController
  def index
    #indexアクションが呼ばれると@moviesに値がはいってる
    # @movies = Movie.search(movie_search_params) unless movie_search_params.blank?
    # binding.pry
    # @movies_all = Movie.all if @movies.empty?

    # パラメータが空であればMovie.allを表示させる
    if movie_search_params[:search].blank? && movie_search_params[:keyword].blank? && movie_search_params[:is_showing].blank?
      @movies_all = Movie.all
    else
      @movies = Movie.search(movie_search_params)
    end
  end

  def search_movie
    @search_movies = Movie.search(movie_search_params)
    render :index
  end

  def movie_search_params
    params.fetch(:search, {}).permit(:keyword, :is_showing)
  end
end

# fetchメソッド
# params.fetch(:search, {})は、params[:search]が空の場合{}をparams[:search]が空でない場合、params[:search]を返す

