class MoviesController < ApplicationController
  def index
    @movies = Movie.all

    if params[:keyword].present?
      @movies = @movies.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:is_showing].present?
      @movies = @movies.where(is_showing: params[:is_showing] == '1')
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end

  def reservation
    @movie = Movie.find_by(id: params[:id])
    if @movie.nil?
      redirect_to movie_path(@movie), alert: "指定された映画が見つかりません。"
      return
    end

    @schedule = Schedule.find_by(id: params[:schedule_id])
    @date = params[:date]    
    @sheets = Sheet.order(:row, :column)

    # 予約済みのシートID
    @reserved_sheet_ids = Reservation.where(date: @date, schedule_id: @schedule.id, screen_id: @movie.screen_id).pluck(:sheet_id)
  
    unless params[:date].present? && params[:schedule_id].present?
      redirect_to movie_path(@movie), alert: "日付またはスケジュールIDのいずれかが必要です", status: :found
      return
    end
  end

end