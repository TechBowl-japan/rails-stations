class SchedulesController < ApplicationController
  def create
    Schedule.find(params[:id]).create!
  end
end
