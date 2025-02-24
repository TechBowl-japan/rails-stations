class ReservationsController < ApplicationController
  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movie_reservation_path(params[:movie_id], schedule_id: params[:schedule_id], date: params[:date]), alert: "座席を選択してください。" and return
    end

    @reservation = Reservation.new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    
    # スケジュールに関連するスクリーンの座席を取得（これを先にやる）
    @sheets = Sheet.where(screen_id: @schedule.screen_id)
    
    # 取得した座席のリストから、指定された `sheet_id` の座席を探す
    @sheet = @sheets.find_by(id: params[:sheet_id]) 
    

    # デバッグ用ログ出力
    Rails.logger.debug "Sheets for Screen #{@schedule.screen_id}: #{@sheets.map { |s| "#{s.row}-#{s.column}" }.join(', ')}"

    if Reservation.exists?(schedule_id: @schedule.id, sheet_id: @sheet.id, date: params[:date])
      redirect_to movie_reservation_path(@movie, schedule_id: @schedule.id, date: params[:date]), alert: "その座席はすでに予約済みです。" and return
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if Reservation.exists?(schedule_id: @reservation.schedule_id, sheet_id: @reservation.sheet_id, date: @reservation.date)
      redirect_to movie_reservation_path(@reservation.schedule.movie, schedule_id: @reservation.schedule_id, date: @reservation.date), alert: "その座席はすでに予約済みです。" and return
    end

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