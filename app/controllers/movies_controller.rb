class MoviesController < ApplicationController
  def index
    #ページネーションの機能をつける
    @movies_pagination = Movie.paginate(page: params[:page], per_page: 12)

    #検索オブジェクト
    @search = @movies_pagination.ransack(params[:q])
    @movies = @search.result.page(params[:page]).order("created_at desc")
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end
end
