class MoviesController < ApplicationController
  def index
    if params[:is_showing].present?
      is_showing = case params[:is_showing]
                   when "true", "on"
                     true
                   when "false"
                     false
                   else
                     nil
                   end
      @movies = Movie.where(is_showing: is_showing) unless is_showing.nil?
    end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @movies = @movies.where('name LIKE ? OR description LIKE ?', keyword, keyword)
    end

    if params[:is_showing].blank? && params[:keyword].blank?
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end

  def reservation
    @movie = Movie.find(params[:id])
    if params[:schedule_id].blank? || params[:date].blank?
      redirect_to movie_path(@movie), status: :found # 302リダイレクト
      return
    end
    @schedule = Schedule.find(params[:schedule_id])
    @sheets = Sheet.all
    @columns = Sheet.all.pluck(:column).uniq.sort
  end
end
