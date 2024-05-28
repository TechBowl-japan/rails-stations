class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
    @movies = Movie.all
  end

  def new
    @schedule = Schedule.new
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to admin_schedules_path
    else
      render :new
    end
  end

  def update
    @schedule = Schedule.new(schedule_params)
    if @schedule.update
      redirect_to admin_schedules_path
    else
      render :new
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    if @schedule.destroy
      redirect_to admin_schedules_path
    else
      render :edit
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:movie_id,:start_time, :end_time)
  end
end
