class SchedulesController < ApplicationController

  def show
    @schedule = Schedule.find(params[:id])
  end

  def create
    Schedule.find(params[:id]).create!
  end
end
