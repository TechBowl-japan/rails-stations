class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @movie = Movie.find(params[:movie_id]) || Movie.first if params[:movie_id]
    @reservation = Reservation.new
    # TODO: 振り返り map利用
    if params[:movie_id]
      @schedules = @movie.schedules.map { |s| [s.start_time.strftime("%H:%M"), s.id] }
    else
      @schedules = Schedule.all.map { |s| [s.start_time.strftime("%H:%M"), s.id] }
    end
    @sheets = Sheet.includes(:reservations).all
  end

  def show
    @reservation = Reservation.find(params[:id])
    @movies = Movie.all
    @schedules = Schedule.where(movie_id: @reservation.schedule.movie.id)
  end

  def create
    schedule = Schedule.find(params[:reservation][:schedule_id])
    @reservation = Reservation.new(reservation_params.merge(date: schedule.start_time.to_date))
    if @reservation.save
      flash[:success] = "予約が完了しました"
      redirect_to admin_reservations_path
    else
      flash[:failed] = "その時間は予約できません"
      render :new, status: 400
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:success] = "予約が完了しました"
      redirect_to admin_reservation_path(@reservation), notice: '予約が更新されました'
    else
      @movies = Movie.all
      @schedules = Schedule.where(movie_id: @reservation.schedule.movie.id)
      render :edit, status: 400
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      redirect_to admin_reservations_path
    else
      render :show
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :name, :email)
  end
end
