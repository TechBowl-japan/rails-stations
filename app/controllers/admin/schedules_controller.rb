class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.paginate(page: params[:page], per_page: 16)
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @movie = @schedule.movie
  end

  private

    def movie_params
      params.require(:schedule).permit(:movie_id, :start_time, :end_time, movie_attributes: [:id, :name])
    end
end
