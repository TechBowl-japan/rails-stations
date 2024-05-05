class ReservationsController < ApplicationController
  before_action :login_check, only: [:new]

    def new
        @reservation = Reservation.new
        @movie = Movie.find_by(id: params[:movie_id])
        if @movie.nil?
          redirect_to movies_path, alert: "指定された映画が見つかりません。"
          return
        end

        @date = params[:date]
        @screen = params[:screen_id]
        @schedule = Schedule.find_by(id: params[:schedule_id])
        @sheet = Sheet.find_by(id: params[:sheet_id])

        unless params[:date].present? && params[:sheet_id].present?
            redirect_to movie_path(@movie), alert: "日付と座席IDの両方が必要です。", status: :found
            return
        end        
    end

    def create
      @reservation = Reservation.new(reservation_params)
      @reserved_sheet = Reservation.find_by(date: params[:reservation][:date],
                                            schedule_id: params[:reservation][:schedule_id],
                                            sheet_id: params[:reservation][:sheet_id],
                                            screen_id: params[:reservation][:screen_id]
                                            )
  
      if @reserved_sheet
        flash[:notice] = 'その座席はすでに予約済みです。'
        redirect_to reservation_movie_path(id: params[:reservation][:movie_id],
                                               schedule_id: params[:reservation][:schedule_id],
                                               date: params[:reservation][:date],
                                               sheet_id: params[:reservation][:sheet_id]
                                              )
        return
      end
  
      if @reservation.save
        flash[:success] = '予約が完了しました。'
        redirect_to movie_path(params[:reservation][:movie_id])
      else
        flash[:alert] = '予約に失敗しました。'
        render :new
      end
    end
  
  private  
    def reservation_params
      params.require(:reservation).permit(:date, :sheet_id, :schedule_id, :email, :name, :screen_id, :user_id)
    end

    def login_check
        if !user_signed_in?
            redirect_to movies_path
            flash[:alert] = 'ログインをしてください'
        end
    end
end