class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.paginate(page: params[:page], per_page: 16)
  end
end
