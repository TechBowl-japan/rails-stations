class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.paginate(page: params[:page], per_page: 16)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to admin_schedules_path
    else
      flash.now[:alert] = "Error"
      render 'new'
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @movie = @schedule.movie
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to admin_schedules_path
    else
      flash.now[:alert] = "Error"
      render 'edit'
    end
  end

  def destroy
    Schedule.find(params[:id]).destroy
    flash.now[:success] = "Schedule deleted"
    redirect_to admin_schedules_path
  end

  private

    def schedule_params
      params.require(:schedule).permit(:movie_id, Schedule::REGISTRABLE_ATTRIBUTES, movie_attributes: [:id, :name])
    end
end
