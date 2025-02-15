class MoviesController < ApplicationController
    def index 
      @movies = Movie.all
      @movies = filter_by_showing_status(@movies)
      @movies = filter_by_keyword(@movies)
    end

    # 上映フィルタリング
    def filter_by_showing_status(movies)
      case params[:is_showing]
      when "1"
        movies.where(is_showing: true)
      when "0"
        movies.where(is_showing: false)
      else
        movies
      end
    end

    # タイトルフィルタリング
    def filter_by_keyword(movies)
      if params[:keyword].present?
        movies.where("name LIKE ? OR description LIKE ?",
          "%#{params[:keyword]}%",
          "%#{params[:keyword]}%")
      else
        movies
      end
    end

end
