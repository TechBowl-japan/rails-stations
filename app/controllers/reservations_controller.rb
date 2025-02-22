class ReservationsController < ApplicationController
  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movie_reservation_path(params[:movie_id], schedule_id: params[:schedule_id], date: params[:date]), alert: "座席を選択してください。" and return
    end
    @reservation = Reservation.new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @sheet = Sheet.find(params[:sheet_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)  
    if @reservation.save
      redirect_to movie_path(@reservation.schedule.movie), notice: "予約が完了しました。"
    else
      redirect_to movie_reservation_path(@reservation.schedule.movie, schedule_id: @reservation.schedule_id, date: @reservation.date), alert: "その座席はすでに予約済みです。"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :name, :email)
  end
end