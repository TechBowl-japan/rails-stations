class ReservationsController < ApplicationController
  def new
    if params[:sheet_id].blank?
      redirect_to movies_path, status: :found # 302リダイレクト
      return
    end

    if params[:date].blank?
      redirect_to movies_path, status: :found # 302リダイレクト
      return
    end

    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @sheet = Sheet.find(params[:sheet_id])
    @eservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @movie = Movie.find(params[:reservation][:movie_id])
    @schedule = Schedule.find(params[:reservation][:schedule_id])
    @sheet = Sheet.find(params[:reservation][:sheet_id])
    @reservation.date = @schedule.start_time.to_date

    if @reservation.save
      flash[:success] = "予約が完了しました"
      redirect_to movie_path(@movie)
    else
      flash[:failed] = "その時間は予約できません"
      redirect_to reservation_movie_path(@movie, schedule_id: @schedule.id, date: params[:reservation][:date])
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :name, :email)
  end
end
