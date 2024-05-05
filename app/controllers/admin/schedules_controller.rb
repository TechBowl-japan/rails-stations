module Admin
    class SchedulesController < ApplicationController
      def index
        @movies = Movie.includes(:schedules).where.not(schedules: { id: nil })
      end
  
      def show
        @schedule = Schedule.find(params[:id])
      end
  
      def edit
        @schedule = Schedule.find(params[:id])
      end
  
      def update
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schedule_params)
          redirect_to admin_schedule_path(@schedule), notice: '上映スケジュールを更新しました。'
        else
          render :edit
        end
      end
  
      def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy
        redirect_to admin_schedules_path, notice: 'スケジュールを削除しました。'
      end
  
      private
  
      def schedule_params
        params.require(:schedule).permit(:start_time, :end_time)
      end
    end
  end
  