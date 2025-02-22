class MoviesController < ApplicationController
    def index 
      @movies = Movie.all
      @movies = filter_by_showing_status(@movies)
      @movies = filter_by_keyword(@movies)
    end

    def show
      @movie = Movie.find(params[:id])
      @schedules = @movie.schedules ? @movie.schedules.order(:start_time) : nil
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

    def reservation
      if params[:date].blank? || params[:schedule_id].blank?
        redirect_to movie_path(params[:movie_id]), alert: "日付とスケジュールを選択してください。" and return
      end

      @movie = Movie.find(params[:movie_id])
      @schedule = Schedule.find(params[:schedule_id])
      @sheets= Sheet.all
      @reserved_sheets = Reservation.where(
        date: params[:date],
        schedule_id: params[:schedule_id]
        ).pluck(:sheet_id)
    end
end
