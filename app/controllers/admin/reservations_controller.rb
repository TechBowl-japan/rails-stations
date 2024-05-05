module Admin
    class ReservationsController < ApplicationController
      before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  
      def index
        @reservations = Reservation.includes(:movie, :schedule)
                                   .where('schedules.end_time > ?', Time.now)
                                   .references(:schedules)
      end
  
      def new
        @reservation_new = Reservation.new
        @sheets = Sheet.all
        @movies = Movie.all
        @schedules = Schedule.all
        @users = User.all
      end
  
      def create
        @reservation = Reservation.new(reservation_params)
        @movie = Movie.find_by(params[:reservation][:movie_id])
        @reservation_sheet = Reservation.find_by(date: reservation_params[:date],
                                                 sheet_id: reservation_params[:sheet_id],
                                                 schedule_id: reservation_params[:schedule_id])
    
        if @reservation_sheet
          flash[:error] = '既に予約されています'
          redirect_to admin_reservations_path(params[:reservation][:movie_id],
                                             date: reservation_params[:date],
                                             schedule_id: reservation_params[:schedule_id]), status: :bad_request
          return
        end
    
        if @reservation.save
          flash[:success] = '予約が完了しました'
          redirect_to admin_reservations_path
        else
          render :new
        end
      end
  
    def show
        @reservation = Reservation.find(params[:id])
        @movies = Movie.all  # Ensure this line exists to fetch all movies
        @schedules = Schedule.all  # Fetch all schedules
        @sheets = Sheet.all        # Fetch all sheets
    end
  
  
    def update
        @reservation = Reservation.find(params[:id])
  
        # 重複予約のチェック
        existing_reservation = Reservation.where(schedule_id: reservation_params[:schedule_id], sheet_id: reservation_params[:sheet_id])
                                          .where.not(id: @reservation.id) # 現在の予約を除外
                                          .exists?
        if existing_reservation
          flash[:alert] = 'その座席はすでに予約済みです'
          redirect_to admin_reservations_path, status: :bad_request
          return
        end
      
        if @reservation.update(reservation_params)
          redirect_to admin_reservations_path, notice: '予約が正常に更新されました。'
        else
            render :edit, status: :bad_request
        end
      end

      def destroy
        @reservation.destroy
        redirect_to admin_reservations_path, notice: '予約が削除されました。'
      end
  
      private
  
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      def reservation_params
        params.require(:reservation).permit(:date, :sheet_id, :schedule_id, :email, :name, :screen_id, :user_id)
      end
    end
  end